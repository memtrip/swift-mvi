import Foundation

enum SearchIntent: MxIntent {
    case idle
    case searchHint(page: SearchPage)
}
