//
//  EventAddEditVC.swift
//  MCal
//
//  Created by Maahi on 16/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

class EventAddEditVC: UIViewController,UITableViewDataSource,UITableViewDelegate,EventTypeVCDelegate {

    
    @IBOutlet weak var tblAddEdit: UITableView!
    var listArray = NSMutableArray()
    var open1 = Bool()
    var open2 = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //listArray.add("Title");
        //listArray.add("Location");
        
        listArray.add("Starts");
        listArray.add("Ends");
        listArray.add("All-day");
        listArray.add("Repeat");
        listArray.add("Type");
        listArray.add("Travel Time");
        listArray.add("Image");
        listArray.add("add Attendes");
        listArray.add("Notes");
        
        
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
        
        
        if segue.identifier == "toeventType"{
            if let nextViewController = segue.destination as? EventTypeVC{
                
                nextViewController.delegate = self;
                
            }
        }
    }
    

    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 0  {
                
                if open1 {
                  return  235
                    
                }else{
                    return 40
                }
                
            }
            
            if indexPath.row == 1 {
                
                if open2 {
                    return  235
                }else{
                    return 40
                }
                
            }
            else{
                return 40
            }
        }else{
            return 40
        }
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2;
        }else{
            return  listArray.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            if indexPath.row == 0 || indexPath.row == 1 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell", for: indexPath ) as! DatePickerCell
               
                if indexPath.row==0 {
                    cell.lblStart.text = "Starts"
                }else{
                    cell.lblStart.text = "Ends"
                }
                
                return cell
                
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddEditCell", for: indexPath ) as! AddEditCell
                cell.lblTitle.text = listArray.object(at: indexPath.row) as? String
                if cell.lblTitle.text == "All-day" {
                    cell.alldayswitch.isHidden = false
                }else{
                    cell.alldayswitch.isHidden = true
                }
                return cell
            }
            
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddEventTitleCell", for: indexPath ) as! AddEventTitleCell
            
            if indexPath.row==0 {
                cell.txtTitle.placeholder = "Title"
            }else{
                cell.txtTitle.placeholder = "Location"
            }
            
            return cell
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if indexPath.section == 1 {
            if indexPath.row == 0   {
                
                if open1 {
                    open1 = false;
                }else{
                    open1 = true;
                }
                tblAddEdit .reloadData()
                
            }else if indexPath.row == 1 {
                if open2 {
                    open2 = false;
                }else{
                    open2 = true;
                }
                tblAddEdit .reloadData()
            }
            else if indexPath.row == 4 {
                self.performSegue(withIdentifier: "toeventType", sender: self)
            }
            
        
            
            
        }else{
            
            
            
            
        }
        
        
        
    }
    
    
    func selectedEventType(type:String){
        let indexpath = IndexPath(row: 4, section: 1) as IndexPath
        
        let cell = tblAddEdit.cellForRow(at: indexpath) as! AddEditCell
        cell.lblTitle.text = type;
        
        
    }
}
