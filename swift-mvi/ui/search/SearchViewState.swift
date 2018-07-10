import Foundation

struct SearchViewState: MxViewState, Copy, Equatable {
    var hint: String
    var page: SearchPage

    static func == (lhs: SearchViewState, rhs: SearchViewState) -> Bool {
        return lhs.hint == rhs.hint
            && lhs.page == rhs.page
    }
}
