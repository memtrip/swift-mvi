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

class SavePinyin {
    
    func insert(pinyinJson: Array<PinyinJson>) -> Single<Array<Pinyin>> {
        
        let pinyin = pinyinJson.map { value -> Pinyin in
            
            let pinyin:Pinyin = Pinyin()
            
            pinyin.sourceUrl = value.sourceUrl!
            pinyin.phoneticScriptText = value.phoneticScriptText!
            pinyin.romanLetterText = value.romanLetterText!
            
            if let audioSrc = value.audioSrc {
                pinyin.audioSrc = audioSrc
            }
            
            pinyin.englishTranslationText = value.englishTranslationText!
            pinyin.chineseCharacters = value.chineseCharacters!
            pinyin.characterImageSrc = value.characterImageSrc!
            
            return pinyin
        }
        
        let pinyinDatabase = PinyinDatabase()
        pinyinDatabase.pinyin.append(objectsIn: pinyin)
        
        return Single<Array<Pinyin>>.create { single in
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(pinyinDatabase)
            }
            
            single(.success(pinyin))
            
            return Disposables.create()
        }
    }
}

class CountPinyin {
    
    func count() -> Single<Int> {
        return Single<Int>.create { single in
            let realm = try! Realm()
            let pinyin = realm.objects(Pinyin.self)
            
            single(.success(pinyin.count))
            
            return Disposables.create()
        }
    }
}

class PhoneticSearch {
    
    func search(terms: String) -> Single<Array<Pinyin>> {
        return Single<Array<Pinyin>>.create { single in
            let realm = try! Realm()
            
            let results = realm
                .objects(Pinyin.self)
                .filter("romanLetterText contains[c] %@", terms)
            
            single(.success(Array(results)))
            
            return Disposables.create()
        }
    }
}

class EnglishSearch {
    
    func search(terms: String) -> Single<Array<Pinyin>> {
        return Single<Array<Pinyin>>.create { single in
            let realm = try! Realm()
            
            let results = realm
                .objects(Pinyin.self)
                .filter("englishTranslationText contains[c] %@", terms)
            
            single(.success(Array(results)))
            
            return Disposables.create()
        }
    }
}

class CharacterSearch {
    
    func search(terms: String) -> Single<Array<Pinyin>> {
        return Single<Array<Pinyin>>.create { single in
            let realm = try! Realm()
            
            let results = realm
                .objects(Pinyin.self)
                .filter("chineseCharacters contains[c] %@", terms)
            
            single(.success(Array(results)))
            
            return Disposables.create()
        }
    }
}
