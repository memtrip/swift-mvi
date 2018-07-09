import Foundation

enum SearchIntent : MxIntent {
    case Idle
    case SearchHint(page: SearchPage)
}
