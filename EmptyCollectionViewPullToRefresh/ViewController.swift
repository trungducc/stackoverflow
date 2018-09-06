//
//  ViewController.swift
//  EmptyCollectionViewPullToRefresh
//
//  Created by Trung Duc on 9/6/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

import UIKit

class EmptyCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)

    let backgroundImage = UIImageView.init(frame: frame)
    backgroundImage.image = UIImage.init(named: "bg")
    backgroundImage.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.contentView.addSubview(backgroundImage)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

  @IBOutlet weak var collectionView: UICollectionView!

  var shouldShowEmptyCell = false

  let refreshControl: UIRefreshControl = {
    let refreshControl: UIRefreshControl = UIRefreshControl.init()
    refreshControl.addTarget(self, action: #selector(refreshCollectionView(_:)), for: .valueChanged)
    return refreshControl;
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: "EmptyCell")
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "NormalCell")

    addRefreshControl()
  }

  func addRefreshControl() -> Void {
    if #available(iOS 10.0, *) {
      collectionView.refreshControl = self.refreshControl
    } else {
      collectionView.addSubview(self.refreshControl)
    }
  }

  @objc private func refreshCollectionView(_ sender: Any) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      self.shouldShowEmptyCell = !self.shouldShowEmptyCell
      self.collectionView.reloadData()
      self.refreshControl.endRefreshing()
    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return shouldShowEmptyCell ? 1 : 20;
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if shouldShowEmptyCell {
      return collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
    }

    let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath)

    if indexPath.row % 3 == 0 {
      cell.backgroundColor = .red
    } else if indexPath.row % 3 == 1 {
      cell.backgroundColor = .blue
    } else if indexPath.row % 3 == 2 {
      cell.backgroundColor = .green
    }
    cell.layer.cornerRadius = 10

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8;
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8;
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if shouldShowEmptyCell {
      return collectionView.bounds.size
    }

    return CGSize.init(width: collectionView.bounds.width / 2 - 4, height: collectionView.bounds.width / 2 - 4)
  }
}

