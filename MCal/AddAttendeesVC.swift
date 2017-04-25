//
//  AddAttendeesVC.swift
//  MCal
//
//  Created by Maahi on 25/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import Contacts


// here is the protocol for creating the delegation:
protocol AddAttendeesVCDelegate {
    func savedAttendes(attendies:NSArray)
    
}


class AddAttendeesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var delegate:AddAttendeesVCDelegate?
    
    let contactlist = NSMutableArray()
    let selectedContact = NSMutableArray()
    var contactStore = CNContactStore()
    var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         self.automaticallyAdjustsScrollViewInsets = false
       
        
        
        
        let keys = [CNContactFormatter.descriptorForRequiredKeys (for: .fullName), CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        
        do {
            try self.contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                self.contacts.append(contact)
            }
        }
        catch {
            print("unable to fetch contacts")
        }
        
        
        
        print(contacts)
        
        
        
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath ) as! ContactCell
        
        let currentContact = contacts[indexPath.row]
        //let dic = self.contacts.ob
        cell.lblName?.text = currentContact.givenName
       // cell.lblPhoneNo?.text = currentContact.phoneNumbers as String
        
        if let imageData = currentContact.imageData {
            cell.imgView?.image = UIImage(data: imageData)
        }else{
            cell.imgView?.image = UIImage(named:"icon.png")
        }
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
            return self.contacts.count
        
    }
    
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let str = contacts[indexPath.row].givenName as String
        
        if selectedContact.contains(str) {
            //do something
            
            let alert = UIAlertController(title: "Alert", message: "Already exist", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }else
        {
            selectedContact.add(str)
        }
    }
    

    @IBAction func DoneClicked(_ sender: AnyObject) {
        delegate?.savedAttendes(attendies: selectedContact)
        //self.navigationController?.popViewController(animated: true)
        let _ = self.navigationController?.popViewController(animated: true)
    }
}
