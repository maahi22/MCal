//
//  idGenrator.swift
//  MCal
//
//  Created by Maahi on 25/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

class idGenrator: NSObject {

    static let sharedInstance = idGenrator()
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
   public func NewEventid() -> String  {
        
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: "eventd") != nil) {
        
            let eventid = defaults.object(forKey: "eventd") as! String
            let newId =  Int(eventid)! + 1
            
            defaults.set(newId, forKey: "eventd")
            return String(newId)
        }else{
            return String(1)
        }
    }
    
    
    
    
}
