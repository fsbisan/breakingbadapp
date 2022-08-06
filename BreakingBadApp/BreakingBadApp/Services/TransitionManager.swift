//
//  TransitionManager.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 05.08.2022.
//

import Foundation
import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var presenting = true
        /// Непосредственно определяет анимацию перехода от одного контроллера к другому
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // код анимации
        let π = CGFloat(Float.pi)
        
        let offScreenRotateIn = CGAffineTransform(rotationAngle: -π/2)
        let offScreenRotateOut = CGAffineTransform(rotationAngle: π/2)
        
        let container = transitionContext.containerView
        container.backgroundColor = .white
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
     
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        
        toView.transform = presenting ? offScreenRight : offScreenRotateOut
        
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.49, initialSpringVelocity: 0.81, options: [], animations: { [unowned self] () -> Void in
            fromView.transform = self.presenting ? offScreenLeft : offScreenRotateIn
            toView.transform = CGAffineTransform.identity
        }) { (finished) -> Void in
            transitionContext.completeTransition(true)
        }
    }
    
    /// Количество секунд которое занимает анимация
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.8
    }
    
    /// Анимация для презентации
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    /// Анимация для сокрытия
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self    }
    
}
