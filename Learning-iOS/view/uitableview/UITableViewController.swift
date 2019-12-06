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
    
    private let refreshControl = UIRefreshControl()
    
    private var items: [String] = (1...50).map { "title\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "ExampleUITableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleUITableViewCell")
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
        items = (1...50).map { "title\($0 + Int.random(in: 1...10))" }
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension  UITableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension UITableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExampleUITableViewCell", for: indexPath) as! ExampleUITableViewCell
        cell.set(item: items[indexPath.row])
        return cell
    }
}
