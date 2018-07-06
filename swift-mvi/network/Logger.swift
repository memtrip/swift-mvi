import Foundation

class Logger: NSObject {
    
    static func log(value: String) {
        #if DEBUG
        print(">> \(value)")
        #endif
    }
}
