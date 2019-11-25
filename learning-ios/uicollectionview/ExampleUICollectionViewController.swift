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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uiCollectionView.dataSource = self
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
