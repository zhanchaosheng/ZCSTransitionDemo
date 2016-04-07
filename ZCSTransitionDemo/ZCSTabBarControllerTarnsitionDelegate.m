//
//  ZCSTabBarControllerTarnsitionDelegate.m
//  ZCSTransitionDemo
//
//  Created by Cusen on 16/4/6.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "ZCSTabBarControllerTarnsitionDelegate.h"
#import "ZCSTransitionAnimationController.h"

@implementation ZCSTabBarControllerTarnsitionDelegate

- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactive ? self.interactionController : nil;
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    NSUInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    TransitionOperation operation = toIndex < fromIndex ? TabOperationDirectionLeft : TabOperationDirectionRigth;
    
    return [[ZCSTransitionAnimationController alloc] initWithTransitionType:TransitionTypeTab
                                                    WithTransitionOperation:operation];
}

- (void)setInteractive:(BOOL)interactive {
    _interactive = interactive;
    if (interactive) {
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    else {
        self.interactionController = nil;
    }
}
@end
