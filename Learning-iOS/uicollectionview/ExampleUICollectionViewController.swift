//
//  ExampleUICollectionViewController.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/25.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit

class ExampleUICollectionViewController: UIViewController {
    
    @IBOutlet weak var uiCollectionView: UICollectionView!
    private let column: CGFloat = 3
    private let sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uiCollectionView.dataSource = self
        self.uiCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        
        // アイテムの大きさを設定
        let itemSpacing = self.sectionInset.left * (column - 1)
        let availableWidth = self.view.bounds.width - itemSpacing - (sectionInset.left * 2)
        layout.itemSize = CGSize(width: availableWidth / column, height: availableWidth / column)
        
        // アイテムの垂直方向のスペースを設定
        layout.minimumLineSpacing = sectionInset.left
        
        layout.footerReferenceSize = CGSize(width: 0, height: 100)
        
        self.uiCollectionView.collectionViewLayout = layout
    }
}

extension ExampleUICollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 20
        case 1:
            return 5
        case 2:
            return 10
        default:
            fatalError("section \(section) is not found")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.uiCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.backgroundColor = Asset.Colors.colorPrimary.color
        case 1:
            cell.backgroundColor = .green
        case 2:
            cell.backgroundColor = .blue
        default:
            break
        }
        return cell
    }
}

extension ExampleUICollectionViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            return self.uiCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        }else if kind == UICollectionView.elementKindSectionFooter {
            return self.uiCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
        }
        
        return UICollectionReusableView()
    }
}

extension ExampleUICollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0, 2 :
            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        case 1 :
            return UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
        default:
            fatalError("section \(section) is not found")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 1:
            return CGSize(width: 0, height: 100)
        default:
            return CGSize(width: 0, height: 50)
        }
    }
}
