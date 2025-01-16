import Foundation

public struct ScoreTemp {
    public var title: String
    public var rate: Int
    
    public init(_ object: SinglelineObject) {
        self.title = object.name
        self.rate = Int(object.mark) ?? 1
    }
}
