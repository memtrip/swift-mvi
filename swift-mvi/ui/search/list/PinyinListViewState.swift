import Foundation

enum PinyinListViewState: MxViewState {
    case idle
    case populate(pinyinList: [Pinyin])
    case navigateToDetails(pinyin: Pinyin)
    case error
}

extension PinyinListViewState: Equatable {

    static func == (lhs: PinyinListViewState, rhs: PinyinListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (let .populate(list1), let .populate(list2)):
            return list1 == list2
        case (let .navigateToDetails(pinyin1), let .navigateToDetails(pinyin2)):
            return pinyin1 == pinyin2
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}
