import CoreData

@objc(Profile)
public final class Profile: ResumeField {
    @NSManaged public var resume: Resume
    @NSManaged public var name: String
    @NSManaged public var jobTitle: String
    @NSManaged public var location: String
    @NSManaged public var imageData: Data?
    @NSManaged public var about: String
    override public var category: MainCategory { .profile }
    
    convenience init(resume: Resume, _ managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.resume = resume
        self.name = ""
        self.jobTitle = ""
        self.location = ""
        self.about = ""
    }
    
    public override var valuesToDisplay: [String] {
        let name = name.isEmpty ? "Name" : name
        let jobtitle = jobTitle.isEmpty ? "Job title" : jobTitle
        let location = location.isEmpty ? "Location" : location
        
        return [name, jobtitle, location]
    }

    public override var isFilled: Bool {
        !(name.isEmpty && jobTitle.isEmpty && location.isEmpty)
    }
}
