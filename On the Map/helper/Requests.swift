//
//  Requests.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/5/22.
//

import Foundation

class Requests {
    static func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = LoginRequest(udacity: UdaRequest(username: email, password: password))
        taskForPOSTRequest(url: EndPoints.login.url, body: body, responseType: LoginResponse.self) { response, error in
            if let response = response {
                Auth.accountId = response.account.key
                Auth.sessionId = response.session.id
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}

extension Requests {
    static func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {}
    
    static func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, body:RequestType, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let cleanData = skippingSecurityCoding(data: data)
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(responseType.self, from: cleanData)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    static func skippingSecurityCoding(data: Data) -> Data {
        let newData = data.subdata(in: 5..<data.count)
        return newData
    }
}