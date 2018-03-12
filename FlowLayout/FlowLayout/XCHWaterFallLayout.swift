//
//  XCHWaterFallLayout.swift
//  FlowLayout
//
//  Created by xuech on 2017/6/7.
//  Copyright © 2017年 xuech. All rights reserved.
//

import UIKit

protocol XCHWaterFallLayoutDataSource:class {
    /// 显示的行数
    func numberOfCols(_ waterfallLayout:XCHWaterFallLayout) -> Int

    /// 每个cell的高
    func waterfall(_ waterfallLayout:XCHWaterFallLayout,item: Int) ->CGFloat
}

class XCHWaterFallLayout: UICollectionViewFlowLayout {
    weak var dataSource :XCHWaterFallLayoutDataSource?
    
    fileprivate lazy var cellAttr : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var cols: Int = {
        let count = self.dataSource?.numberOfCols(self) ?? 2
        return count > 0 ? count : 2
    }()
    
    fileprivate lazy var diffHeights : [CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
    
    override func prepare() {
        super.prepare()
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        let cellW : CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols-1)*minimumInteritemSpacing)/CGFloat(cols)
        
        for i in 0..<itemCount {
            let index = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: index)
            let minH  = diffHeights.min()!
            let minIndex  = diffHeights.index(of: minH)!
            let cellX :CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW)*CGFloat(minIndex)
            guard let cellH :CGFloat = dataSource?.waterfall(self, item: i) else{
                fatalError("xxxx")
            }
            let cellY :CGFloat = minH + minimumLineSpacing
            
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            cellAttr.append(attr)
            
            diffHeights[minIndex] = minH + cellH + minimumLineSpacing
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttr
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: diffHeights.max()!)
    }
}
