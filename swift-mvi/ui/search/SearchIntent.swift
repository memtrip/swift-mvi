import Foundation

enum SearchIntent : MviIntent {
    case Idle
    case SearchHint(page: SearchPage)
}
