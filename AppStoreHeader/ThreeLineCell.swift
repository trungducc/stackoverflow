//
//  ThreeLineCell.swift
//  DemoAppStoreHeader
//
//  Created by Trung Duc on 5/22/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

import UIKit

class ThreeLineCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

  @IBOutlet weak var collectionView: UICollectionView!

  override func awakeFromNib() {
    super.awakeFromNib()

    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

    if indexPath.row % 3 == 0 {
      cell.backgroundColor = .lightGray
    } else if indexPath.row % 3 == 1 {
      cell.backgroundColor = .black
    } else {
      cell.backgroundColor = .darkGray
    }
    cell.layer.cornerRadius = 5

    return cell;
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: (frame.width - 30) / 2, height: (collectionView.frame.height - 30) / 2)
  }
}
