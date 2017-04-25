//
//  MidiViewController.swift
//  MCal
//
//  Created by Maahi on 16/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import CoreData

class MidiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var midiTableView: UITableView!
    var dateArray = NSMutableArray()
    var eventArray = NSMutableArray()
    var editEvent = NSManagedObject()
    var indexpath = NSIndexPath()
    
    @IBOutlet weak var btnAddEvent: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  self.navigationItem.setHidesBackButton(true, animated:true);
        
        // Do any additional setup after loading the view.
        
        let strtdate = DateHelper.sharedInstance.getOneyearPastDate()
        let enddate = DateHelper.sharedInstance.getOneyearFutureDate()
        var date=strtdate;
        //btnAddEvent.layer.cornerRadius=40;
        
        let fmt = DateFormatter()
        fmt.dateFormat = "dd/MM/yyyy"
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM"
        
        while date <= enddate {
           // print(fmt.string(from: date))
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
           let dict = ["date" : date, "showDate" : dateFormatter.string(from: date),"OnlyDate":fmt.string(from: date)] as [String : Any]
            
            dateArray.add(dict)
        }
        
        midiTableView.reloadData()
        
       // let indexPath = IndexPath(item: 0, section: 365)
       // midiTableView.reloadRows(at: [indexPath], with: .top)
       // midiTableView.reloadRows(at: [indexPath], with: .automatic)
        self.perform(#selector(reloadTodaysDate), with: nil, afterDelay: 0.1)
   
    
        
        self.eventArray = NSMutableArray(array: DBHelper.sharedInstance.getLocalCalEventInDB())
        
        print("event array \(eventArray)")
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
    
    }


    func reloadTodaysDate() {
        let fmt = DateFormatter()
        fmt.dateFormat = "dd/MM/yyyy"
        let date = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        
        let today = fmt.string(from: date!)
        let predicate = NSPredicate(format: "OnlyDate == %@",today )
        let arr = dateArray.filtered(using: predicate)
        
        let indexOfToday = dateArray.index(of: arr.first)
        
        let indexPath = IndexPath(item: 0, section: 365)
        midiTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    
        if segue.identifier == "toMaxiview"{
            if let nextViewController = segue.destination as? MaxiVC{
                
                let dict = dateArray.object(at: indexpath.section) as? [String : Any]
                let str = dict?["OnlyDate"] as! String?
                let predicate = NSPredicate(format: "startDate == %@",str! )
                let arr = eventArray.filtered(using: predicate) as NSArray

                if arr.count > 0 {
                    //nextViewController.editManageobj = arr.object(at: indexpath.row) as! NSManagedObject
                    
                    nextViewController.loadEditEvent(event: arr.object(at: indexpath.row) as! NSManagedObject)
                }
                
                
                
            
            }
            
        }
    
    
    }
    
    
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dict = dateArray.object(at: indexPath.section) as? [String : Any]
        let str = dict?["OnlyDate"] as! String?
        let predicate = NSPredicate(format: "startDate == %@",str! )
        let arr = eventArray.filtered(using: predicate) as NSArray
        if arr.count > 0 {
            return 120
        }else{
         return 45
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let dict = dateArray.object(at: indexPath.section) as? [String : Any]
        let str = dict?["OnlyDate"] as! String?
        let predicate = NSPredicate(format: "startDate == %@",str! )
        let arr = eventArray.filtered(using: predicate) as NSArray
        if arr.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
            // Configure Table View Cell
              configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
              return cell
        }else{
            let cell = midiTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
            return cell
        }
      //  Cell
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell")
        // Configure Table View Cell
      //  configureCell(cell: cell!, atIndexPath: indexPath as NSIndexPath)
      //  return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return dateArray.count
    }
    
    
//func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    
    /*
 
     override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
     
     headerView.customLabel.text = content[section].name  // set this however is appropriate for your app's model
     headerView.sectionNumber = section
     headerView.delegate = self
     
     return headerView
     }
 */
/*private  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = UIColor.red
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = NSTextAlignment.center
       header.backgroundColor=UIColor.green
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy"
        
        let date = dateArray.index(of: section)
        print(date)
        header.textLabel?.text = "ABCD"//dateFormatter.string(from: date as Date)
    
        return header;
    }*/
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dict = dateArray.object(at: section) as? [String : Any]
        let str = dict?["showDate"]
        return str as! String?
    }
    
    
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //print("section  \(section )");
        let dict = dateArray.object(at: section) as? [String : Any]
        let str = dict?["OnlyDate"] as! String?
        
        let predicate = NSPredicate(format: "startDate == %@",str! )
        let arr = eventArray.filtered(using: predicate) as NSArray
        
        print("section  \(section )  \( arr.count)");
        
        if arr.count > 0 {
            return arr.count
        }else{
            return 1
        }
        
    }
    
    func configureCell(cell: EventCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        let dict = dateArray.object(at: indexPath.section) as? [String : Any]
        let str = dict?["OnlyDate"] as! String?
        let predicate = NSPredicate(format: "startDate == %@",str! )
        let arr = eventArray.filtered(using: predicate) as NSArray
        let eventDict = arr[indexPath.row] as! NSManagedObject
        
        cell.txtViewEventTitle.text = eventDict.value(forKey: "title")  as! String//["title"] as? String
        cell.txtViewEventAddress.text = eventDict.value(forKey: "address") as? String
        cell.viewEventtype.backgroundColor = UIColor.clear
        
        cell.lblStrtDatetime.text = DateHelper.sharedInstance.getTimeFromDate(date: (eventDict.value(forKey: "startDateTime") as? Date)!)
        cell.lblEndDatetime.text = DateHelper.sharedInstance.getTimeFromDate(date: (eventDict.value(forKey: "endDateTime") as? Date)!)
    }
    

    
    //Delegate Methods
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        
//        return true;
//        
//    }
    
//     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//   // func tableView(_ tableView: UITableView, commiteditingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//        
//        
//    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    private func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let delete = UITableViewRowAction(style: .normal, title: "Delete")
        { action, index in
            print("delete")
        }
        let done = UITableViewRowAction(style: .default, title: "Done")
        { action, index in
            print("done")
        }
        return [delete, done]
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = dateArray.object(at: indexPath.section) as? [String : Any]
        let str = dict?["OnlyDate"] as! String?
        let predicate = NSPredicate(format: "startDate == %@",str! )
        let arr = eventArray.filtered(using: predicate) as NSArray

        
        if arr.count > 0 {
            
            self.indexpath = indexPath as NSIndexPath;
            //self.editEvent = arr[indexPath.row] as! NSManagedObject
            self.performSegue(withIdentifier: "toMaxiview", sender: self)
            
          
            
        }else{
            return
        }
        
        
        
        
        print(dateArray.object(at: indexPath.section))
        //toMidiview
        
        
        
    }
  //bar Buttons
    
    @IBAction func clickNotification(_ sender: AnyObject) {
        
        
    }
    
    
    
    @IBAction func clickMiniView(_ sender: AnyObject) {
        
        
    }
    
    @IBAction func clickMidi(_ sender: AnyObject) {
        
        
    }
    
    
    @IBAction func clickMenu(_ sender: AnyObject) {
        
        
    }
    
    
    
    
    @IBAction func clickAddEvent(_ sender: AnyObject) {
        
        
        
    }
    
    
    
}
