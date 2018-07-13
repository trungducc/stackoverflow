import UIKit

protocol PanelAnimationControllerDelegate {
  func shouldHandlePanelInteractionGesture() -> Bool
}

class PanelInteractionController: UIPercentDrivenInteractiveTransition, UIGestureRecognizerDelegate {
	var interactionInProgress							= false
	private var shouldCompleteTransition				= false

  private var startTransitionY: CGFloat = 0
	
	var panGestureRecognizer:UIPanGestureRecognizer?
	
	private weak var viewController: (UIViewController & PanelAnimationControllerDelegate)?
	
	func wireToViewController(viewController: Any) {
		self.viewController      = (viewController as? UIViewController & PanelAnimationControllerDelegate)!

		self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
		self.panGestureRecognizer?.delegate	= self
		
		self.viewController?.view.addGestureRecognizer(self.panGestureRecognizer!)
	}

	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		// Returning true here is required in order to get it so that a pan down within a scroll view (UITableView, UICollectionView, UIScrollView,
		// WKWebView, etc) dismisses the presented slide panel. However, the behavior is not usable as panning down should only dismiss the slide
		// panel if the user reaches the top of the scroll view. The scrolling should _not_ happen simultaneously, in any event.

		// I believe that the secret to handling this is within this method, but it's not clear to me how to stop the scroll view from scrolling when
		// it reachest contentOffset.y <= 0 without causing problems (ie. disabling the scroll view and being unable to reenable it).
		//
		// The question, I think, is this: How do you cleanly prevent a contained scroll view from being scrollable when the user scrolls to the top
		// without breaking it in some way?

		return true
	}

	@objc func handlePanGestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer) {
		switch gestureRecognizer.state {
		case .began:
      break
		case .changed:
      let translation    = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
      let velocity    = gestureRecognizer.velocity(in: gestureRecognizer.view!.superview)
      let state      = gestureRecognizer.state

      if !(viewController?.shouldHandlePanelInteractionGesture())! && percentComplete == 0 {
        return;
      }

      var rawProgress    = CGFloat(0.0)

      rawProgress    = ((translation.y - startTransitionY) / gestureRecognizer.view!.bounds.size.height)

      let progress    = CGFloat(fminf(fmaxf(Float(rawProgress), 0.0), 1.0))

      if abs(velocity.x) > abs(velocity.y) && state == .began {
        // If the user attempts a pan and it looks like it's going to be mostly horizontal, bail - we don't want it... - JAC
        return
      }

      if !self.interactionInProgress {
        // Start to pan |viewController| down
        self.interactionInProgress = true
        startTransitionY = translation.y;
        self.viewController?.dismiss(animated: true, completion: nil)
      } else {
        // If the user gets to a certain point within the dismissal and releases the panel, allow the dismissal to complete... - JAC
        self.shouldCompleteTransition = progress > 0.2

        update(progress)
      }
		case .cancelled:
			self.interactionInProgress = false
      startTransitionY = 0

			cancel()
		case .ended:
			self.interactionInProgress = false
      startTransitionY = 0
			
			if self.shouldCompleteTransition == false {
				cancel()
			} else {
				finish()
			}
		case .failed:
			self.interactionInProgress = false
      startTransitionY = 0
			
			cancel()
		default:
			break;
		}
	}
}
