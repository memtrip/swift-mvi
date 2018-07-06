import Foundation
import RealmSwift

class Pinyin: Object {
    @objc dynamic var sourceUrl = ""
    @objc dynamic var phoneticScriptText = ""
    @objc dynamic var romanLetterText = ""
    @objc dynamic var audioSrc = ""
    @objc dynamic var englishTranslationText = ""
    @objc dynamic var chineseCharacters = ""
    @objc dynamic var characterImageSrc = ""
}
