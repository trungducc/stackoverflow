import Foundation
import UIKit

class PanelPresentationController: UIPresentationController {
	private var dimmingView: UIView!
	private var shadowWrapperView: UIView!

	override var presentedView: UIView? {
		get {
			return self.shadowWrapperView
		}
	}

	override var frameOfPresentedViewInContainerView: CGRect {
		var frame: CGRect	= .zero
		
		frame.origin		= CGPoint(x: 0, y: 0)
		frame.size			= size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
		
		return frame
	}

	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

		self.setupDimmingView()
		self.setupShadowWrapperView()
	}

	private func setupShadowWrapperView() {
		self.shadowWrapperView												= UIView(frame: CGRect(x: 0, y: 0, width: 400.0, height: 400.0))
		self.shadowWrapperView.backgroundColor								= UIColor.clear
		self.shadowWrapperView.layer.shadowOpacity							= 0.4;
		self.shadowWrapperView.layer.shadowRadius							= 10.0;
		self.shadowWrapperView.layer.shadowOffset							= CGSize(width: 0, height: 6)
		self.shadowWrapperView.layer.rasterizationScale						= UIApplication.shared.keyWindow!.screen.scale
		self.shadowWrapperView.layer.shouldRasterize						= true
	}
	
	private func setupDimmingView() {
		self.dimmingView													= UIView(frame: CGRect(x: 0, y: 0, width: 400.0, height: 400.0))
		self.dimmingView.backgroundColor									= UIColor(white: 0.0, alpha: 0.5)
		self.dimmingView.alpha												= 0.0
		
		let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		
		self.dimmingView.addGestureRecognizer(recognizer)
	}
	
	@objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
		self.presentingViewController.dismiss(animated: true)
	}
	
	override func presentationTransitionWillBegin() {
		let frameOfPresentedViewInContainerView			= self.frameOfPresentedViewInContainerView
		
		guard let containerView = self.containerView else {
			return
		}
		
		self.dimmingView.autoresizingMask						= [.flexibleWidth, .flexibleHeight]
		self.presentedViewController.view.autoresizingMask		= [.flexibleWidth, .flexibleHeight]
		self.shadowWrapperView.autoresizingMask					= [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]

		self.dimmingView.frame									= containerView.bounds
		self.shadowWrapperView.frame							= frameOfPresentedViewInContainerView
		
		self.containerView!.insertSubview(self.dimmingView, at: 0)
		self.shadowWrapperView.addSubview(self.presentedViewController.view)
		self.containerView!.addSubview(self.shadowWrapperView)
		
		self.presentedViewController.view.frame					= frameOfPresentedViewInContainerView

		NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": self.dimmingView]))
		NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": self.dimmingView]))

		self.containerView!.setNeedsLayout()
		self.containerView!.layoutIfNeeded()

		guard let coordinator = presentedViewController.transitionCoordinator else {
			self.dimmingView.alpha				= 1.0
			return
		}
		
		coordinator.animate(alongsideTransition: { _ in
			self.dimmingView.alpha				= 1.0
		})
	}

	override func presentationTransitionDidEnd(_ completed: Bool) {
		
	}

	override func dismissalTransitionWillBegin() {
		guard let coordinator = presentedViewController.transitionCoordinator else {
			self.dimmingView.alpha				= 0.0
			return
		}
		
		coordinator.animate(alongsideTransition: { _ in
			self.dimmingView.alpha				= 0.0
		})
	}
	
	override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
	}
	
	override func containerViewWillLayoutSubviews() {
		super.containerViewWillLayoutSubviews()
	}

	override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
		var maxDisplayHeight:CGFloat		= 620.0
		if parentSize.height >= 768 && parentSize.width >= 768 {
			maxDisplayHeight = 668.0
		}
		
		if parentSize.height < CGFloat(maxDisplayHeight + 80.0) {
			maxDisplayHeight	= CGFloat(parentSize.height - 80.0)
		}
		
		var maxDisplayWidth:CGFloat			= 768.0
		if parentSize.width < CGFloat(maxDisplayWidth) {
			maxDisplayWidth	= CGFloat(parentSize.width)
		}

		return CGSize(width: maxDisplayWidth, height: maxDisplayHeight)
	}
}
