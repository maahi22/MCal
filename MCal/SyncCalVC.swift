//
//  SyncCalVC.swift
//  MCal
//
//  Created by Maahi on 23/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import EventKit
//import DBHelper


class SyncCalVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblSyncCalender: UITableView!
    var calList = NSMutableArray()
    var syncEventList = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //get Calender list
        
        let store = EKEventStore()
        store.requestAccess(to: EKEntityType.event) { (granted, error) in
            if(granted){
                let calendars = store.calendars(for: EKEntityType.event)
              
                self.calList = NSMutableArray(array: calendars)//NSMutableArray.init(array: calendars, copyItems: true)
                
                print(self.calList)
                /* for calendar in calendars {
                    let predicate = store.predicateForEvents(withStart: (dates.first?.dateObject)!, end: (dates.last?.dateObject)!, calendars: [calendar])
                    
                    store.enumerateEvents(matching: predicate){ (event, stop) in
                        print(event.title)
                       calList.add(<#T##anObject: Any##Any#>)
                    }
                    
                }*/
                
                self.tblSyncCalender.reloadData()
                
            }else{
                print(error)
            }
        
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calList.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tblSyncCalender.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
        let calDict = self.calList.object(at: indexPath.row) as! EKCalendar
       
        cell.textLabel?.text = calDict.title
        
        return cell
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
    
    
    
    
    @IBAction func syncClicked(_ sender: AnyObject) {
        
        let store = EKEventStore()
        store.requestAccess(to: EKEntityType.event) { (granted, error) in
            if(granted){
                for calendar in self.calList {
                   
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let startDate = dateFormatter.date(from: "2016-01-01")
                    let endDate = dateFormatter.date(from: "2018-12-31")
                    
                    let predicate = store.predicateForEvents(withStart: startDate!, end: endDate!, calendars: [calendar as! EKCalendar])
                    
                   
                    store.enumerateEvents(matching: predicate){ (event, stop) in
                        
                         print(event.title)
                       self.syncEventList.add(event)
                    
                         
                    }
                    
                }
            
          
          
               print(self.syncEventList)
               DBHelper .sharedInstance.deleteLocalCalEventInDB()
               DBHelper .sharedInstance.AddLocalCalEventInDB(eventArray: self.syncEventList)
          }
        
     }
     
     
         }
    
    

}
