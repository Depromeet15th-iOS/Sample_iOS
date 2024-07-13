//
//  Endpoint.swift
//  Network_Practice
//
//  Created by 이지희 on 6/12/24.
//

import Foundation

import Alamofire

/// APIEndPoint 생성 예시
/// enum으로 선언한 이유?
// MARK: - UserEndpoint
enum WeatherEndpoint {
    case getWeather
}

extension WeatherEndpoint: APIEndpoint {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getWeather:
            return ["lat" : 44.34,
                    "lon": 10.99,
                    "appid": Config.apiKey]
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getWeather:
            return ["Content-Type": "application/json"]
        }
    }
}
