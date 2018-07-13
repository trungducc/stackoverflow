//
//  ViewController.swift
//  CountdownLabel
//
//  Created by Trung Duc on 7/13/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

import UIKit

extension String {
  func widthOfString(usingFont font: UIFont) -> CGFloat {
    let fontAttributes = [NSAttributedStringKey.font: font];
    let size = self.size(withAttributes: fontAttributes);
    return size.width
  }
}

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    let displayedText = "Price valid for _counDownTimer_. All prices are inclusive of 9234% GST.";

    // Add main label
    let textLabel = UILabel.init();
    textLabel.translatesAutoresizingMaskIntoConstraints = false;
    textLabel.textColor = UIColor.darkGray;
    textLabel.numberOfLines = 0;
    textLabel.text = displayedText.replacingOccurrences(of: "_counDownTimer_", with: "         ");
    self.view.addSubview(textLabel);

    // Update constraints for |textLabel|
    textLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true;
    textLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true;
    textLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true;

    // Add timer label
    let countDownLabel = UILabel.init();
    countDownLabel.textColor = UIColor.green;
    countDownLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.view.addSubview(countDownLabel);

    // Calculate position and update constraints of |countDownLabel|
    let timerTextRange = displayedText.range(of: "_counDownTimer_");
    let textBeforeTimer = displayedText.substring(to: (timerTextRange?.lowerBound)!);
    let leadingConstant = textBeforeTimer.widthOfString(usingFont: textLabel.font);

    countDownLabel.topAnchor.constraint(equalTo: textLabel.topAnchor).isActive = true;
    countDownLabel.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor, constant: leadingConstant).isActive = true;

    // Update |countDownLabel| each 1 second
    var seconds : Int = 50;
    var minutes : Int = 4;
    countDownLabel.text = String(format: "%d:%02d", minutes, seconds);

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      seconds = seconds + 1;

      if seconds == 60 {
        seconds = 0;
        minutes = minutes + 1;
      }

      countDownLabel.text = String(format: "%d:%02d", minutes, seconds);
    };
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
