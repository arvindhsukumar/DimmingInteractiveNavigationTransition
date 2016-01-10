//
//  NavigationController.swift
//  DimmingInteractiveNavigationTransition
//
//  Created by Arvindh Sukumar on 09/01/16.
//  Copyright © 2016 Arvindh Sukumar. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {

    var animationController: DimmingPushTransition = DimmingPushTransition()
    var hideAnimationController: DimmingPopTransition = DimmingPopTransition()
    var interactionController: DimmingInteractiveTransition!
    var screenEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.screenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "screenEdgePan:")
        screenEdgePanGestureRecognizer.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(screenEdgePanGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func screenEdgePan(gesture:UIScreenEdgePanGestureRecognizer){
        let translation = gesture.translationInView(gesture.view)
        let velocity = gesture.velocityInView(gesture.view)
        let percent = translation.x/gesture.view!.frame.size.width

        switch gesture.state {
        case .Began:
            self.interactionController = DimmingInteractiveTransition()
            self.popViewControllerAnimated(true)

        case .Changed:
            interactionController.updateInteractiveTransition(percent)
            
        case .Ended:
            if percent < 0.5 || velocity.x < 0 {
                interactionController.cancelInteractiveTransition()
            }
            else{
                interactionController.finishInteractiveTransition()
                
            }
            self.interactionController = nil
        default:
            break
        }
    }

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        if (operation == UINavigationControllerOperation.Push)  {
            return self.animationController
        }
        else if (operation == UINavigationControllerOperation.Pop) {
            return self.hideAnimationController
        }
        return nil
        
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactionController
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
