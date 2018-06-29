import Foundation

struct ErrorJson: Decodable {
    let code: Int
    let body: String
}
