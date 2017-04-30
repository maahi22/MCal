//
//  MaxiVC.swift
//  MCal
//
//  Created by Maahi on 16/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import CoreData

class MaxiVC: UIViewController {

   // var editManageobj = NSManagedObject()
    var editManageobj : NSManagedObject!
    var attendiesList = NSMutableArray()
    
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var lblDates: UILabel!
    @IBOutlet weak var lblLocation: UITextView!
    @IBOutlet weak var lblTitle: UITextView!
    @IBOutlet weak var lblStarttime: UILabel!
    @IBOutlet weak var lblEndtime: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        //let btnEdit = UIBarButtonItem(barButtonSystemItem: .custom, target: self, action: #selector(EditClick))
        let btnEdit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(EditClick))
        
        navigationItem.rightBarButtonItems = [btnEdit]
        
        
        
        lblTitle.text = editManageobj.value(forKey: "title")  as! String?
        lblLocation.text = editManageobj.value(forKey: "displayName")  as! String?
        
        
        lblStarttime.text = DateHelper.sharedInstance.getTimeFromDate(date: (editManageobj.value(forKey: "startDateTime") as? Date)!)
        lblEndtime.text = DateHelper.sharedInstance.getTimeFromDate(date: (editManageobj.value(forKey: "endDateTime") as? Date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM"
        lblDates.text = dateFormatter.string(from: (editManageobj.value(forKey: "startDateTime") as? Date)!)
        
        
        
        
        if editManageobj != nil && editManageobj.value(forKey: "image") != nil{
            
            eventImageView.image = UIImage(data:editManageobj.value(forKey: "image") as! Data,scale:1.0)
            
        }
        
        
       // editManageobj.value(forKey: "title")  as! String
        
    }

//    func loadEditEvent(event:NSManagedObject)  {
//        editManageobj = event
//    }
    
    func EditClick() {
        
        
        self.performSegue(withIdentifier: "toAddEdit", sender: self)
        
        
        /*let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "AddEdit") as! EventAddEditVC
        //vc.resultsArray = self.resultsArray
        self.navigationController?.pushViewController(vc, animated:true)
        //toAddEdit*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func DeleteEvent(_ sender: AnyObject) {
        if editManageobj.value(forKey: "isCalenderEvent") != nil && editManageobj.value(forKey: "isCalenderEvent") as! Bool {
            DBHelper.sharedInstance.DeleteLocalCalEventDB(eventObj: editManageobj, callback: { (success) in
                
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: refreshDate), object: nil)
              let _ = self.navigationController?.popViewController(animated: true)
                
            })
        }else
        {
            DBHelper.sharedInstance.DeleteMCalEventDB(eventObj: editManageobj, callback: { (success) in
            
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: refreshDate), object: nil)
               let _ = self.navigationController?.popViewController(animated: true)
                
            })
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        if segue.identifier == "toAddEdit"{
            if let nextViewController = segue.destination as? EventAddEditVC{
                    nextViewController.editManageobj = editManageobj;
                    nextViewController.editSts =  true
            }
            
        }
    
    
    }
    

}
