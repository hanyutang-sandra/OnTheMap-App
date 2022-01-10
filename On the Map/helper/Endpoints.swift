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
    case websiteLogin
    case getStudentLocations
    
    var stringValue: String {
        switch self {
        case .login: return EndPoints.base + "/session"
        case .websiteLogin: return "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com"
        case .getStudentLocations: return EndPoints.base + "/StudentLocation" + "?limit=100&order=-updatedAt"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
