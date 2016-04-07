//
//  ZCSNavigationControllerTransitionDelegate.h
//  ZCSTransitionDemo
//
//  Created by zcs on 16/4/7.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCSNavigationControllerTransitionDelegate : NSObject <UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL interactive;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end
