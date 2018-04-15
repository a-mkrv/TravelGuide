//
//  FilterViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 15/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailNameCell", for: indexPath) as! DetailNameTableViewCell
        return cell
    }
}
