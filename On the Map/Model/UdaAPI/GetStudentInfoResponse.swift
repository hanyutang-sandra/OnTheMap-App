//
//  GetStudentInfoResponse.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/9/22.
//

import Foundation

struct GetStudentInfoResponse: Codable {
    let firstName: String
    let lastName: String
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case key
    }
}
