//
//  RotateTransitionAnimator.swift
//  NavTransition
//
//  Created by Michael Henry on 1/5/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class RotateTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    let duration = 1.0
    var isPresenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // get reference to toView, fromView, container view
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // set up transform for the animation
        
        guard let container = transitionContext.containerView() else {
            return
        }
        
        // set up transform for rotation
        // the angle is in radians - to convert from degrees to radians, use this formula: radians = angle * pi / 180
        
        let rotateOut = CGAffineTransformMakeRotation(-90 * CGFloat(M_PI) / 180)
        
        // change anchor point and transition
        
        toView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        fromView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        toView.layer.position = CGPoint(x: 0, y: 0)
        fromView.layer.position = CGPoint(x: 0, y: 0)
        
        // change the initial position of the toView
        
        toView.transform = rotateOut
        
        // add both views to the container view
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // perform the animation
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting {
                fromView.transform = rotateOut
                fromView.alpha = 0.0
                toView.transform = CGAffineTransformIdentity
                toView.alpha = 1.0
            } else {
                fromView.alpha = 0.0
                fromView.transform = rotateOut
                toView.alpha = 1.0
                toView.transform = CGAffineTransformIdentity
            }
            }, completion: { finished in
                transitionContext.completeTransition(true)
        })
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}
