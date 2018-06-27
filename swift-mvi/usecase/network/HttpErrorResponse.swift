import Foundation

struct HttpErrorResponse: Error {
    var code: Int
    var body: String
}
