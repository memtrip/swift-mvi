import Foundation

enum PinyinListIntent : MviIntent {
    case Idle
    case Search(terms: String)
    case SelectItem(pinyin: Pinyin)
}
