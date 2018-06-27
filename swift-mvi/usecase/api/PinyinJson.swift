import Foundation
import ObjectMapper

class PinyinJson: HttpResponse {
    var sourceUrl: String?
    var phoneticScriptText: String?
    var romanLetterText: String?
    var audioSrc: String?
    var englishTranslationText: String?
    var chineseCharacters: String?
    var characterImageSrc: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        sourceUrl                   <- map["sourceUrl"]
        phoneticScriptText          <- map["phoneticScriptText"]
        romanLetterText             <- map["romanLetterText"]
        audioSrc                    <- map["audioSrc"]
        englishTranslationText      <- map["englishTranslationText"]
        chineseCharacters           <- map["chineseCharacters"]
        characterImageSrc           <- map["characterImageSrc"]
    }
}
