//
//  TableViewController.swift
//  MemeMe
//
//  Created by Kirill Sidelkovsky on 26.10.2020.
//  Copyright © 2020 sidelkovsky.com. All rights reserved.
//

import UIKit

class TableViewController:UITableViewController {
        
    @IBAction func createMeme(_ sender: Any) {
        
        presentMemeCreator()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: NSNotification.Name(rawValue: "reloadMemes"), object: nil)
        
    }
    
    @objc func reloadTableData(_ notification: NSNotification) {
        tableView.reloadData()
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeDataStore.shared.getMemes().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell",
                                                 for: indexPath)
        
        let item = MemeDataStore.shared.getMemes()[indexPath.row]
        
        cell.textLabel?.text = "\(item.topText! as String)/\(item.bottomText! as String)"
        cell.imageView?.image = item.memedImage

        return cell
        
    }
}
