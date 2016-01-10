//
//  DimmingInteractiveNavigationTransition.swift
//  DimmingInteractiveNavigationTransition
//
//  Created by Arvindh Sukumar on 09/01/16.
//  Copyright © 2016 Arvindh Sukumar. All rights reserved.
//

import UIKit

class DimmingPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey), let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        let container = transitionContext.containerView()
        var fromVCBounds = fromVC.view.frame
        toVC.view.frame = CGRectMake(fromVCBounds.size.width, fromVCBounds.origin.y, fromVCBounds.size.width, fromVCBounds.size.height)
        
        let dimView = UIView(frame: fromVCBounds)
        dimView.backgroundColor = UIColor(white: 0.5, alpha: 0.4)
        dimView.alpha = 0
        
        container?.addSubview(dimView)

        container?.addSubview(toVC.view)
        
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: (UIViewAnimationOptions.CurveEaseOut), animations: { () -> Void in
            
            var newToVCBounds = toVC.view.frame
            newToVCBounds.origin.x = 0
            toVC.view.frame = newToVCBounds
            
            let ratio: CGFloat = 0.4
            fromVCBounds.origin.x = -(fromVCBounds.size.width * ratio)
            fromVC.view.frame = fromVCBounds
            
            dimView.frame = fromVCBounds
            dimView.alpha = 1
            
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
