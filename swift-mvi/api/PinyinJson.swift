import Foundation

struct PinyinJson: Decodable {
    let sourceUrl: String
    let phoneticScriptText: String
    let romanLetterText: String
    let englishTranslationText: String
    let chineseCharacters: String
    let characterImageSrc: String
    let audioSrc: String?
}
