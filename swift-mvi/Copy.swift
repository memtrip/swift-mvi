import Foundation

protocol Copy {
    
}

extension Copy {
    func copy(copy: (inout Self) -> Void) -> Self {
        var a = self
        copy(&a)
        return a
    }
}
