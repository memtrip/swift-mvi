import Foundation
import RxSwift
import RealmSwift

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
