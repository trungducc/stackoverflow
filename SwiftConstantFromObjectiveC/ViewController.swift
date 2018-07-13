//
//  ViewController.swift
//  SwiftConstantFromObjectiveC
//
//  Created by Trung Duc on 7/14/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    print(Constants.definedObjectString())
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

