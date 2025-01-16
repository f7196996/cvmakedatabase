import CoreData
import UIKit

@objc(Resume)
public final class Resume: NSManagedObject, Identifiable {
    @NSManaged public var timestamp: Date
    @NSManaged public var profile: Profile
    @NSManaged public var contact: Contact
    @NSManaged public var employment: ListMultilineObject
    @NSManaged public var education: ListMultilineObject
    @NSManaged public var project: ListMultilineObject
    @NSManaged public var skills: ListSinglelineObject
    @NSManaged public var software: ListSinglelineObject
    @NSManaged public var language: ListSinglelineObject
    @NSManaged public var hobbies: ListSinglelineObject
    @NSManaged public var pdfGenerated: Data?
    @NSManaged public var pdfURL: URL?
    public var pdfImageData: Data?
    public var pdfImage: UIImage?
    
    convenience public init(_ managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.timestamp = Date()
        self.profile = Profile(resume: self, managedContext)
        self.contact = Contact(managedContext)
        self.employment = ListMultilineObject(category: .employment, resume: self, context: managedContext)
        self.education = ListMultilineObject(category: .education, resume: self, context: managedContext)
        self.project = ListMultilineObject(category: .project, resume: self, context: managedContext)
        self.skills = ListSinglelineObject(category: .skills, resume: self, managedContext: managedContext)
        self.software = ListSinglelineObject(category: .software, resume: self, managedContext: managedContext)
        self.language = ListSinglelineObject(category: .language, resume: self, managedContext: managedContext)
        self.hobbies = ListSinglelineObject(category: .hobbie, resume: self, managedContext: managedContext)
    }
    
    public var builderFields: [ResumeField] {
        [contact, employment, education, skills, software, project]
    }
    
    public var allFields: [ResumeField] {
        [profile, contact, employment, education, skills, software, project, language, hobbies]
    }
}
