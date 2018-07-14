//
//  ViewController.swift
//  AnimateLabelTextColor
//
//  Created by Trung Duc on 7/14/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var label: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func btnAnimateDidTouch(_ sender: Any) {
    UIView.transition(with: view, duration: 1, options: .transitionCrossDissolve, animations: {
      self.label.textColor = .green
    }) { (_) in
      UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
        self.label.textColor = .red
      }, completion: nil)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

