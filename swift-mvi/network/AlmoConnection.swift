import Foundation
import Alamofire

class AlmoConnection: Connection {

    func request(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders?
    ) -> DataRequest {
        return Alamofire.request(
            url,
            method: method,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers)
    }
}
