import Foundation

enum PinyinListIntent: MxIntent {
    case idle
    case search(terms: String)
    case selectItem(pinyin: Pinyin)
}
