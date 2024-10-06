//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    enum Input {
        case onAppear
        case onSearch(searchArray: [String])
    }
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        case .onSearch(let searchArray):
            guard Reachability.isConnectedToNetwork == true else {
                self.errorSubject.send(APIServiceError.networkError)
                self.isLoading = false
                return
            }
            onSearchSubject.send(searchArray)
        }
    }
    
    private var cancellables: [AnyCancellable] = []
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let onSearchSubject = PassthroughSubject<[String], APIServiceError>()
    private let responseSubject = PassthroughSubject<WeatherResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()

    private let apiService: APIServiceType

    @Published private(set) var currentWeather = [PresentableWeather]()
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var searchText: String {
        didSet(oldValue) {
            let allowingChars = Constant.ALLOWED_CHAR
            let numberOnly = NSCharacterSet.init(charactersIn: allowingChars).inverted
            if searchText.rangeOfCharacter(from: numberOnly) != nil {
                searchText = oldValue
            }
        }
    }
    private var searchArray: [String] {
        let arry = self.searchText.components(separatedBy: ",").map({ $0.trimmingCharacters(in: .whitespaces) })
        return arry
    }
    private var localWeather: [WeatherResponse] {
        didSet {
            if searchArray.count == localWeather.count {
                isLoading = false
                currentWeather = getPresentableData(localWeather)
            }
        }
    }
    
    init(apiService: APIServiceType = APIService()) {
        self.apiService = apiService
        self.localWeather = [WeatherResponse]()
        searchText = ""
        bindInputs()
        bindOutputs()
    }
    
    func validateSearchArray() {
        let array = searchArray
            isLoading = true
            currentWeather.removeAll()
            localWeather.removeAll()
            apply(.onSearch(searchArray: array))
    }

    private func bindInputs() {
        let responsePublisher = onSearchSubject
            .flatMap { (values) -> Publishers.MergeMany<AnyPublisher<WeatherResponse, APIServiceError>> in
            let tasks = values.map { (searchStr) -> AnyPublisher<WeatherResponse, APIServiceError> in
                let params = ["q": searchStr, "appid": Environment.API_KEY]
                let request = WeatherRequest(params)
                return self.apiService.response(from: request)
            }
                return Publishers.MergeMany(tasks)
        }.compactMap({ $0 }).sink(receiveCompletion: { (completion) in
            if case .failure(let error) = completion {
                self.errorSubject.send(error)
                self.isLoading = false
                self.currentWeather = self.getPresentableData(self.localWeather)
                self.bindInputs()
                print("Got error: \(error.localizedDescription)")
            }
        }) { (results) in
            self.localWeather.append(results)
        }
                
        cancellables.append(responsePublisher)
        
    }
    
    private func bindOutputs() {
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                error.localizedDescription
            }
            .assign(to: \.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.isErrorShown, on: self)
                
        cancellables += [
            errorStream,
            errorMessageStream
        ]
    }
    
    private func getPresentableData(_ weatherRes: [WeatherResponse]) -> [PresentableWeather] {
        var result = [PresentableWeather]()
        weatherRes.forEach { (weather) in
            result.append(PresentableWeather(name: weather.name ?? "", weather: [weather]))
        }
        return result
    }
}
