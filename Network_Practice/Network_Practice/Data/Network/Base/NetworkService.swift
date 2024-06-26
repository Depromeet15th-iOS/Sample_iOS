import Foundation
import Alamofire
import RxAlamofire
import RxSwift

// MARK: - NetworkError
/// NetworkError: 네트워크 요청 중 발생할 수 있는 에러 타입을 정의
enum NetworkError: Error {
    case serverError(statusCode: Int)
    case decodingError(Error)
    case unknown(Error)
}

// MARK: - NetworkService
/// NetworkService: 네트워크 서비스 프로토콜 정의
/// 네트워크 요청을 수행하는 메서드를 정의합니다.
protocol NetworkServiceProtocol {
    /// request(:) 메서드는 APIEndpoint 프로토콜을 준수하는 엔드포인트를 받아 Single<T> 타입의 Observable을 반환합니다.
    /// 공통되는 엔티티를 사용하기 위해 BaseResponse를 사용합니다. 
    func request<T: Decodable>(endpoint: APIEndpoint) -> Single<T>
}

class NetworkService: NetworkServiceProtocol {
    /// request(:) 메서드는 APIEndpoint 프로토콜을 준수하는 엔드포인트를 받아 네트워크 요청을 수행합니다.
    /// - Parameter endpoint: APIEndpoint 프로토콜을 준수하는 엔드포인트
    /// - Returns: Single<T> 타입의 Observable
    func request<T: Decodable>(endpoint: APIEndpoint) -> Single<T> {
        /// url 생성
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        /// 헤더 타입 변경
        let headers = endpoint.headers != nil ? HTTPHeaders(endpoint.headers!) : nil

        return RxAlamofire.requestJSON(endpoint.method, url, parameters: endpoint.parameters, headers: headers)
            .debug()
            .flatMap { response, data -> Single<T> in
                do {
                    if !(200...403).contains(response.statusCode) {
                        throw NetworkError.serverError(statusCode: response.statusCode)
                    }
                    let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    return .just(decodedObject)
                } catch {
                    return .error(NetworkError.decodingError(error))
                }
            }
            .asSingle()
            .catchError { error in
                if let afError = error as? AFError,
                   let statusCode = afError.responseCode {
                    return .error(NetworkError.serverError(statusCode: statusCode))
                } else {
                    return .error(NetworkError.unknown(error))
                }
            }
    }
}
