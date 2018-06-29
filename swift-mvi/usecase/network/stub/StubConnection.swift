import Foundation
import Alamofire

class StubConnection : Connection {
    
    func request(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders?
    ) -> DataRequest {
        fatalError("stub connection not implemented")
    }
}
