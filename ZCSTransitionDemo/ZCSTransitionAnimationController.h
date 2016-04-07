//
//  ZCSTransitionAnimationController.h
//  ZCSTransitionDemo
//
//  Created by zcs on 16/4/7.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TransitionType) {
    TransitionTypeNavigation,
    TransitionTypeTab,
    TransitionTypeModal,
};

typedef NS_ENUM(NSUInteger, TransitionOperation) {
    NavigationOperationPush,
    NavigationOperationPop,
    TabOperationDirectionLeft,
    TabOperationDirectionRigth,
    ModalOperationPresentation,
    ModalOperationDismissal,
};

@interface ZCSTransitionAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionType:(TransitionType)type
               WithTransitionOperation:(TransitionOperation)operation;

@end
