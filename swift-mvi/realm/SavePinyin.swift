import Foundation
import RxSwift
import RealmSwift

class SavePinyin {

    func insert(pinyinJson: [PinyinJson]) -> Single<[Pinyin]> {

        return Single<[Pinyin]>.create { single in

            let pinyin = pinyinJson.map { value -> Pinyin in

                let pinyin: Pinyin = Pinyin()

                pinyin.sourceUrl = value.sourceUrl
                pinyin.phoneticScriptText = value.phoneticScriptText
                pinyin.romanLetterText = value.romanLetterText
                pinyin.englishTranslationText = value.englishTranslationText
                pinyin.chineseCharacters = value.chineseCharacters
                pinyin.characterImageSrc = value.characterImageSrc

                if let audioSrc = value.audioSrc {
                    pinyin.audioSrc = audioSrc
                }

                return pinyin
            }

            if let realm = try? Realm() {
                try? realm.write {
                    realm.add(pinyin)
                }

                single(.success(pinyin))
            } else {
                single(.error(ConnectionError()))
            }

            return Disposables.create()
        }
    }
}
