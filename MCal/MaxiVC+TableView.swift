//
//  MaxiVC+TableView.swift
//  MCal
//
//  Created by Maahi on 30/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

extension MaxiVC: UITableViewDelegate,UITableViewDataSource {
    
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "MaxiCell", for: indexPath ) as! MaxiCell
            return cell
        
        
    }
    
    
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if attendiesList.count > 0 {
            return attendiesList.count
        }else{
            return 1
        }
        
    }
    
    
    func configureCell(cell: EventCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        
    }
    

    
    
}
