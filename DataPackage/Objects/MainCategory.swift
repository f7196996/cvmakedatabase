import SwiftUI
import SwiftData

public enum MainCategory: String {
    case profile
    case contact
    case employment
    case education
    case skills
    case software
    case project
    case language
    case hobbie
    
    public var image: Image {
        Image(rawValue)
    }
    
    public var title: String {
        rawValue.capitalizedFirst
    }
    
    public var commonFields: [String] {
        switch self {
        case .profile:
            []
        case .contact:
            []
        case .employment:
            ["Company", "Specialization", "Period"]
        case .education:
            ["University", "Specialization", "Period"]
        case .skills:
            ["Skill name"]
        case .software:
            ["Software name"]
        case .project:
            ["Project name", "Project URL", "Period"]
        case .language:
            ["Language name"]
        case .hobbie:
            ["Hobbie name"]
        }
    }
}
