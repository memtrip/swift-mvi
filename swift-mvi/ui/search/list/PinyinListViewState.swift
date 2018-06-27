import Foundation

enum PinyinListViewState: MviViewState {
    case Populate(pinyinList: Array<Pinyin>)
    case NavigateToDetails(pinyin: Pinyin)
    case PlayAudio(audioSrc: String)
    case OnError
}
