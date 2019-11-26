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
        let layout = UICollectionViewFlowLayout()
        
        // 周りの余白を設定
        layout.sectionInset = self.sectionInset
        
        // アイテムの大きさを設定
        let itemSpacing = self.sectionInset.left * (column - 1)
        let availableWidth = self.view.bounds.width - itemSpacing - (sectionInset.left * 2)
        layout.itemSize = CGSize(width: availableWidth / column, height: availableWidth / column)

        // アイテムの垂直方向のスペースを設定
        layout.minimumLineSpacing = sectionInset.left
        
        self.uiCollectionView.collectionViewLayout = layout
    }
}

extension ExampleUICollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.uiCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
