//
//  PopTransitionAnimator.swift
//  NavTransition
//
//  Created by Michael Henry on 1/5/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class PopTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 0.5
    var isPresenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // get reference to the fromView, toView, and collection view
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // set up the transition we will use in the animation
        
        guard let container = transitionContext.containerView() else {
            return
        }
        
        let minimize = CGAffineTransformMakeScale(0, 0)
        let offScreenDown = CGAffineTransformMakeTranslation(0, container.frame.height)
        let shiftDown = CGAffineTransformMakeTranslation(0, 15)
        let scaleDown = CGAffineTransformMakeScale(0.95, 0.95)
        
        // change the initial size of the toView
        
        toView.transform = minimize
        
        // add both views to the container view
        
        if isPresenting {
            container.addSubview(fromView)
            container.addSubview(toView)
        } else {
            container.addSubview(toView)
            container.addSubview(fromView)
        }
        
        // perform the animation
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {            if self.isPresenting {
            fromView.transform = scaleDown
            fromView.alpha = 0.5
            toView.transform = CGAffineTransformIdentity
        } else {
            fromView.transform = offScreenDown
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
