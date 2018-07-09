import Foundation

struct PinyinDetailViewState : MxViewState, Copy, Equatable {
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
    
    static func ==(lhs: PinyinDetailViewState, rhs: PinyinDetailViewState) -> Bool {
        return lhs.phoneticScriptText == rhs.phoneticScriptText
            && lhs.englishTranslationText == rhs.englishTranslationText
            && lhs.chineseCharacters == rhs.chineseCharacters
            && lhs.audioSrc == rhs.audioSrc
    }
}

extension PinyinDetailViewState.Action: Equatable {
    
    static func ==(lhs: PinyinDetailViewState.Action, rhs: PinyinDetailViewState.Action) -> Bool {
        switch (lhs, rhs) {
        case (let .PlayAudio(url1), let .PlayAudio(url2)):
            return url1 == url2
        case (.None, .None):
            return true
        case (.Back, .Back):
            return true
        default:
            return false
        }
    }
}
