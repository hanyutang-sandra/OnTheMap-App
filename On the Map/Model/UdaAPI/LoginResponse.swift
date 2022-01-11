//
//  LoginResponse.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/5/22.
//

import Foundation

struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}
