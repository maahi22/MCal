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
        return result as NSArray;
        
    }
    
    
    
}
