import Foundation
import Alamofire

protocol Connection {
    func request(
        _ url: URLConvertible,
        method: Alamofire.HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders?
    ) -> Alamofire.DataRequest
}

class ConnectionFactory {
    
    func create() -> Connection {
        return AlmoConnection()
    }
}
