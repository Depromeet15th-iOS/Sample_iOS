//
//  UseCase.swift
//  Network_Practice
//
//  Created by 이지희 on 6/12/24.
//

import Foundation
import RxSwift

///UseCase 비즈니스 로직 처리
protocol WeatherUseCase {
    func getWeather() -> Single<GetWeatherResponseDTO>
}

class WeatherUseCaseImpl: WeatherUseCase {
    private let weatherRepository: WeatherRepository

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func getWeather() -> Single<GetWeatherResponseDTO> {
        return weatherRepository.getWeather()
    }
}
