import UIKit

class RootViewController: UIViewController {
	var panelTransitioningDelegate = PanelTransitioningDelegate()

	override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction func handlePlainViewButton(_ sender:Any) {
		let testPlainViewController = PlainViewController(nibName: "PlainViewController", bundle: nil)
		testPlainViewController.transitioningDelegate				= self.panelTransitioningDelegate
		testPlainViewController.modalPresentationStyle				= .custom

		self.present(testPlainViewController, animated: true, completion: nil)
	}

	@IBAction func handleScrollViewButton(_ sender:Any) {
		let testScrollViewController = TestScrollViewController(nibName: "TestScrollViewController", bundle: nil)
		testScrollViewController.transitioningDelegate				= self.panelTransitioningDelegate
		testScrollViewController.modalPresentationStyle				= .custom

		self.present(testScrollViewController, animated: true, completion: nil)
	}
	
	@IBAction func handleTableViewButton(_ sender:Any) {
		let testTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
		testTableViewController.transitioningDelegate				= self.panelTransitioningDelegate
		testTableViewController.modalPresentationStyle				= .custom

		self.present(testTableViewController, animated: true, completion: nil)
	}
	
	@IBAction func handleWebViewButton(_ sender:Any) {
		let testWebViewController = TestWebViewController(nibName: "TestWebViewController", bundle: nil)
		testWebViewController.transitioningDelegate					= self.panelTransitioningDelegate
		testWebViewController.modalPresentationStyle				= .custom

		self.present(testWebViewController, animated: true, completion: nil)
	}
}
