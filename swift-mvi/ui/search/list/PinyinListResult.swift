import Foundation

enum PinyinListResult: MviResult {
    case Populate(pinyinList: Array<Pinyin>)
    case NavigateToDetails(pinyin: Pinyin)
    case PlayAudio(audioSrc: String)
    case OnError
}
