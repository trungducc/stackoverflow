import UIKit

class TestScrollViewController: UIViewController, UIScrollViewDelegate, PanelAnimationControllerDelegate {
	@IBOutlet weak private var testScrollView:UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      testScrollView.delegate = self
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      testScrollView.bounces = (testScrollView.contentOffset.y > 10)
    }

    func shouldHandlePanelInteractionGesture() -> Bool {
      return (testScrollView.contentOffset.y == 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
