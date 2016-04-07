//
//  ZCSNavigationControllerTransitionDelegate.m
//  ZCSTransitionDemo
//
//  Created by zcs on 16/4/7.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "ZCSNavigationControllerTransitionDelegate.h"
#import "ZCSTransitionAnimationController.h"

@implementation ZCSNavigationControllerTransitionDelegate

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactive ? self.interactionController : nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush)
    {
        return [[ZCSTransitionAnimationController alloc] initWithTransitionType:TransitionTypeNavigation
                                                        WithTransitionOperation:NavigationOperationPush];
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        return [[ZCSTransitionAnimationController alloc] initWithTransitionType:TransitionTypeNavigation
                                                        WithTransitionOperation:NavigationOperationPop];
    }
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
