import Foundation

enum PinyinListViewState: MxViewState {
    case Idle
    case Populate(pinyinList: Array<Pinyin>)
    case NavigateToDetails(pinyin: Pinyin)
    case OnError
}

extension PinyinListViewState: Equatable {
    
    static func ==(lhs: PinyinListViewState, rhs: PinyinListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.Idle, .Idle):
            return true
        case (let .Populate(list1), let .Populate(list2)):
            return list1 == list2
        case (let .NavigateToDetails(pinyin1), let .NavigateToDetails(pinyin2)):
            return pinyin1 == pinyin2
        case (.OnError, .OnError):
            return true
        default:
            return false
        }
    }
}
