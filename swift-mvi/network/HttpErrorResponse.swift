import Foundation

struct HttpErrorResponse<E: Decodable> : Error {
    let statusCode: Int
    let body: E?

    init(statusCode: Int, body: E?) {
        self.statusCode = statusCode
        self.body = body
    }
}
