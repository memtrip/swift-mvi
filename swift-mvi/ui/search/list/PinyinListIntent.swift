import Foundation

enum PinyinListIntent : MviIntent {
    case Search(terms: String)
    case SelectItem(pinyin: Pinyin)
    case PlayAudio(audioSrc: String)
}
