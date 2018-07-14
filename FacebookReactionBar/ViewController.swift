//
//  ViewController.swift
//  FacebookReactionBar
//
//  Created by Trung Duc on 7/14/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var imvLove: UIImageView!
  @IBOutlet weak var imvAngry: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    let imvLoveMask = UIImageView.init(image: UIImage.init(named: "mask"));
    imvLoveMask.frame = CGRect.init(x: 0, y: 0, width: imvLove.frame.size.width, height: imvLove.frame.size.height);
    imvLove.mask = imvLoveMask;

    let imvAngryMask = UIImageView.init(image: UIImage.init(named: "mask"));
    imvAngryMask.frame = CGRect.init(x: 0, y: 0, width: imvAngry.frame.size.width, height: imvAngry.frame.size.height);
    imvAngry.mask = imvAngryMask;
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
