import Foundation
import RxSwift
import RealmSwift

class CountPinyinImpl: CountPinyin {

    func count() -> Single<Int> {
        return Single<Int>.create { single in
            if let realm = try? Realm() {
                let pinyin = realm.objects(Pinyin.self)
                single(.success(pinyin.count))
            } else {
                single(.error(ConnectionError()))
            }

            return Disposables.create()
        }
    }
}

protocol CountPinyin {
    func count() -> Single<Int>
}
