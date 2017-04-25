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

    var editManageobj = NSManagedObject()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        //let btnEdit = UIBarButtonItem(barButtonSystemItem: .custom, target: self, action: #selector(EditClick))
        let btnEdit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(EditClick))
        
        navigationItem.rightBarButtonItems = [btnEdit]
        
        
        
        
    }

    func loadEditEvent(event:NSManagedObject)  {
        editManageobj = event
    }
    
    func EditClick() {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "AddEdit") as! EventAddEditVC
        
        //vc.resultsArray = self.resultsArray
        self.navigationController?.pushViewController(vc, animated:true)
        //toAddEdit
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
    
        if segue.identifier == "toAddEdit"{
            if let nextViewController = segue.destination as? EventAddEditVC{
                // nextViewController.editDict=nil;
                
            }
            
        }
    
    
    }
    

}
