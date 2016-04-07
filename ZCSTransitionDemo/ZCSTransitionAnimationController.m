//
//  ZCSTransitionAnimationController.m
//  ZCSTransitionDemo
//
//  Created by zcs on 16/4/7.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "ZCSTransitionAnimationController.h"

@interface ZCSTransitionAnimationController()

@property (nonatomic, assign) TransitionType transitionType;
@property (nonatomic, assign) TransitionOperation transitionOperation;

@end

@implementation ZCSTransitionAnimationController

- (instancetype)initWithTransitionType:(TransitionType)type
               WithTransitionOperation:(TransitionOperation)operation {
    self = [super init];
    if (self) {
        self.transitionType = type;
        self.transitionOperation = operation;
    }
    return self;
}

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    if (containerView == nil || toVC == nil || fromVC == nil) {
        return;
    }
    
    [containerView addSubview:toVC.view];
    
    CGFloat translation = containerView.frame.size.width;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    
    if (self.transitionType == TransitionTypeNavigation) {
        toVC.view.alpha = 0;
    }
    else if (self.transitionType == TransitionTypeTab) {
        
        if (self.transitionOperation == TabOperationDirectionRigth) {
            translation = -translation;
        }
        fromViewTransform = CGAffineTransformMakeTranslation(translation, 0);
        toViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
        
        toVC.view.transform = toViewTransform;
    }
    else if (self.transitionType == TransitionTypeModal) {
        
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (self.transitionType == TransitionTypeNavigation) {
            toVC.view.alpha = 1;
            fromVC.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
        else if (self.transitionType == TransitionTypeTab) {
            fromVC.view.transform = fromViewTransform;
            toVC.view.transform = CGAffineTransformIdentity;
        }
        else if (self.transitionType == TransitionTypeModal) {
            
        }
    } completion:^(BOOL finished) {
        fromVC.view.transform = CGAffineTransformIdentity;
        toVC.view.transform = CGAffineTransformIdentity;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
