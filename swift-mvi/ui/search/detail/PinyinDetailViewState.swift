import Foundation

struct PinyinDetailViewState: MxViewState, Copy, Equatable {
    var phoneticScriptText: String
    var englishTranslationText: String
    var chineseCharacters: String
    var audioSrc: String
    var action: Action

    enum Action {
        case none
        case playAudio(url: String)
        case back
    }

    static func == (lhs: PinyinDetailViewState, rhs: PinyinDetailViewState) -> Bool {
        return lhs.phoneticScriptText == rhs.phoneticScriptText
            && lhs.englishTranslationText == rhs.englishTranslationText
            && lhs.chineseCharacters == rhs.chineseCharacters
            && lhs.audioSrc == rhs.audioSrc
    }
}

extension PinyinDetailViewState.Action: Equatable {

    static func == (lhs: PinyinDetailViewState.Action, rhs: PinyinDetailViewState.Action) -> Bool {
        switch (lhs, rhs) {
        case (let .playAudio(url1), let .playAudio(url2)):
            return url1 == url2
        case (.none, .none):
            return true
        case (.back, .back):
            return true
        default:
            return false
        }
    }
}
