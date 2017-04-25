//
//  EventTypeVC.swift
//  MCal
//
//  Created by Maahi on 25/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit



// here is the protocol for creating the delegation:
protocol EventTypeVCDelegate {
    func selectedEventType(type:String)
    
}


class EventTypeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // MARK:- Delegate
    var delegate:EventTypeVCDelegate?
    
    var typeArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.automaticallyAdjustsScrollViewInsets = false
        
        
        typeArray.add("Personal")
        typeArray.add("Business")
        typeArray.add("Professional")
        typeArray.add("Family")
        typeArray.add("Leisure/Fun")
        
        
        
        
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
        if indexPath.section == 0  {
            cell.textLabel?.text = "None"
        }else{
            cell.textLabel?.text = typeArray.object(at: indexPath.row) as? String
        }
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        if section == 0  {
            return 1
        }else{
            return typeArray.count
        }
        
    }
    
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let value = typeArray.object(at: indexPath.row)
        delegate?.selectedEventType(type:value as! String)
        
        let _ = self.navigationController?.popViewController(animated: true)
    }
    

}
