import Foundation
import RxSwift
import RealmSwift

protocol PinyinSearch {
    func query(terms: String) -> Single<[Pinyin]>
}

class PhoneticSearch: PinyinSearch {

    func query(terms: String) -> Single<[Pinyin]> {
        return Single<[Pinyin]>.create { single in
            if let realm = try? Realm() {
                let results = realm
                    .objects(Pinyin.self)
                    .filter("romanLetterText contains[c] %@", terms)

                single(.success(Array(results)))
            } else {
                single(.error(ConnectionError()))
            }

            return Disposables.create()
        }
    }
}

class EnglishSearch: PinyinSearch {

    func query(terms: String) -> Single<[Pinyin]> {
        return Single<[Pinyin]>.create { single in

            if let realm = try? Realm() {
                let results = realm
                    .objects(Pinyin.self)
                    .filter("englishTranslationText contains[c] %@", terms)

                single(.success(Array(results)))
            } else {
                single(.error(ConnectionError()))
            }

            return Disposables.create()
        }
    }
}

class CharacterSearch: PinyinSearch {

    func query(terms: String) -> Single<[Pinyin]> {
        return Single<[Pinyin]>.create { single in
            if let realm = try? Realm() {
                let results = realm
                    .objects(Pinyin.self)
                    .filter("chineseCharacters contains[c] %@", terms)

                single(.success(Array(results)))
            } else {
                single(.error(ConnectionError()))
            }

            return Disposables.create()
        }
    }
}
