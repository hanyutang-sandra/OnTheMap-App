//
//  PostStudentLocation.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/9/22.
//

import Foundation

struct PostStudentLocation: Codable {
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
}
