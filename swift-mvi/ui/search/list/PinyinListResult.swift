import Foundation

enum PinyinListResult: MxResult {
    case Idle
    case Populate(pinyinList: Array<Pinyin>)
    case NavigateToDetails(pinyin: Pinyin)
    case OnError
}
