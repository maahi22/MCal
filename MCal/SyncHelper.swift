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
    
    func receiveEventStoreChangedNotification(notification : Notification) {
        
        var  ekEventStore = notification.object as! EKEventStore
        
        
        
        
    }
    
    
    
}
