//
//  DimmingPopTransition.swift
//  DimmingInteractiveNavigationTransition
//
//  Created by Arvindh Sukumar on 09/01/16.
//  Copyright © 2016 Arvindh Sukumar. All rights reserved.
//

import UIKit

class DimmingPopTransition: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey), let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        let container = transitionContext.containerView()
        
        
        var fromVCBounds = fromVC.view.frame
        let ratio: CGFloat = 0.4
        toVC.view.frame = CGRectMake(-fromVCBounds.size.width * ratio, fromVCBounds.origin.y, fromVCBounds.size.width, fromVCBounds.size.height)
        
        let dimView = UIView(frame: toVC.view.frame)
        dimView.backgroundColor = UIColor(white: 0.5, alpha: 0.4)
        dimView.alpha = 1
        
        container?.insertSubview(toVC.view, belowSubview: fromVC.view)
        container?.insertSubview(dimView, aboveSubview: toVC.view)

        let options = (transitionContext.isInteractive() ? UIViewAnimationOptions.CurveLinear : UIViewAnimationOptions.CurveEaseOut)
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: (options), animations: { () -> Void in
            
            var newToVCBounds = toVC.view.frame
            newToVCBounds.origin.x = 0
            toVC.view.frame = newToVCBounds
            
            fromVCBounds.origin.x = newToVCBounds.size.width
            fromVC.view.frame = fromVCBounds
            
            dimView.frame = toVC.view.frame
            dimView.alpha = 0
            
            }) { (finished:Bool) -> Void in
                
                dimView.removeFromSuperview()
                if transitionContext.transitionWasCancelled() {
                    transitionContext.completeTransition(false)
                }
                else {
                    transitionContext.completeTransition(finished)
                    fromVC.view.removeFromSuperview()
                }
                
        }
    }

}
