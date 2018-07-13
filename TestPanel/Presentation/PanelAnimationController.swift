import Foundation
import UIKit

class PanelAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
	let duration										= 0.25
	var isPresentation: Bool							= true

	init(isPresentation: Bool) {
		super.init()

		self.isPresentation			= isPresentation
	}
	
	private func returnOriginPoint(fromView:UIView, toView:UIView) -> CGPoint {
		return CGPoint.init(x: (UIApplication.shared.keyWindow?.bounds.size.width)! / 2, y: (UIApplication.shared.keyWindow?.bounds.size.height)! + (fromView.bounds.size.height / 2))
	}
	
	private func returnDestinationPoint(fromView:UIView, toView:UIView) -> CGPoint {
		let destinationPoint = (UIApplication.shared.keyWindow?.center)!

		return CGPoint(x: destinationPoint.x, y: fromView.bounds.size.height - toView.bounds.size.height + (toView.bounds.size.height / 2))
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return self.duration
	}

	func animatePresent(using transitionContext:UIViewControllerContextTransitioning) {
		let containerView	= transitionContext.containerView
		
		let fromVC:UIViewController		= transitionContext.viewController(forKey: .from)!
		let toView:UIView				= transitionContext.view(forKey: .to)!
		
		// Presenting...
		
		containerView.addSubview(toView)
		
		toView.center				= self.returnOriginPoint(fromView: fromVC.view, toView: toView)
		
		UIView.animateKeyframes(withDuration: self.duration, delay: 0, options: .calculationModeLinear, animations: {
			UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 3/3, animations: {
				toView.center			= self.returnDestinationPoint(fromView:fromVC.view, toView: toView)
				toView.alpha			= 1.0
			})
		}) { (finished) in
			transitionContext.completeTransition(true)
		}
	}

	func animateDismiss(using transitionContext:UIViewControllerContextTransitioning) {
		let toView:UIView				= transitionContext.view(forKey: .from)!
		let fromVC:UIViewController		= transitionContext.viewController(forKey: .to)!

		UIView.animateKeyframes(withDuration: self.duration, delay: 0, options: .calculationModeLinear, animations: {
			UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 3/3, animations: {
				toView.center		= self.returnOriginPoint(fromView: toView, toView: fromVC.view)
			})
		}) { (finished) in
			if transitionContext.transitionWasCancelled == false {
				toView.removeFromSuperview()
				transitionContext.completeTransition(true)
			} else {
				transitionContext.completeTransition(false)
			}
		}
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		if self.isPresentation	== true {
			self.animatePresent(using: transitionContext)
		} else {
			self.animateDismiss(using: transitionContext)
		}
	}
}
