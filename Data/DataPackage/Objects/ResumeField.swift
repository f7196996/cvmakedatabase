import Foundation
import CoreData

public class ResumeField: NSManagedObject, Identifiable {
    public var isFilled: Bool { false }
    public var category: MainCategory { .contact }
    public var valuesToDisplay: [String] { [] }
}
