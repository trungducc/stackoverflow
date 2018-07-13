import UIKit

class PlainViewController: UIViewController, PanelAnimationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func shouldHandlePanelInteractionGesture() -> Bool {
      return true
    }
}
