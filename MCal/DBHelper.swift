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
    
    public func deleteLocalCalEventInDB(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        
        //create a fetch request, telling it about the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CalEvents")
        
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
        
        
        //create a fetch request, telling it about the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CalEvents")
        
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
        

        
        let merged = result + result2
//        merged.addingObjects(from: result)
//        merged.addingObjects(from: result2)
        
        
        
        //[merged sortUsingDescriptors:@[sortDescriptor]];
        
        
        
        
        return merged as NSArray;
        
    }
    
    
    
    
    //Add attendes
    func AddAttendes(attendes : NSArray)  {
        
    }
    
    
    //Add locations
    func AddLocation(attendes : NSArray)  {
        
    }
    
    
    
    
    
    //Add MCal Events
    public func AddMCalEventInDB (eventData :NSDictionary , callback:((_ Result :Bool) -> Void)){
        
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
    
    
    
   /* public func UpdateMCalEventInDB (eventManageObj :NSManagedObject ,eventID : String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "Events", in: context)
        let manageObj = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        manageObj.setValue(eventData.value(forKey: "title"), forKey: "title")
        manageObj.setValue("", forKey: "calenderEventId")
        
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
        
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
        
    }
    */
    
    
    
    
}
