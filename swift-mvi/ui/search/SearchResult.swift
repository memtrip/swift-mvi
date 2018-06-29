import Foundation

enum SearchResult : MviResult {
case Idle
    case ChangePage(hint: String, page: SearchPage)
}
