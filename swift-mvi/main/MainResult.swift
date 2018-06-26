import Foundation

enum MainResult : MviResult {
    case InProgress
    case Pinyin
    case GenericError(String)
}
