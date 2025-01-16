import Foundation

public struct EducationTemp {
    public var period: String?
    public var specialization: String?
    public var univer: String?
    public var location: String?
    public var description: String?
    
    public init(_ object: MultilineObject) {
        period = object.period
        specialization = object.specialisation
        univer = object.title
        location = object.location
        description = object.about
    }
}
