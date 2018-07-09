import Foundation

enum PinyinListIntent : MxIntent {
    case Idle
    case Search(terms: String)
    case SelectItem(pinyin: Pinyin)
}
