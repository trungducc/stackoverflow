import Foundation
import UIKit

class PanelTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
	fileprivate let panelAnimationControllerPresent:PanelAnimationController
	fileprivate let panelAnimationControllerDismiss:PanelAnimationController

	fileprivate let swipeInteractionController = PanelInteractionController()

	override init() {
		self.panelAnimationControllerPresent	= PanelAnimationController(isPresentation: true)
		self.panelAnimationControllerDismiss	= PanelAnimationController(isPresentation: false)
	}

	func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		let presentationController = PanelPresentationController(presentedViewController: presented, presenting: presenting)

		self.swipeInteractionController.wireToViewController(viewController: presented)

		return presentationController
	}
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self.panelAnimationControllerPresent
	}
	
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self.panelAnimationControllerPresent
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self.panelAnimationControllerDismiss
	}

	func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		if self.swipeInteractionController.interactionInProgress == true {
			return self.swipeInteractionController
		} else {
			return nil
		}
	}
}
