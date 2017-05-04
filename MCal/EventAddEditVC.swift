//
//  EventAddEditVC.swift
//  MCal
//
//  Created by Maahi on 16/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import CoreData
import Contacts

class EventAddEditVC: UIViewController,UITableViewDataSource,UITableViewDelegate,EventTypeVCDelegate ,AddAttendeesVCDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    @IBOutlet weak var tblAddEdit: UITableView!
    var imagePicker = UIImagePickerController()
    
    var eventDictionary = NSMutableDictionary()
    var listArray = NSMutableArray()
    var open1 = Bool()
    var open2 = Bool()
    var  editSts = Bool()
    var startDateTime = Date();
    var endDateTime = Date()
    var editManageobj : NSManagedObject!
    var selImage = UIImage()
    var attendeasArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
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
        
        
        if editSts {
            startDateTime = editManageobj .value(forKey: "startDateTime") as! Date
            endDateTime = editManageobj.value(forKey: "endDateTime") as! Date
        }else{
            
            eventDictionary.setValue("", forKey: "notes")
            eventDictionary.setValue("", forKey: "title")
            eventDictionary.setValue("", forKey: "calenderEventId")
            eventDictionary.setValue("", forKey: "eventId")
            eventDictionary.setValue("", forKey: "startDateTime")
            eventDictionary.setValue("", forKey: "endDateTime")
            eventDictionary.setValue("", forKey: "startDate")
            eventDictionary.setValue("", forKey: "isRoadTravel")
            eventDictionary.setValue("", forKey: "rRule")
            eventDictionary.setValue(false, forKey: "isRecurring")
            eventDictionary.setValue(false, forKey: "isAllDay")
            eventDictionary.setValue(false, forKey: "hasNotes")
            eventDictionary.setValue("", forKey: "creationDate")
        }
        
        
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
        else if segue.identifier == "toAddAttendes" {
            if let nextViewController = segue.destination as? AddAttendeesVC{
                
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
                    if editSts{
                        cell.lblStartDate.text = DateHelper.sharedInstance.getpicketDateTime(date: startDateTime)
                    }
                }else{
                    cell.lblStart.text = "Ends"
                    if editSts{
                        cell.lblStartDate.text = DateHelper.sharedInstance.getpicketDateTime(date: endDateTime)
                    }
                }
                
                return cell
                
            }
            
            else if  indexPath.row == 7 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeesCell", for: indexPath ) as! AttendeesCell
            return cell
                
            }else{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddEditCell", for: indexPath ) as! AddEditCell
                cell.lblTitle.text = listArray.object(at: indexPath.row) as? String
                if cell.lblTitle.text == "All-day" {
                    cell.alldayswitch.isHidden = false
                }else{
                    cell.alldayswitch.isHidden = true
                }
                
                if indexPath.row == 4 {
                    
                    if editSts && eventDictionary.value(forKey: "eventType") != nil{
                      cell.lblTitle.text = eventDictionary.value(forKey: "eventType") as! String?
                    }
                    cell.logoImage.image = UIImage.init(named: "type")
                }
                else if indexPath.row == 3 {
                    cell.logoImage.image = UIImage.init(named: "repete")
                }else if indexPath.row == 2 {
                    cell.logoImage.image = UIImage.init(named: "AllDay")
                }else if indexPath.row == 5 {
                    cell.logoImage.image = UIImage.init(named: "traveltime")
                }else if indexPath.row == 6 {
                    cell.logoImage.image = UIImage.init(named: "Image")
                }else if indexPath.row == 7 {
                    cell.logoImage.image = UIImage.init(named: "attendes")
                }else if indexPath.row == 8 {
                    cell.logoImage.image = UIImage.init(named: "Notes")
                }
                
                return cell
            }
            
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddEventTitleCell", for: indexPath ) as! AddEventTitleCell
            
            if indexPath.row==0 {
                if (editSts && editManageobj.value(forKey: "title") != nil) {
                    cell.txtTitle.text = editManageobj.value(forKey: "title") as! String?
                }else{
                    cell.txtTitle.placeholder = "Title"}
            //cell.logoImage.image = UIImage.init(named: "Notes")
           
            }else{
                if (editSts && editManageobj.value(forKey: "displayName") != nil) {
                    cell.txtTitle.text = editManageobj.value(forKey: "displayName") as! String?
                }else{
                    cell.txtTitle.placeholder = "Location"}
                    }
            //cell.logoImage.image = UIImage.init(named: "Notes")
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
                    let cell = tblAddEdit.cellForRow(at: indexPath) as! DatePickerCell
                   self.datePickerChanged(datePicker: cell.datepicker)
                }
                tblAddEdit .reloadData()
                
            }else if indexPath.row == 1 {
                if open2 {
                    open2 = false;
                }else{
                    open2 = true;
                    let cell = tblAddEdit.cellForRow(at: indexPath) as! DatePickerCell
                    self.datePickerChanged(datePicker: cell.datepicker)
                }
                tblAddEdit .reloadData()
            }
            else if indexPath.row == 4 {
                self.performSegue(withIdentifier: "toeventType", sender: self)
            }else if indexPath.row == 7 {
                self.performSegue(withIdentifier: "toAddAttendes", sender: self)
            }else if indexPath.row == 6 {
                self.ClickImage()
            }
            
         
        }else{
            
            
            
            
        }
        
        
        
    }
    
    
    func ClickImage() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        
        if imagePicker.sourceType == .camera {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }else{
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
            
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
//        myImageView.contentMode = .scaleAspectFit //3
//        myImageView.image = chosenImage //4
//        imageArray.add(chosenImage)
        
        
        let indexpath = IndexPath(row: 6, section: 1) as IndexPath
        let cell = tblAddEdit.cellForRow(at: indexpath) as! AddEditCell
        cell.logoImage?.image = chosenImage
        selImage = chosenImage
        
        
        
        dismiss(animated:true, completion: nil) //5
    }
    
    
    
    
    
    
    
    
    func selectedEventType(type:String){
        let indexpath = IndexPath(row: 4, section: 1) as IndexPath
        
        let cell = tblAddEdit.cellForRow(at: indexpath) as! AddEditCell
        cell.lblTitle.text = type;
        
        if editSts{
            editManageobj.setValue(type, forKey: "type")
        }else{
            eventDictionary.setValue(type, forKey: "type")
        }
    }
    
    
    func savedAttendes(attendies:NSArray){
        let indexpath = IndexPath(row: 7, section: 1) as IndexPath
        let cell = tblAddEdit.cellForRow(at: indexpath) as! AttendeesCell
        
        
        eventDictionary.setObject(attendies, forKey: "attendies" as NSCopying)
        
       
        
        var xaxes = 10
        for obj in attendies{
            
           // var imageViewObject :UIImageView
           
           let co  = obj
            
            let myImageView:UIImageView = UIImageView()
            //myImageView.image = myImage
            myImageView.contentMode = UIViewContentMode.scaleAspectFit
            myImageView.frame.size.width = 32
            myImageView.frame.size.height = 32
           // myImageView.center = self.view.center
            myImageView.frame.origin.y = 2
           // myScrollView.addSubview(myImageView)
            myImageView.backgroundColor = UIColor.red
            myImageView.frame.origin.x = CGFloat(xaxes)
            myImageView.layer.cornerRadius = 15.0
            
            cell.scrollView.addSubview(myImageView)
            
            xaxes += 40
            
            
          attendeasArray.add(self.addAttendes(val: obj as! NSDictionary ))
        }
    }
    
    
    
    func addAttendes(val:NSDictionary) -> NSDictionary {
        
        
        let dict = NSMutableDictionary()
        //set the entity values
        dict.setValue(val.value(forKey: "givenName"), forKey: "displayName")
        dict.setValue(val.value(forKey: "emailAddresses"), forKey: "emailId")
        dict.setValue("", forKey: "eventCalId")
        dict.setValue("", forKey: "eventId")
        dict.setValue("", forKey: "firstName")
        dict.setValue("", forKey: "imageUrl")
        dict.setValue( String(describing: val.value(forKey: "phoneNumbers")) , forKey: "phoneNo")
        dict.setValue("", forKey: "status")
        dict.setValue("", forKey: "userId")
        dict.setValue("", forKey: "initails")
        dict.setValue (false, forKey: "isDelay")
        dict.setValue("", forKey: "localCalSts")
        dict.setValue("", forKey: "ownerId")
        
        
        
        print("Attend  \(val)")
        
        return dict
    }
    
    
    
    
    
    
    //Date picker
    /*func datePickerChanged(sender: AnyObject) {
        
        var datepicker: sender
        if(open1){
            
            startDateTime = datePicker.date
        }else if(open2){
            endDateTime = datePicker.date
        }
        
        setDateAndTime()
    }*/
    
    
    //MARK:- Date and time
    func datePickerChanged(datePicker:UIDatePicker) {
        
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEE, dd MMM YYYY   hh:mm a"
        //dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        //dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        if(open1){
            
            startDateTime = datePicker.date
            
            let indexpath = IndexPath(row: 0, section: 1) as IndexPath
            let cell = tblAddEdit.cellForRow(at: indexpath) as! DatePickerCell
            cell.lblStartDate.text = dateFormatter.string(from: startDateTime) as String
        
            //if endDateTime == nil {
                
                endDateTime = datePicker.date.addingTimeInterval(60*60)
                let indexpath2 = IndexPath(row: 1, section: 1) as IndexPath
                let cell2 = tblAddEdit.cellForRow(at: indexpath2) as! DatePickerCell
                cell2.lblStartDate.text = dateFormatter.string(from: endDateTime)
            //}
            
            
        }else if(open2){
            endDateTime = datePicker.date
            
            let indexpath = IndexPath(row: 1, section: 1) as IndexPath
            let cell = tblAddEdit.cellForRow(at: indexpath) as! DatePickerCell
            
            cell.lblStartDate.text = dateFormatter.string(from: endDateTime)
        }

        
    }

    @IBAction func DatepicketValueChange(_ sender: UIDatePicker) {
        
        let datePicker = sender as UIDatePicker
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM YYYY   hh:mm a"
     
        
        if(open1){
            
            startDateTime = datePicker.date
            let indexpath = IndexPath(row: 0, section: 1) as IndexPath
            let cell = tblAddEdit.cellForRow(at: indexpath) as! DatePickerCell
            cell.lblStartDate.text = dateFormatter.string(from: datePicker.date) as String
            
            endDateTime = datePicker.date.addingTimeInterval(60*60)
            let indexpath2 = IndexPath(row: 1, section: 1) as IndexPath
            let cell2 = tblAddEdit.cellForRow(at: indexpath2) as! DatePickerCell
            cell2.lblStartDate.text = dateFormatter.string(from: endDateTime)

        }else if(open2){
            endDateTime = datePicker.date
            
            let indexpath = IndexPath(row: 1, section: 1) as IndexPath
            let cell = tblAddEdit.cellForRow(at: indexpath) as! DatePickerCell
            
            cell.lblStartDate.text = dateFormatter.string(from: datePicker.date)
        }
        
      //  print(sender.date)
        
        
    }
    
    
    
    
    @IBAction func saveEvent(_ sender: AnyObject) {
        
        let indexpath = IndexPath(row: 0, section: 0) as IndexPath
        
        let cell = tblAddEdit.cellForRow(at: indexpath) as! AddEventTitleCell
        let title = cell.txtTitle.text
        
        
        if editSts {
            
            let imgData = UIImageJPEGRepresentation(selImage, 1)
            editManageobj.setValue(imgData, forKey: "image")
            
            
            editManageobj.setValue(title, forKey: "title")
            editManageobj.setValue(startDateTime, forKey: "startDateTime")
            editManageobj.setValue(endDateTime, forKey: "endDateTime")
            
            
            DBHelper.sharedInstance.UpdateMCalEventDB(eventObj: editManageobj) { (result) in
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: refreshDate), object: nil)
            
                
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);

                
                //let _ = self.navigationController?.popViewController(animated: true)
            }

            
        }else{
            
            let imgData = UIImageJPEGRepresentation(selImage, 1)
            eventDictionary.setValue(imgData, forKey: "image")
            
            
            let eventid = idGenrator.sharedInstance.NewEventid() as String
            
            eventDictionary.setValue(eventid, forKey: "eventId")
            eventDictionary.setValue(startDateTime, forKey: "startDateTime")
            eventDictionary.setValue(endDateTime, forKey: "endDateTime")
            eventDictionary.setValue(startDateTime, forKey: "creationDate")
            eventDictionary.setValue(title, forKey: "title")
        
            DBHelper.sharedInstance.AddMCalEventInDB(eventData: eventDictionary ,attendeas:attendeasArray) { (result) in
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: refreshDate), object: nil)
                
                let _ = self.navigationController?.popViewController(animated: true)
            }
            
            
            
        }
        
        
    }
    
}
