//
//  NetworkReachability.swift
//  Network_Practice
//
//  Created by 이지희 on 6/26/24.
//

import Foundation

import Alamofire

/// 네트워크 연결 여부를 확인하는 싱글톤 클래스 입니다
final class NetworkReachability {
    static let shared = NetworkReachability()
    
    /// Almofire에서 제공하는 네트워크 상태 매니저
    private let reachabilityManager = NetworkReachabilityManager()
    
    private init() {}
    
    /// 네트워크가 연결되었는지 확인하는 메서드
    ///
    /// 사용 예시
    /// ``` swift
    /// view.backgroundColor = NetworkReachability.shared.isReachable() ? .blue : .gray
    /// ```
    func isReachable() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    /// 네트워크 상태 모니터링 시작 
    ///
    /// 사용 예시
    /// ```
    /// NetworkReachability.shared.startMonitoring()
    /// ```
    func startMonitoring() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                print("네트워크 연결을 할 수 없습니다.")
            case .reachable(.cellular):
                print("셀룰러 데이터 연결")
            case .reachable(.ethernetOrWiFi):
                print("와이파이 연결")
            case .unknown:
                print("알 수 없는 네트워크 연결")
            }
        })
    }
    
    /// 네트워크 상태 모니터링 중지
    func stopMonitoring() {
        reachabilityManager?.stopListening()
    }
}
