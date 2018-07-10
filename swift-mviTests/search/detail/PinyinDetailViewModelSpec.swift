import XCTest
import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking

@testable import swift_mvi

class PinyinDetailViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("PinyinDetailViewModel without audioSrc") {
            
            let viewModel = PinyinDetailViewModel(
                initialState: PinyinDetailViewState(
                    phoneticScriptText: "pinyin",
                    englishTranslationText: "pinyin",
                    chineseCharacters: "寻找",
                    audioSrc: "",
                    action: PinyinDetailViewState.Action.none))
            
            describe("init") {
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(PinyinDetailViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(PinyinDetailIntent.start))
                
                scheduler.start()
                
                it("should show pinyin details") {
                    expect(results.events[0].value.element).to(equal(PinyinDetailViewState(
                        phoneticScriptText: "pinyin",
                        englishTranslationText: "pinyin",
                        chineseCharacters: "寻找",
                        audioSrc: "",
                        action: PinyinDetailViewState.Action.none)))
                }
            }
        }
        
        describe("PinyinDetailViewModel with audioSrc") {
            
            let viewModel = PinyinDetailViewModel(
                initialState: PinyinDetailViewState(
                    phoneticScriptText: "pinyin",
                    englishTranslationText: "pinyin",
                    chineseCharacters: "寻找",
                    audioSrc: "ipfs://audio",
                    action: PinyinDetailViewState.Action.none))
            
            describe("playAudio") {
                
                let scheduler = TestScheduler(initialClock: 0)
                let results = scheduler.createObserver(PinyinDetailViewState.self)
                
                let _ = viewModel.states().subscribe(results)
                viewModel.processIntents(intents: Observable.just(PinyinDetailIntent.playAudio))
                
                scheduler.start()
                
                it("should show pinyin details") {
                    expect(results.events[0].value.element).to(equal(PinyinDetailViewState(
                        phoneticScriptText: "pinyin",
                        englishTranslationText: "pinyin",
                        chineseCharacters: "寻找",
                        audioSrc: "ipfs://audio",
                        action: PinyinDetailViewState.Action.playAudio(url: "ipfs://audio"))))
                    
                    expect(results.events[0].value.element!.action == PinyinDetailViewState.Action.playAudio(url: "ipfs://audio")).to(beTrue())
                }
            }
        }
    }
}
