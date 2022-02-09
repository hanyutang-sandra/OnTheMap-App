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
    case locationDownloadError
    case locationPostingError
    case unknowError
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("Connection failed.", comment: "")
        case .dataParsingError:
            return NSLocalizedString("Unable to parse the response.", comment: "")
        case .incorrectLoginCredentialsError:
            return NSLocalizedString("Incorrect email or password.", comment: "")
        case .geoCodingError:
            return NSLocalizedString("Geocoding failed.", comment: "")
        case .locationDownloadError:
            return NSLocalizedString("Location Download failed.", comment: "")
        case .locationPostingError:
            return NSLocalizedString("Location posting failed.", comment: "")
        case .unknowError:
            return NSLocalizedString("Unknown error occured", comment: "")
        }
    }
}

