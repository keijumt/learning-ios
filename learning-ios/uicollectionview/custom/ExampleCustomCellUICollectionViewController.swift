//
//  ExampleCustomCellUICollectionViewController.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/27.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit

class ExampleCustomCellUICollectionViewController: UIViewController {
    
    class Item: Hashable {
        let title: String
        
        init(title: String) {
            self.title = title
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        private let identifier = UUID()
    }
    
    enum Section {
        case defaultItem
    }
    
    @IBOutlet weak var customUICollectionView: UICollectionView!
    private let items = (0...30).map{ Item(title: "item:\($0)") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customUICollectionView.register(UINib(nibName: "ExampleCustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "customCell")

        self.customUICollectionView.collectionViewLayout = generateLayout()
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self.customUICollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: Item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! ExampleCustomCollectionViewCell
            cell.backgroundColor = .red
            return cell
        }
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapShot.appendSections([Section.defaultItem])
        snapShot.appendItems(self.items)
        
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
        let fullItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: fullItem, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
