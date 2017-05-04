//
//  DBHelper.swift
//  MCal
//
//  Created by Maahi on 22/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import EventKit
import CoreData

class DBHelper: NSObject {
    
    
    static let sharedInstance = DBHelper()
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
    
//Calender event insertion
    public func AddLocalCalEventInDB (eventArray :NSArray){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        for event1 in eventArray{
            let event = event1 as! EKEvent
            //retrieve the entity that we just created
            let entity =  NSEntityDescription.entity(forEntityName: "CalEvents", in: context)
            let manageObj = NSManagedObject(entity: entity!, insertInto: context)
            
            //set the entity values
            manageObj.setValue(event.title, forKey: "title")
            manageObj.setValue(event.calendarItemIdentifier, forKey: "calenderEventId")
            
            manageObj.setValue(event.startDate, forKey: "startDateTime")
            manageObj.setValue(event.endDate, forKey: "endDateTime")
            let fmt = DateFormatter()
            fmt.dateFormat = "dd/MM/yyyy"
            manageObj.setValue(fmt.string(from: event.startDate), forKey: "startDate")
            manageObj.setValue(true, forKey: "isRoadTravel")
//            manageObj.setValue(event.calendarItemIdentifier, forKey: "calenderEventId")
//            manageObj.setValue(event.calendarItemIdentifier, forKey: "calenderEventId")
            
            manageObj.setValue(event.location, forKey: "displayName")
            manageObj.setValue(event.recurrenceRules, forKey: "rRule")
            manageObj.setValue(event.hasRecurrenceRules, forKey: "isRecurring")
            manageObj.setValue(event.isAllDay, forKey: "isAllDay")
           // manageObj.setValue(event., forKey: "isMultiDay")
            manageObj.setValue(event.attendees, forKey: "attendees")
            manageObj.setValue(event.notes, forKey: "notes")
            manageObj.setValue(event.hasNotes, forKey: "hasNotes")
            manageObj.setValue(event.creationDate, forKey: "creationDate")
            manageObj.setValue(event.creationDate, forKey: "creationDate")
            
            //save the object
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
            
            
        }
        
        
       // let appDel = (AppDelegate)
      //  let context = AppDelegate.persistentContainer.viewContext
        //retrieve the entity that we just created
      //  let entity =  NSEntityDescription.entity(forEntityName: "CalEvents", in: context)
        
        
    }
    
    public func deleteAllLocalCalEventInDB(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        let sort : NSSortDescriptor = NSSortDescriptor(key: "startDateTime", ascending: true)
        
        
        
        //create a fetch request, telling it about the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CalEvents")
        fetchRequest.sortDescriptors = [sort]
        // Helpers
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try context.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity .")
        }
        
         print(result)
        
        for event1 in result{
            
            let  manageobj = event1 as NSManagedObject
            context.delete(manageobj)
            
        }
        
        /*let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }*/
        
        
    }

    //Fetch Calender event
    
    public func getLocalCalEventInDB() -> NSArray{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        let sort : NSSortDescriptor = NSSortDescriptor(key: "startDateTime", ascending: true)
        
        //create a fetch request, telling it about the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CalEvents")
        fetchRequest.sortDescriptors = [sort]
        // Helpers
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try context.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity .")
        }
        
        print(result)
       
        //mCal Events
        //create a fetch request, telling it about the entity
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
        fetchRequest2.sortDescriptors = [sort]

        // Helpers
        var result2 = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try context.fetch(fetchRequest2)
            
            if let records = records as? [NSManagedObject] {
                result2 = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity .")
        }
        

        let merged = (result + result2).sorted(by: sorterForFileIDASC)

        
       // let merged = ((result + result2) as Array).sortedArray(using: sort) as! Array
        
       // let merged = (result+result2).sortedArrayUsingDescriptors([sort])
        /*let merged = (result + result2).sorted {
            
            guard let s1 = $0["startDateTime"], let s2 = $1["startDateTime"] else {
                return false
            }
            
                    return s1 < s2
        }*/
        //        merged.addingObjects(from: result)
