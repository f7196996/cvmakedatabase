import Foundation

public struct HobbyTemp {
    public var title: String?
    public var info: String?
    
    public init(_ object: SinglelineObject) {
        title = object.name
        info = object.mark
    }
}
