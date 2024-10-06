//
//  Utility.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import Foundation
import UIKit

struct Constant {
    static let YYYY_MM_dd_HH_mm_ss = "YYYY-MM-dd HH:mm:ss"
    static let HH_mm = "HH:mm"
    static let MMM_d_YYYY = "MMM d"
    static let ALLOWED_CHAR = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ,"
}

extension Double {
    var celcius: Double {
        return (self - 273.15)
    }
    var formattedCelcius: String {
        return String(format: "%0.2f", celcius)
    }
}

extension Array where Element: Equatable {
    func removingDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
