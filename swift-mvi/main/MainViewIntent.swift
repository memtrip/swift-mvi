import Foundation

enum MainViewIntent : MviIntent {
    case Init(userId: String)
    case LoadPinyin
}
