import Foundation
import RxSwift
import RealmSwift

protocol PinyinSearch {
    func query(terms: String) -> Single<Array<Pinyin>>
}

class PhoneticSearch : PinyinSearch {
    
    func query(terms: String) -> Single<Array<Pinyin>> {
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

class EnglishSearch : PinyinSearch {
    
    func query(terms: String) -> Single<Array<Pinyin>> {
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

class CharacterSearch : PinyinSearch {
    
    func query(terms: String) -> Single<Array<Pinyin>> {
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
