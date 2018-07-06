import Foundation
import RxSwift
import RealmSwift

class PinyinDatabase: Object {
    let pinyin = List<Pinyin>()
}

class Pinyin: Object {
    @objc dynamic var sourceUrl = ""
    @objc dynamic var phoneticScriptText = ""
    @objc dynamic var romanLetterText = ""
    @objc dynamic var audioSrc = ""
    @objc dynamic var englishTranslationText = ""
    @objc dynamic var chineseCharacters = ""
    @objc dynamic var characterImageSrc = ""
}
