import XCTest
import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking

@testable import swift_mvi

class PinyinListViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("PinyinListViewModel returning results successfully") {
            
            class PinyinSearchMock : PinyinSearch {
                
                let searchResults: Array<Pinyin>
                
                init(searchResults: Array<Pinyin>) {
                    self.searchResults = searchResults
                }
                
                func query(terms: String) -> Single<Array<Pinyin>> {
                    return Single.just(searchResults)
                }
            }
            
            let expectedSearchResults = [Pinyin()]
            
            let viewModel = PinyinListViewModel(search: PinyinSearchMock(searchResults: expectedSearchResults), defaultSearchTerm: "")
            
            describe("search characters") {
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(PinyinListViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(PinyinListIntent.Search(terms: "寻找")))
                
                scheduler.start()
                
                it("should show pinyin search results") {
                    expect(results.events[0].value.element == PinyinListViewState.Populate(pinyinList: expectedSearchResults)).to(beTrue())
                }
            }
        }
            
        describe("PinyinListViewModel returning results successfully") {
            
            class PinyinSearchMock : PinyinSearch {
                
                let searchResults: Array<Pinyin>
                
                init(searchResults: Array<Pinyin>) {
                    self.searchResults = searchResults
                }
                
                func query(terms: String) -> Single<Array<Pinyin>> {
                    return Single.just(searchResults)
                }
            }
            
            let expectedSearchResults = [Pinyin()]
            
            let viewModel = PinyinListViewModel(search: PinyinSearchMock(searchResults: expectedSearchResults), defaultSearchTerm: "")
            
            describe("select item") {
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(PinyinListViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(PinyinListIntent.SelectItem(pinyin: expectedSearchResults[0])))
                
                scheduler.start()
                
                it("should navigate to pinyin details") {
                    expect(results.events[0].value.element == PinyinListViewState.NavigateToDetails(pinyin: expectedSearchResults[0])).to(beTrue())
                }
            }
        }
        
        describe("PinyinListViewModel failed to return results") {
            
            class GenericError : Error { }
            
            class PinyinSearchMock : PinyinSearch {
                
                func query(terms: String) -> Single<Array<Pinyin>> {
                    return Single.error(GenericError())
                }
            }
            
            let viewModel = PinyinListViewModel(search: PinyinSearchMock(), defaultSearchTerm: "")
            
            describe("select item") {
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(PinyinListViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(PinyinListIntent.Search(terms: "寻找")))
                
                scheduler.start()
                
                it("should navigate to pinyin details") {
                    expect(results.events[0].value.element == PinyinListViewState.OnError).to(beTrue())
                }
            }
        }
    }
}
