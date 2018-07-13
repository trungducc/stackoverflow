//
//  ViewController.swift
//  BigTitleNavigationBar
//
//  Created by Trung Duc on 7/13/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    let logo = UIImage(named: "Logo")
    let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    let imageView = UIImageView(image: logo)
    imageView.frame = CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
    titleView.addSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    imageView.image = logo
    navigationItem.titleView = titleView
    navigationController?.navigationBar.subviews[2].addObserver(self, forKeyPath: "clipsToBounds", options: [.old, .new], context: nil)
  }

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if  (navigationController?.navigationBar.subviews[2].isEqual(object))! {
      DispatchQueue.main.async {
        self.navigationController?.navigationBar.subviews[2].clipsToBounds = false
        self.navigationItem.titleView?.layoutIfNeeded()
      }
    }
  }

  deinit {
    navigationController?.navigationBar.subviews[2].removeObserver(self, forKeyPath: "clipsToBounds")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

