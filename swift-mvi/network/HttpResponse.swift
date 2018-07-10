import Foundation

struct HttpResponse<D: Decodable> {
    let statusCode: Int
    let body: D?

    init(statusCode: Int, body: D?) {
        self.statusCode = statusCode
        self.body = body
    }
}
