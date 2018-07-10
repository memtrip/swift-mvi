import XCTest
import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking

@testable import swift_mvi

class EntryViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("EntryViewModel with 1 pinyin entry") {
            
            class CountPinyinMock : CountPinyin {
                func count() -> Single<Int> {
                    return Single.just(1)
                }
            }
            
            class FetchAndSavePinyinMock : FetchAndSavePinyin {
                func save() -> Single<[Pinyin]> {
                    return Observable.empty().asSingle()
                }
            }
            
            describe("pinyin entries already exist") {
                
                let viewModel = EntryViewModel(
                    countPinyin: CountPinyinMock(),
                    fetchAndSavePinyin: FetchAndSavePinyinMock(),
                    initialState: EntryViewState.idle)
            
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(EntryViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(EntryIntent.init))
                
                scheduler.start()
                
                it("should show pinyin loaded") {
                    expect(results.events[0].value.element).to(equal(EntryViewState.progress))
                    expect(results.events[1].value.element).to(equal(EntryViewState.pinyinLoaded))
                }
            }
        }
        
        describe("EntryViewModel cannot count entries") {
            
            class GenericError : Error { }
            
            class CountPinyinMock : CountPinyin {
                func count() -> Single<Int> {
                    return Single<Int>.error(GenericError())
                }
            }
            
            class FetchAndSavePinyinMock : FetchAndSavePinyin {
                func save() -> Single<[Pinyin]> {
                    return Observable.empty().asSingle()
                }
            }
            
            describe("pinyin failed to count entries") {
                
                let viewModel = EntryViewModel(
                    countPinyin: CountPinyinMock(),
                    fetchAndSavePinyin: FetchAndSavePinyinMock(),
                    initialState: EntryViewState.idle)
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(EntryViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(EntryIntent.init))
                
                scheduler.start()
                
                it("should show pinyin loaded") {
                    expect(results.events[0].value.element).to(equal(EntryViewState.progress))
                    expect(results.events[1].value.element).to(equal(EntryViewState.error))
                }
            }
        }
        
        describe("EntryViewModel with 0 pinyin entries") {
            
            class CountPinyinMock : CountPinyin {
                func count() -> Single<Int> {
                    return Single.just(0)
                }
            }
            
            class FetchAndSavePinyinMock : FetchAndSavePinyin {
                func save() -> Single<[Pinyin]> {
                    return Single.just([Pinyin()])
                }
            }
            
            describe("pinyin entries are fetched") {
                
                let viewModel = EntryViewModel(
                    countPinyin: CountPinyinMock(),
                    fetchAndSavePinyin: FetchAndSavePinyinMock(),
                    initialState: EntryViewState.idle)
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(EntryViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(EntryIntent.init))
                
                scheduler.start()
                
                it("should show pinyin loaded") {
                    expect(results.events[0].value.element).to(equal(EntryViewState.progress))
                    expect(results.events[1].value.element).to(equal(EntryViewState.pinyinLoaded))
                }
            }
        }
        
        describe("EntryViewModel cannot fetch entries") {
            
            class GenericError : Error { }
            
            class CountPinyinMock : CountPinyin {
                func count() -> Single<Int> {
                    return Single.just(0)
                }
            }
            
            class FetchAndSavePinyinMock : FetchAndSavePinyin {
                func save() -> Single<[Pinyin]> {
                    return Single<[Pinyin]>.error(GenericError())
                }
            }
            
            describe("pinyin failed to fetch entries") {
                
                let viewModel = EntryViewModel(
                    countPinyin: CountPinyinMock(),
                    fetchAndSavePinyin: FetchAndSavePinyinMock(),
                    initialState: EntryViewState.idle)
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(EntryViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(EntryIntent.init))
                
                scheduler.start()
                
                it("should show pinyin loaded") {
                    expect(results.events[0].value.element).to(equal(EntryViewState.progress))
                    expect(results.events[1].value.element).to(equal(EntryViewState.error))
                }
            }
        }
    }
}
