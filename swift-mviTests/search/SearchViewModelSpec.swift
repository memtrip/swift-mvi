import XCTest
import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking

@testable import swift_mvi

class SearchViewModelSpec: QuickSpec {
    
    override func spec() {

        describe("SearchViewModel") {
            
            let viewModel = SearchViewModel(
                initialState: SearchViewState(hint: "", page: SearchPage.phonetic))
            
            describe("selected with phonetic tab") {
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(SearchViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(SearchIntent.searchHint(page: SearchPage.phonetic)))
                
                scheduler.start()
                
                it("should show pinyin loaded") {
                    expect(results.events[0].value.element == SearchViewState(
                        hint: "Search phonetic pinyin...",
                        page: SearchPage.phonetic)
                    ).to(beTrue())
                }
            }
        }
        
        describe("SearchViewModel") {
            
            let viewModel = SearchViewModel(
                initialState: SearchViewState(hint: "", page: SearchPage.phonetic))
            
            describe("selected with english tab") {
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(SearchViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(SearchIntent.searchHint(page: SearchPage.English)))
                
                scheduler.start()
                
                it("should show pinyin loaded") {
                    expect(results.events[0].value.element == SearchViewState(
                        hint: "Search english translations...",
                        page: SearchPage.english)
                    ).to(beTrue())
                }
            }
        }
        
        describe("SearchViewModel") {
            
            let viewModel = SearchViewModel(
                initialState: SearchViewState(hint: "", page: SearchPage.phonetic))
            
            describe("selected with character tab") {
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(SearchViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(SearchIntent.searchHint(page: SearchPage.Character)))
                
                scheduler.start()
                
                it("should show pinyin loaded") {
                    expect(results.events[0].value.element == SearchViewState(
                        hint: "寻找汉语词典",
                        page: SearchPage.character)
                    ).to(beTrue())
                }
            }
        }
    }
}
