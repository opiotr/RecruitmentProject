//
//  Endpoint.swift
//  RecruitmentProject
//
//  Created by Piotr Olech on 10/04/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Alamofire

final class Endpoint<Response> {
    let path: String
    let method: HTTPMethod
    let parameters: Parameters?
    let encoding: ParameterEncoding
    let headers: HTTPHeaders?
    let decode: (Data) throws -> Response
    
    init(path: String,
         method: HTTPMethod = .get,
         parameters: Parameters? = nil,
         encoding: ParameterEncoding = URLEncoding.default,
         headers: HTTPHeaders? = nil,
         decode: @escaping (Data) throws -> Response) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
        self.decode = decode
    }
}

// MARK: - Convenience init

extension Endpoint where Response: Decodable {
    convenience init(method: HTTPMethod = .get,
                     path: String,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: HTTPHeaders? = nil) {
        self.init(path: path, method: method, parameters: parameters, encoding: encoding, headers: headers) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Response.self, from: $0)
        }
    }
}
