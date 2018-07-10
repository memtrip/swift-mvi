import Foundation
import Alamofire

struct HttpRequest {
    let url: String
    let method: HTTPMethod
    let headers: HTTPHeaders
    let params: Parameters? = nil
}
