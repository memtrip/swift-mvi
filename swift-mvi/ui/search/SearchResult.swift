import Foundation

enum SearchResult: MxResult {
    case idle
    case page(hint: String, page: SearchPage)
}
