import CoreData

@objc(ListSinglelineObject)
public class ListSinglelineObject: ResumeField {
    @NSManaged public var objects: Set<SinglelineObject>
    @NSManaged public var categoryName: String
    @NSManaged public var resume: Resume
    override public var category: MainCategory {
        MainCategory(rawValue: categoryName)!
    }
    
    convenience init(category: MainCategory, resume: Resume, managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.categoryName = category.rawValue
        self.resume = resume
    }
    
    public override var valuesToDisplay: [String] {
        let names = objects.map { $0.name }.filter { !$0.isEmpty }
        
        return names.isEmpty ? category.commonFields : Array(names.prefix(3))
    }
    
    public override var isFilled: Bool {
        !objects.isEmpty
    }
}

@objc(SinglelineObject)
public class SinglelineObject: NSManagedObject, Identifiable {
    @NSManaged public var name: String
    @NSManaged public var mark: String
    @NSManaged public var timestamp: Date
    @NSManaged public var list: ListSinglelineObject
    
    convenience init(name: String = "", mark: String = "1", list: ListSinglelineObject, managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.name = name
        self.mark = mark
        self.timestamp = Date()
        self.list = list
    }
    
    convenience public init(_ tempObject: SinglelineTempObject, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = tempObject.name
        self.mark = tempObject.mark
        self.timestamp = Date()
        self.list = tempObject.list
        tempObject.list.objects.insert(self)
    }
    
    public func updateFields(_ tempObject: SinglelineTempObject) {
        self.name = tempObject.name
        self.mark = tempObject.mark
    }
}

public struct SinglelineTempObject {
    public var name: String = ""
    public var mark: String = "1"
    public var list: ListSinglelineObject
    public var existedObject: SinglelineObject?
    
    public init(_ list: ListSinglelineObject) {
        self.list = list
    }
    
    public init(_ object: SinglelineObject, list: ListSinglelineObject) {
        self.name = object.name
        self.mark = object.mark
        self.list = object.list
        self.existedObject = object
    }
    
    public init(name: String = "", mark: String = "", list: ListSinglelineObject) {
        self.name = name
        self.mark = mark
        self.list = list
    }
}
