//
//  RequestObject.swift
//  Movies
//
//  Created by RAJEEV MAHAJAN on 26/02/25.
//

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol RequestObject {
    var method: HttpMethods { get }
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var queryParams: [String: String]? { get }
    var bodyParams: [String:Any]? { get }
}
