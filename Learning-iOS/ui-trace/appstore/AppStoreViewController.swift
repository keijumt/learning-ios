//
//  AppStoreViewController.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/06.
//

import UIKit

class AppStoreViewController: UIViewController {
    
    @IBOutlet weak var appStoreCollectionView: UICollectionView!
    
    enum SectionKind:Int {
        case carouselThreeRow
        case carouselFull
    }
    
    enum ItemKind: Hashable {
        case storeItem(StoreItem)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<SectionKind, ItemKind>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appStoreCollectionView.register(UINib(nibName: "StoreItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StoreItemCollectionViewCell.reuseIdentifier)
        appStoreCollectionView.register(UINib(nibName: "StoreItemFullCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StoreItemFullCollectionViewCell.reuseIdentifier)
        
        appStoreCollectionView.collectionViewLayout = generateLayout()
        
        dataSource = UICollectionViewDiffableDataSource<SectionKind, ItemKind>(collectionView: appStoreCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemKind: ItemKind) in
            
            switch(SectionKind(rawValue: indexPath.section), itemKind) {
            case (.some(.carouselThreeRow), .storeItem(let storeItem)):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreItemCollectionViewCell.reuseIdentifier, for: indexPath)
                return cell
            case (.some(.carouselFull), .storeItem(let storeItem)):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreItemFullCollectionViewCell.reuseIdentifier, for: indexPath)
                return cell
            case (.none, _):
                return nil
            }
        }
        
        let fullItems = (0...5).map { StoreItem(id: Int.random(in: 0..<1000), name: "アプリ名:\($0)", description: "概要概要概要]\($0)", avaterUrl: "") }
        let items1 = (0...9).map { StoreItem(id: UUID().hashValue, name: "アプリ名:\($0)", description: "概要概要概要]\($0)", avaterUrl: "") }
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, ItemKind>()
        
        snapshot.appendSections([.carouselFull])
        snapshot.appendItems(fullItems.map(ItemKind.storeItem), toSection: .carouselFull)
        
        snapshot.appendSections([.carouselThreeRow])
        snapshot.appendItems(items1.map(ItemKind.storeItem), toSection: .carouselThreeRow)
        
        dataSource.apply(snapshot)
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { ( sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch(SectionKind(rawValue: sectionIndex)) {
            case .carouselThreeRow:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/4))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(14/15), heightDimension: .fractionalWidth(3/5))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
            case .carouselFull:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(14/15), heightDimension: .fractionalWidth(4/5))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                
                group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
            case .none:
                return nil
            }
        }
        return layout
    }
}
