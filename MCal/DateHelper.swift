//
//  DateHelper.swift
//  MCal
//
//  Created by Maahi on 22/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

class DateHelper: NSObject {

    
    static let sharedInstance = DateHelper()
    
    private override init() {} //This prevents others from using the default '()' initializer for this class.

    
    
    
 public   func getOneyearPastDate() ->  (Date) {
    
       /* let date = NSDate()
        let calendar = NSCalendar.current
       // let components = NSDateComponents()
        let newDate = calendar.date(byAdding: .year, value: -1, to: date as Date, wrappingComponents: true) as NSDate
        
        //(.Year, value:-1, toDate: NSDate(), options: NSCalendar.Options.MatchNextTime)
    
    */
        
    let date = Calendar.current.date(byAdding: .year, value: -1, to: Date())
    return date!
    
    }
    
    
   public func getOneyearFutureDate() ->  (Date) {
        
        let date = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        return date!
        
    }

    
    
    
    public   func getTimeFromDate( date:Date) ->  (String) {
        
        let fmt = DateFormatter()
        fmt.dateFormat = "hh:mm a"
        let dateStr = fmt .string(from: date)
        
        return dateStr
        
    }

    
    
    
    
}
