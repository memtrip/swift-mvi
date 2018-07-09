import Foundation

enum PinyinListViewState: MviViewState {
    case Idle
    case Populate(pinyinList: Array<Pinyin>)
    case NavigateToDetails(pinyin: Pinyin)
    case OnError
}
