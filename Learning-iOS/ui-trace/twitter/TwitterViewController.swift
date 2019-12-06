//
//  TwitterViewController.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/06.
//

import UIKit

class TwitterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    enum SectionKind: Int {
        case tweets
    }
    
    enum ItemKind: Hashable {
        case tweet(Tweet)
    }
    
    private lazy var dataSource = UITableViewDiffableDataSource<SectionKind, ItemKind>(tableView: tableView) { [weak self] (tableView, indexPath, itemKind) -> UITableViewCell? in
        switch(SectionKind(rawValue: indexPath.section), itemKind) {
        case (.some(.tweets), .tweet(let tweet)):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TwitterTableViewCell
            cell.bind(tweet: tweet)
            return cell
        case (.none, _):
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tweets = (0...30).map {
            Tweet(id: $0, displayName: "name:\($0)", userId: "id:\($0)", content: "tweet tweet tweet tweet tweet tweet tweet tweet tweet tweet tweet tweet tweet tweet tweet tweet: \($0)", avatarUrl: "", date: 1)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, ItemKind>()
        snapshot.appendSections([.tweets])
        snapshot.appendItems(tweets.map(ItemKind.tweet), toSection: .tweets)
        
        dataSource.apply(snapshot)
    }
}
