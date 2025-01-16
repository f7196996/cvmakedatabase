import Foundation

public struct ExperienceTemp {
    public var jobTitle: String?
    public var company: String?
    public var period: String?
    public var location: String?
    public var info: String?
    
    public init(_ object: MultilineObject) {
        jobTitle = object.specialisation
        company = object.title
        period = object.period
        location = object.location
        info = object.about
    }
}
