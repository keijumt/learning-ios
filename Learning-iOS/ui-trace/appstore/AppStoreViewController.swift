//
//  AppStoreViewController.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/06.
//

import UIKit

class AppStoreViewController: UIViewController {
    
    @IBOutlet weak var appStoreCollectionView: UICollectionView!
    
    enum ItemKind: Hashable {
        case storeItem(StoreItem)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<StoreSection, ItemKind>!
    private var snapshot = NSDiffableDataSourceSnapshot<StoreSection, ItemKind>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appStoreCollectionView.register(UINib(nibName: "StoreItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StoreItemCollectionViewCell.reuseIdentifier)
        appStoreCollectionView.register(UINib(nibName: "StoreItemFullCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StoreItemFullCollectionViewCell.reuseIdentifier)
        
        appStoreCollectionView.collectionViewLayout = generateLayout()
        
        dataSource = UICollectionViewDiffableDataSource<StoreSection, ItemKind>(collectionView: appStoreCollectionView) { [weak self] (collectionView: UICollectionView, indexPath: IndexPath, itemKind: ItemKind) in
            
            guard let section = self?.snapshot.sectionIdentifier(containingItem: itemKind) else { return nil }
            
            switch(section, itemKind) {
            case (let storeSection as StoreTopicSection, .storeItem(let storeItem)):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreItemCollectionViewCell.reuseIdentifier, for: indexPath)
                return cell
            case (let storeSection as StorePopularitySection, .storeItem(let storeItem)):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreItemFullCollectionViewCell.reuseIdentifier, for: indexPath)
                return cell
            case (_, _):
                return nil
            }
        }
        
        let _ = (0...6).map {_ in
            let items = (0...9).map { StoreItem(id: UUID().hashValue, name: "アプリ名:\($0)", description: "概要概要概要]\($0)", avaterUrl: "") }
            var section: StoreSection
            if Bool.random() {
                section = StoreTopicSection(id: UUID().hashValue)
            } else {
                section = StorePopularitySection(id: UUID().hashValue)
            }
            snapshot.appendSections([section])
            snapshot.appendItems(items.map(ItemKind.storeItem), toSection: section)
        }
        
        dataSource.apply(snapshot)
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] ( sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = self?.dataSource.snapshot().sectionIdentifiers[sectionIndex] else { return nil }
            
            switch(section) {
            case is StoreTopicSection:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/4))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(14/15), heightDimension: .fractionalWidth(3/5))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
            case is StorePopularitySection:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(14/15), heightDimension: .fractionalWidth(4/5))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                
                group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
            default:
                return nil
            }
        }
        return layout
    }
}
