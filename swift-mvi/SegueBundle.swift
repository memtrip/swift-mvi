import Foundation

struct SegueBundle {
    var identifier: String
    var dictionary: [String: Any?]
}

protocol BundleSender {
    func setDestinationBundle(bundle: SegueBundle)
    func getDestinationBundle() -> SegueBundle?
}
