//
//  AppError.swift
//  On the Map
//
//  Created by Hanyu Tang on 2/9/22.
//

import Foundation

enum AppError:Error {
    case networkError
    case dataParsingError
    case incorrectLoginCredentialsError
    case geoCodingError
    case unknowError
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("Connection failed. Please try again later.", comment: "")
        case .dataParsingError:
            return NSLocalizedString("Invalid response.", comment: "")
        case .incorrectLoginCredentialsError:
            return NSLocalizedString("Incorrect email or password.", comment: "")
        case .geoCodingError:
            return NSLocalizedString("Geocoding failed.", comment: "")
        case .unknowError:
            return NSLocalizedString("Unknown error occured", comment: "")
        }
    }
}

