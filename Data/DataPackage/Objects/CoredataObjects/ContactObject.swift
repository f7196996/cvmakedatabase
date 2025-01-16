import Foundation
import CoreData

@objc(Contact)
public final class Contact: ResumeField {
    @NSManaged public var resume: Resume
    @NSManaged public var email: String
    @NSManaged public var telephone: String
    @NSManaged public var profile: String
    public override var category: MainCategory { .contact }
    
    convenience init(_ managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.email = ""
        self.telephone = ""
        self.profile = ""
    }
    
    public override var valuesToDisplay: [String] {
        let email = !email.isEmpty ? email : "Email"
        let telephone = !telephone.isEmpty ? telephone : "Telephone"
        let profile = !profile.isEmpty ? profile : "Profile URL"
        
        return [email, telephone, profile]
    }
    
    public override var isFilled: Bool {
        !(email.isEmpty && telephone.isEmpty && profile.isEmpty)
    }
}
