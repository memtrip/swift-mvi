import Foundation
import ObjectMapper

class PinyinWrapperJson: HttpResponse {
    var pinyin: Array<PinyinJson>?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        pinyin    <- map["pinyin"]
    }
}
