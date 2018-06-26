import Foundation

enum MainViewState : MviViewState {
    case InProgress
    case GenericError(error: String)
    case Pinyin
}
