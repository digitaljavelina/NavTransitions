//
//  SlideDownTransitionAnimator.swift
//  NavTransition
//
//  Created by Michael Henry on 12/28/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit

class SlideDownTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 0.5
    var isPresenting = false   // keeps track of whether we are presenting or dismissing a view controller
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // get reference to our fromView, toView, and the container view
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // set up the transform we will use in the animation
        
        guard let container = transitionContext.containerView() else {
            return
        }
        
        let offScreenUp = CGAffineTransformMakeTranslation(0, -container.frame.height)
        let offScreenDown = CGAffineTransformMakeTranslation(0, container.frame.height)
        
        // move the toView off screen
        
        if isPresenting {
            toView.transform = offScreenUp
        }
        
        // add both views to the container view
        
        container.addSubview(fromView)
        container.addSubview(toView)
        
        // perform the animation
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: [], animations: {
            
            if self.isPresenting {
                fromView.transform = offScreenDown
                fromView.alpha  = 0.5
                toView.transform = CGAffineTransformIdentity
            } else {
                fromView.transform = offScreenUp
                toView.alpha = 1.0
                toView.transform = CGAffineTransformIdentity
            }
            
            }, completion: { finshed in
                transitionContext.completeTransition(true)
        })
    }

}
