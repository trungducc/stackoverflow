//
//  ViewController.swift
//  AppStoreHeader
//
//  Created by Trung Duc on 7/13/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.delegate = self
    tableView.dataSource = self

    tableView.register(UINib.init(nibName: "OneLineCell", bundle: Bundle.main), forCellReuseIdentifier: "OneLineCell")
    tableView.register(UINib.init(nibName: "ThreeLineCell", bundle: Bundle.main), forCellReuseIdentifier: "ThreeLineCell")
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20;
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier : String = indexPath.row % 3 == 0 ? "OneLineCell" : "ThreeLineCell"
    return tableView.dequeueReusableCell(withIdentifier: identifier)!
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.row % 3 == 0 ? 150 : 200
  }

}

