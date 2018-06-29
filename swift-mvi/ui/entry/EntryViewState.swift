import Foundation

enum EntryViewState : MviViewState {
    case Idle
    case InProgress
    case OnPinyinLoaded
    case GenericError
}
