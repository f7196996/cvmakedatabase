import CoreData

@objc(ListMultilineObject)
public class ListMultilineObject: ResumeField {
    @NSManaged public var objects: Set<MultilineObject>
    @NSManaged public var categoryName: String
    @NSManaged public var resume: Resume
    public override var category: MainCategory {
        MainCategory(rawValue: categoryName)!
    }
    
    convenience init(category: MainCategory, resume: Resume, context: NSManagedObjectContext) {
        self.init(context: context)
        self.categoryName = category.rawValue
        self.resume = resume
    }
    
    public override var valuesToDisplay: [String] {
        var valuesToShow: [String] = []
        if let object = objects.first(where: { !$0.title.isEmpty || !$0.specialisation.isEmpty }) {
            if !object.title.isEmpty {
                valuesToShow.append(object.title)
            }
            
            if !object.specialisation.isEmpty {
                valuesToShow.append(object.specialisation)
            }
            
            if !object.period.isEmpty {
                valuesToShow.append(object.period)
            }
        } else {
            valuesToShow = category.commonFields
        }
        
        return valuesToShow
    }
    
    public override var isFilled: Bool {
        !objects.isEmpty
    }
}

@objc(MultilineObject)
public class MultilineObject: NSManagedObject, Identifiable {
    @NSManaged public var title: String
    @NSManaged public var specialisation: String
    @NSManaged public var period: String
    @NSManaged public var location: String
    @NSManaged public var about: String
    @NSManaged public var present: Bool
    @NSManaged public var timestamp: Date
    @NSManaged public var list: ListMultilineObject
    
    convenience init(title: String = "", specialisation: String = "", period: String = "", location: String = "", about: String = "", present: Bool = false, list: ListMultilineObject, managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.title = title
        self.specialisation = specialisation
        self.period = period
        self.location = location
        self.about = about
        self.present = present
        self.timestamp = Date()
        self.list = list
    }
    
    convenience public init(_ object: MultilineTempObject, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = object.title
        self.specialisation = object.specialisation
        self.period = object.period
        self.location = object.location
        self.about = object.about
        self.present = object.present
        self.timestamp = Date()
        self.list = object.list
        object.list.objects.insert(self)
    }
    
    public func updateFields(_ object: MultilineTempObject) {
        self.title = object.title
        self.specialisation = object.specialisation
        self.period = object.period
        self.location = object.location
        self.about = object.about
        self.present = object.present
    }
}

public struct MultilineTempObject {
    public var title: String = ""
    public var specialisation: String = ""
    public var period: String = ""
    public var location: String = ""
    public var about: String = ""
    public var present: Bool = false
    public var list: ListMultilineObject
    public var existedObject: MultilineObject?
    
    public init(_ list: ListMultilineObject) {
        self.list = list
    }
    
    public init(_ object: MultilineObject, list: ListMultilineObject) {
        self.title = object.title
        self.specialisation = object.specialisation
        self.period = object.period
        self.location = object.location
        self.about = object.about
        self.present = object.present
        self.list = list
        self.existedObject = object
    }
}
