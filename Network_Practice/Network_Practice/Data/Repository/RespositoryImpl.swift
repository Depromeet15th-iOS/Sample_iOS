//
//  RespositoryImpl.swift
//  Network_Practice
//
//  Created by 이지희 on 6/12/24.
//

import Foundation

import RxSwift

/// 실제 데이터 소스 접근 구현부
class WeatherRepositoryImpl: WeatherRepository {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func getWeather() -> Single<GetWeatherResponseDTO> {
        return networkService.request(endpoint: WeatherEndpoint.getWeather)
    }
}
