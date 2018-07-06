import Foundation

class Logger: NSObject {
    
    static func log(value: String) {
        self.log(value: value, trim: false)
    }
    
    static func log(value: String, trim: Bool) {
        #if DEBUG
        if (trim && value.count > 100) {
            print(">> \(value.prefix(99))...")
        } else {
            print(">> \(value)")
        }
        #endif
    }
}
