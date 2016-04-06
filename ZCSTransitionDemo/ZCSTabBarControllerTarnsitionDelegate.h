//
//  ZCSTabBarControllerTarnsitionDelegate.h
//  ZCSTransitionDemo
//
//  Created by Cusen on 16/4/6.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCSTabBarControllerTarnsitionDelegate : NSObject <UITabBarControllerDelegate>

@property (nonatomic, assign) BOOL interactive;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end
