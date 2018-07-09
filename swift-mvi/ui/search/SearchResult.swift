import Foundation

enum SearchResult : MxResult {
case Idle
    case ChangePage(hint: String, page: SearchPage)
}
