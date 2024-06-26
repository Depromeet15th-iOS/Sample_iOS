//
//  Repository.swift
//  Network_Practice
//
//  Created by 이지희 on 6/12/24.
//

import Foundation

import RxSwift

/// Repository Interface : 데이터 소스를 추상화하는 인터페이스
protocol WeatherRepository {
    func getWeather() -> Single<GetWeatherResponseDTO>
}
