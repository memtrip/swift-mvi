import Foundation

enum PinyinListResult: MxResult {
    case idle
    case populate(pinyinList: [Pinyin])
    case navigateToDetails(pinyin: Pinyin)
    case error
}
