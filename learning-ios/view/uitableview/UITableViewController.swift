//
//  UITableViewController.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/22.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit

class UITableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var items: [String] = (1...50).map { "item\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
    }
}

extension UITableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
