import Foundation

public struct ProjectTemp {
    public var title: String?
    public var period: String?
    public var info: String?
    public var link: String?
    
    public init(_ object: MultilineObject) {
        title = object.title
        period = object.period
        info = object.about
        link = object.specialisation
    }
}
