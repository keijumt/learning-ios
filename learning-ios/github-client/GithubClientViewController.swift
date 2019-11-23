//
//  GithubClientViewController.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/23.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit
import RxSwift

class GithubClientViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: GithubClientViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var repos:[Repo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        
        self.viewModel = GithubClientDependency.resolveGithubViewModel()
        let output = self.viewModel.transform(input: GithubClientInput())
        output.repos.drive(
            onNext: {
                self.repos = $0
                self.tableView.reloadData()
        },
            onCompleted: { print("complete") },
            onDisposed: { print("dispose") }
        ).disposed(by: self.disposeBag)
    }
}

extension GithubClientViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        cell.set(repo: self.repos[indexPath.row])
        return cell
    }
}
