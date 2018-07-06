import Foundation

class Logger: NSObject {
    
    static func log(value: String) {
        self.log(value: value, trim: false)
    }
    
    static func log(value: String, trim: Bool) {
        #if DEBUG
        if (trim && value.count > 1000) {
            print(">> \(value.prefix(999))...")
        } else {
            print(">> \(value)")
        }
        #endif
    }
}
