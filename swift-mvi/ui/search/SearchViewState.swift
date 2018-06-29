import Foundation

struct SearchViewState : MviViewState, Copy {
    var hint: String
    var page: SearchPage
}
