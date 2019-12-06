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
        let sectionId: Int
        
        init(title: String, sectionId: Int) {
            self.title = title
            self.sectionId = sectionId
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        private let identifier = UUID()
    }
    
    class Section: Hashable {
        let id: Int
        let title: String
        
        init(id: Int, title: String) {
            self.id = id
            self.title = title
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func == (lhs: Section, rhs: Section) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        private let identifier = UUID()
    }
    
    @IBOutlet weak var customUICollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customUICollectionView.register(UINib(nibName: "ExampleCustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "customCell")
        self.customUICollectionView.register(UINib(nibName: "ExampleCustomHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: "ExampleCustomHeader-kind", withReuseIdentifier: "customHeaderCell")
        
        self.customUICollectionView.collectionViewLayout = generateLayout()
        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self.customUICollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: Item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! ExampleCustomCollectionViewCell
            cell.backgroundColor = .red
            cell.exampleLabel.text = item.title
            return cell
        }
        
        self.dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath)
            -> UICollectionReusableView? in
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "customHeaderCell",
                for: indexPath) as? ExampleCustomHeaderCollectionViewCell else {
                    fatalError("Cannot create header view")
            }
            
            guard let item = self.dataSource.itemIdentifier(for: indexPath) else {
                fatalError("Cannot find item")
            }
            guard let section = self.dataSource.snapshot().sectionIdentifier(containingItem: item) else {
                fatalError("Cannot find section")
            }
            
            headerView.titleLabel.text = section.title
            
            return headerView
        }
        
        let items1 = (0...10).map{ Item(title: "item:\($0)", sectionId: 0) }
        let items2 = (0...10).map{ Item(title: "item:\($0)", sectionId: 1) }
        let items3 = (0...10).map{ Item(title: "item:\($0)", sectionId: 2) }
        let items4 = (0...10).map{ Item(title: "item:\($0)", sectionId: 3) }
        let items5 = (0...10).map{ Item(title: "item:\($0)", sectionId: 4) }
        let items6 = (0...10).map{ Item(title: "item:\($0)", sectionId: 5) }
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapShot.appendSections([Section(id: 0, title: "Section1")])
        snapShot.appendItems(items1)
        
        snapShot.appendSections([Section(id: 1, title: "Section2")])
        snapShot.appendItems(items2)
        
        snapShot.appendSections([Section(id: 2, title: "Section3")])
        snapShot.appendItems(items3)
        
        snapShot.appendSections([Section(id: 3, title: "Section4")])
        snapShot.appendItems(items4)
        
        snapShot.appendSections([Section(id: 4, title: "Section5")])
        snapShot.appendItems(items5)
        
        snapShot.appendSections([Section(id: 5, title: "Section6")])
        snapShot.appendItems(items6)
        
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let fullItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: fullItem, count: 1)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: "ExampleCustomHeader-kind",
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
