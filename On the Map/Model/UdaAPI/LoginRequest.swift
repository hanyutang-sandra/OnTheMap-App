//
//  LoginRequest.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/5/22.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: UdaRequest
}

struct UdaRequest: Codable {
    let username: String
    let password: String
}
