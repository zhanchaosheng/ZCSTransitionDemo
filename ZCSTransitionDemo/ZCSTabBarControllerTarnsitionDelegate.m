//
//  ZCSTabBarControllerTarnsitionDelegate.m
//  ZCSTransitionDemo
//
//  Created by Cusen on 16/4/6.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "ZCSTabBarControllerTarnsitionDelegate.h"

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
    return nil;
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
