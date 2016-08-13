//
//  SlideRightTransitionAnimator.swift
//  NavTransition
//
//  Created by Michael Henry on 1/5/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class SlideRightTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 0.5
    var isPresenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // get reference to our fromView, toView, and container view
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // set up the transform we will use in the animation
        
        guard let container = transitionContext.containerView() else {
            return
        }
        
        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
        
        // make the toView off screen
        
        if isPresenting {
            toView.transform = offScreenLeft
        }
        
        // add both views to the contanier view
        
        if isPresenting {
            container.addSubview(fromView)
            container.addSubview(toView)
        } else {
            container.addSubview(toView)
            container.addSubview(fromView)
        }
        
        // perform the transition
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting {
                toView.transform = CGAffineTransformIdentity
            } else {
                fromView.transform = offScreenLeft
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
