//
//  APIServiceError.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case networkError
    case parseError(Error)
    case locationNotFound
    
    var localizedDescription: String {
        switch self {
        case .responseError: return "network error"
        case .parseError: return "Invalid response from server, error in typing."
        case .networkError: return "Network Connection Fail."
        case .locationNotFound: return "Your current location not found."
        }
    }
}

