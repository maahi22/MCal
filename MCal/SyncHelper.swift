//
//  SyncHelper.swift
//  MCal
//
//  Created by Maahi on 23/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import EventKit

class SyncHelper: NSObject {

    
    static let sharedInstance = SyncHelper()
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    

    
    var eventStore = EKEventStore()
    
    func initialiseObserverForLocalcalnderUpdate()  {
        
        // Define identifier
        let notificationName = Notification.Name("NotificationIdentifier")
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveEventStoreChangedNotification), name: notificationName, object: self.eventStore)

        
        
    }
    
    func receiveEventStoreChangedNotification(notification : NSNotification) {
        
        var  ekEventStore = notification.object as! EKEventStore
        
        let now = Date()
        var offsetComponents = DateComponents()
        offsetComponents.day = 0
        offsetComponents.month = 4
        offsetComponents.year = 0
        
        let endDate = NSCalendar.current.date(byAdding: offsetComponents, to: now)
        
        
        let ekEventStoreChangedObjectIDArray = (notification.userInfo?["EKEventStoreChangedObjectIDsUserInfoKey"] as? NSArray)
        let predicate: NSPredicate? = ekEventStore.predicateForEvents(withStart: now, end: endDate!, calendars: nil)
        // Loop through all events in range
       /* ekEventStore.enumerateEvents(matching: predicate!) { (ekEvent : EKEvent, stop) in
            
        
            
            //{(_ ekEvent: EKEvent, _ stop: Bool) -> Void in
            // Check this event against each ekObjectID in notification
           
            (ekEventStoreChangedObjectIDArray?.enumerateObjects({ (ekEventStoreChangedObjectID, idx, stop) in
                
                
                
                
                //.enumerateObjects({(_ ekEventStoreChangedObjectID: String, _ idx: Int, _ stop: Bool) -> Void in
                // ekEventStoreChangedObjectIDArray.enu
                
                let ekObjectID = ekEvent
                if (ekEventStoreChangedObjectID as AnyObject).isEqual(ekObjectID) {
                    // EKEvent object is the object which is changed.
                    
                    
                    stop = true
                }
            }))!
        })*/
    
    
        
    }
    
   /* -(void)storeChanged:(NSNotification*)notification{
    EKEventStore *ekEventStore = notification.object;
    NSDate *now = [NSDate date];
    NSDateComponents *offsetComponents = [NSDateComponents new];
    [offsetComponents setDay:0];
    [offsetComponents setMonth:4];
    [offsetComponents setYear:0];
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:offsetComponents toDate:now options:0];
    NSArray *ekEventStoreChangedObjectIDArray = [notification.userInfo objectForKey:@"EKEventStoreChangedObjectIDsUserInfoKey"];
    NSPredicate *predicate = [ekEventStore    predicateForEventsWithStartDate:now                                                                   endDate:endDate                                                                 calendars:nil];
    
    // Loop through all events in range [ekEventStore enumerateEventsMatchingPredicate:predicate usingBlock:^(EKEvent *ekEvent, BOOL *stop) {
    
    // Check this event against each ekObjectID in notification     [ekEventStoreChangedObjectIDArray enumerateObjectsUsingBlock:^(NSString *ekEventStoreChangedObjectID, NSUInteger idx, BOOL *stop) {
    NSObject *ekObjectID = [(NSManagedObject *)ekEvent objectID];
    if ([ekEventStoreChangedObjectID isEqual:ekObjectID]) {
    
    // Log the event we found and stop (each event should only exist once in store)             NSLog(@"calendarChanged(): Event Changed: title:%@", ekEvent.title);
    NSLog(@"%@",ekEvent);
    NSInteger total = [[[UIApplication sharedApplication] scheduledLocalNotifications]count];
    if (total == 64) {
    [self cancelLastNotification];
    }              NSArray *newArray = [[NSArray alloc]initWithObjects:ekEvent, nil];
    [self scheduleNotificationForCalendarEvents:NO andEvents:newArray];
    *stop = YES;
    }     }];
}];*/

}
