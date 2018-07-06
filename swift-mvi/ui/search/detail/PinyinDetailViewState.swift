import Foundation

struct PinyinDetailViewState : MviViewState, Copy {
    var phoneticScriptText: String
    var englishTranslationText: String
    var chineseCharacters: String
    var audioSrc: String
    var action: Action
    
    enum Action {
        case None
        case PlayAudio(url: String)
        case Back
    }
}
