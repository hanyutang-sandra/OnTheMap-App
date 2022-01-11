//
//  GetStudentLocationResponse.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/9/22.
//

import Foundation

struct GetStudentLocationResponse: Codable {
    let results: [StudentLocation]
}

struct StudentLocation: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}


