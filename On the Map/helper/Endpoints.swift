//
//  endpoints.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/5/22.
//

import Foundation

enum EndPoints {
    static let base = "https://onthemap-api.udacity.com/v1"
    
    case login
    
    var stringValue: String {
        switch self {
        case .login: return EndPoints.base + "/session"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
