//
//  endpoints.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/5/22.
//

import Foundation

enum EndPoints {
    static let BASE = "https://onthemap-api.udacity.com/v1"
    static let MAX_LOCATION_LIMIT = 100
    static let ORDER = "-updatedAt"
    
    case login
    case websiteLogin
    case getStudentInfo
    case getStudentLocations
    case postStudentLocation
    case updateStudentLocation
    
    var stringValue: String {
        switch self {
        case .login: return EndPoints.BASE + "/session"
        case .websiteLogin: return "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com"
        case .getStudentInfo: return EndPoints.BASE + "/users/" + Auth.accountId
        case .getStudentLocations: return EndPoints.BASE + "/StudentLocation" + "?limit=\(EndPoints.MAX_LOCATION_LIMIT)&order=\(EndPoints.ORDER)"
        case .postStudentLocation: return EndPoints.BASE + "/StudentLocation"
        case .updateStudentLocation: return EndPoints.BASE + "/StudentLocation/" + StudentLocationModel.objectId
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
