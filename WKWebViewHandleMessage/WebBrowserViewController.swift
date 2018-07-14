//
//  ViewController.swift
//  WKWebViewHandleMessage
//
//  Created by Trung Duc on 7/14/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

import UIKit
import KINWebBrowser

class WebBrowserViewController: KINWebBrowserViewController, WKScriptMessageHandler {

  override func viewDidLoad() {
    super.viewDidLoad()

    addGetWebTitleBtn()
    addScriptHandler()

    showsURLInNavigationBar = true
    showsPageTitleInNavigationBar = true
    showsURLInNavigationBar = true

    // Change url to load and show another title
    loadURLString("https://apple.com")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func addScriptHandler() -> Void {
    wkWebView.configuration.userContentController.add(self, name: "callbackHandler")
  }

  func addGetWebTitleBtn() -> Void {
    let btnShowWebTitle = UIButton.init()
    btnShowWebTitle.translatesAutoresizingMaskIntoConstraints = false
    btnShowWebTitle.setTitle("Show Web Title", for: .normal)
    btnShowWebTitle.backgroundColor = .red
    btnShowWebTitle.addTarget(self, action: #selector(btnShowWebTitleDidTouch), for: .touchUpInside)
    view.addSubview(btnShowWebTitle)

    btnShowWebTitle.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    btnShowWebTitle.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
    btnShowWebTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
    btnShowWebTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }

  @objc func btnShowWebTitleDidTouch() -> Void {
    wkWebView.evaluateJavaScript("window.webkit.messageHandlers.callbackHandler.postMessage(document.title);", completionHandler: nil)
  }

  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    if message.name == "callbackHandler" {
      let alert : UIAlertController = UIAlertController.init(title: (message.body as? String), message: nil, preferredStyle: .alert)
      let okAction : UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)
      self.present(alert, animated: true, completion: nil)
    }
  }

}
