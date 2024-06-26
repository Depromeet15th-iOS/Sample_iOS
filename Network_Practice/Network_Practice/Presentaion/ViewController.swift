//
//  ViewController.swift
//  Network_Practice
//
//  Created by 이지희 on 6/10/24.
//

import UIKit

import RxSwift

final class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    let weatherRepository: WeatherRepository = WeatherRepositoryImpl(networkService: NetworkService())
    let weatherUsecase: WeatherUseCase
    
    init() {
        self.weatherUsecase = WeatherUseCaseImpl(weatherRepository: weatherRepository)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = NetworkReachability.shared.isReachable() ? .blue : .gray
        fetchUsers()
    }
    
    private func fetchUsers() {
        weatherUsecase.getWeather()
            .subscribe(onSuccess: { respones in
                print("☁️ \(respones.clouds)")
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