//        merged.addingObjects(from: result2)
        
        
        
        //[merged sortUsingDescriptors:@[sortDescriptor]];
        
        
       // let merged : NSArray = result2.sortedArrayUsingDescriptors([sort])
        
        return merged as NSArray;
        
    }
    
    func sorterForFileIDASC(this:NSManagedObject, that:NSManagedObject) -> Bool {
        return that.value(forKey: "startDateTime") as! Date > this.value(forKey: "startDateTime") as! Date
    }

    
    
    //Add attendes
    func AddAttendes (attendes : NSArray, eventObj : NSManagedObject)  {
        
        
       // for (int i = 0 i< attendes.count i++ ) {
            for index in 1...attendes.count{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.getContext()
            
            //retrieve the entity that we just created
            let entity =  NSEntityDescription.entity(forEntityName: "Attendees", in: context)
            let manageObj = NSManagedObject(entity: entity!, insertInto: context)
            
            let eventData = attendes.object(at: index) as! NSDictionary
                
            //set the entity values
            manageObj.setValue(eventData.value(forKey: "displayName"), forKey: "displayName")
            manageObj.setValue("emailId", forKey: "emailId")
            manageObj.setValue(eventData.value(forKey: "eventCalId"), forKey: "eventCalId")
            manageObj.setValue(eventObj.value(forKey: "eventId"), forKey: "eventId")
            manageObj.setValue(eventData.value(forKey: "firstName"), forKey: "firstName")
            manageObj.setValue("", forKey: "imageUrl")
            manageObj.setValue(eventData.value(forKey: "phoneNo"), forKey: "phoneNo")
            manageObj.setValue(0, forKey: "status")
            manageObj.setValue(eventData.value(forKey: "userId"), forKey: "userId")
            manageObj.setValue(eventData.value(forKey: "initails"), forKey: "initails")
            manageObj.setValue (false, forKey: "isDelay")
            manageObj.setValue(false, forKey: "localCalSts")
            manageObj.setValue("", forKey: "ownerId")
            
//            manageObj.objectID//objectIDs(forRelationshipNamed: event)  (eventObj, forKey: "event")
//            eventObj.setValue(manageObj, forKey: "attendee")
            //save the object
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
        }
        
    }
    
    
    //Add locations
    func AddLocation(attendes : NSArray)  {
        
    }
    
    
    
    
    
    //Add MCal Events
    public func AddMCalEventInDB (eventData :NSDictionary, attendeas :NSArray  , callback:((_ Result :Bool) -> Void)){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
       
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "Events", in: context)
        let manageObj = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        manageObj.setValue(eventData.value(forKey: "title"), forKey: "title")
        manageObj.setValue("", forKey: "calenderEventId")
        manageObj.setValue(eventData.value(forKey: "eventId"), forKey: "eventId")
        manageObj.setValue(eventData.value(forKey: "startDateTime"), forKey: "startDateTime")
        manageObj.setValue(eventData.value(forKey: "endDateTime"), forKey: "endDateTime")
        manageObj.setValue(eventData.value(forKey: "startDate"), forKey: "startDate")
        manageObj.setValue(false, forKey: "isRoadTravel")
       // manageObj.setValue(event.location, forKey: "displayName")
        manageObj.setValue(eventData.value(forKey: "rRule"), forKey: "rRule")
        manageObj.setValue(eventData.value(forKey: "isRecurring"), forKey: "isRecurring")
        manageObj.setValue(eventData.value(forKey: "isAllDay"), forKey: "isAllDay")
        // manageObj.setValue(event., forKey: "isMultiDay")
       // manageObj.setValue(event.attendees, forKey: "attendees")
        manageObj.setValue(eventData.value(forKey: "notes"), forKey: "notes")
        manageObj.setValue(eventData.value(forKey: "hasNotes"), forKey: "hasNotes")
        manageObj.setValue(eventData.value(forKey: "startDateTime"), forKey: "creationDate")
        
        let strttime = eventData.value(forKey: "startDateTime") as! Date
        let timeinterval = strttime.timeIntervalSince1970
        manageObj.setValue(timeinterval, forKey: "startInstanceTime")
        
        let endtime = eventData.value(forKey: "endDateTime") as! Date
        let endtimeInterval = endtime.timeIntervalSince1970
        manageObj.setValue(endtimeInterval, forKey: "endInstanceTime")
        
        let fmt = DateFormatter()
        fmt.dateFormat = "dd/MM/yyyy"
        manageObj.setValue(fmt.string(from:strttime), forKey: "startDate")
        manageObj.setValue(eventData.value(forKey: "image"), forKey: "image")
        

        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
        self.AddAttendes(attendes: attendeas, eventObj: manageObj)
        /*self.addEventToCalendar(eventData: eventData) { (status, error) in
        
            
            
        }*/
        callback(true)
        
    }
    
    public func UpdateMCalEventDB (eventObj :NSManagedObject , callback:((_ Result :Bool) -> Void)){
      
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        
        let strttime = eventObj.value(forKey: "startDateTime") as! Date
        let timeinterval = strttime.timeIntervalSince1970
        eventObj.setValue(timeinterval, forKey: "startInstanceTime")
        
        let endtime = eventObj.value(forKey: "endDateTime") as! Date
        let endtimeInterval = endtime.timeIntervalSince1970
        eventObj.setValue(endtimeInterval, forKey: "endInstanceTime")
        
        let fmt = DateFormatter()
        fmt.dateFormat = "dd/MM/yyyy"
        eventObj.setValue(fmt.string(from:strttime), forKey: "startDate")
        
        
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
        callback(true)
    }
    
    
   //Local Cal
    func addEventToCalendar(eventData :NSDictionary, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                
                let event = EKEvent(eventStore: eventStore)
                event.title = eventData.value(forKey: "title") as! String
                event.startDate = eventData.value(forKey: "startDateTime") as! Date
                event.endDate = eventData.value(forKey: "endDateTime") as! Date
                event.notes = eventData.value(forKey: "notes") as! String?
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
  /*  func UpdateEventToCalendar(eventData :NSDictionary, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
    let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
             
            let  identifier = eventData.value(forKey: "eventId");
                //eventId
            let storeEvent = eventStore.event(withIdentifier: identifier as! String) ;
              identifier
         completion?(true, nil)
            }
    })
    }*/
    
    
    
    
    //Delete MCal Event
    public func DeleteMCalEventDB (eventObj :NSManagedObject , callback:((_ Result :Bool) -> Void)){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
        let calid = eventObj.value(forKey: "eventId") as! String
        fetchRequest.predicate =  NSPredicate(format: "eventId == %@",calid )
        
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try context.fetch(fetchRequest)
            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch {
            print("Unable to fetch managed objects for entity .")
        }
        
        for obj in result {
            context.delete(obj)
        }
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
        callback(true)
    }
    
    //DeleteLocalCal
    public func DeleteLocalCalEventDB (eventObj :NSManagedObject , callback:((_ Result :Bool) -> Void)){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CalEvents")
        let calid = eventObj.value(forKey: "calenderEventId") as! String
        fetchRequest.predicate =  NSPredicate(format: "calenderEventId == %@",calid )
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try context.fetch(fetchRequest)
            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch {
            print("Unable to fetch managed objects for entity .")
        }
        
        for obj in result {
            context.delete(obj)
        }
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
        callback(true)
    }
    
    
}
