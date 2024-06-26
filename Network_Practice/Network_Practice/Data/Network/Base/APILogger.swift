import Foundation

import Alamofire


///API 통신 로거 입니다. 세션 생성 시 PlugIn으로 넣어서 사용합니다
///
final class APIEventLogger: EventMonitor {
    /// Request에 대한 로그
    func requestDidFinish(_ request: Request) {
        print("===========================🛰 NETWORK Reqeust LOG===========================")
        print(request.description)
        
        print(
            "URL: " + (request.request?.url?.absoluteString ?? "")  + "\n"
            + "Method: " + (request.request?.httpMethod ?? "") + "\n"
            + "Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
        )
        print("Authorization: " + (request.request?.headers["Authorization"] ?? ""))
        print("Body: " + (request.request?.httpBody?.toPrettyPrintedString ?? ""))
    }
    
    /// Response에 대한 로그 (Response 파싱 이후 Print)
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("===========================🛰 NETWORK Response LOG===========================")
        print(
            "URL: " + (request.request?.url?.absoluteString ?? "") + "\n"
            + "Result: " + "\(response.result)" + "\n"
            + "StatusCode: " + "\(response.response?.statusCode ?? 0)" + "\n"
            + "Data: \(response.data?.toPrettyPrintedString ?? "")"
        )
    }
    
}

extension Data {
    /// Data를 String으로 출력할 때 포맷팅
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString as String
    }
    
}
