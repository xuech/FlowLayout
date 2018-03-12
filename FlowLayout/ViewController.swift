//
//  ViewController.swift
//  FlowLayout
//
//  Created by xuech on 2017/6/7.
//  Copyright © 2017年 xuech. All rights reserved.
//

import UIKit
private let kContentCellID = "kContentCellID"

class ViewController: UIViewController,UICollectionViewDataSource,XCHWaterFallLayoutDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }

    fileprivate lazy var collectionView : UICollectionView = {
        let layout = XCHWaterFallLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        layout.dataSource = self
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
        
    }
    
    func numberOfCols(_ waterfallLayout:XCHWaterFallLayout) -> Int{
        return 2
    }
    
    func waterfall(_ waterfallLayout:XCHWaterFallLayout,item: Int) ->CGFloat {
        return CGFloat(arc4random_uniform(50) + 100)
    }
}

