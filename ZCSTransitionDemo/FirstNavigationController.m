//
//  FirstNavigationController.m
//  ZCSTransitionDemo
//
//  Created by zcs on 16/4/7.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "FirstNavigationController.h"
#import "ZCSNavigationControllerTransitionDelegate.h"
#import "UIColor+Random.h"

@interface FirstNavigationController ()

@property (nonatomic, strong) ZCSNavigationControllerTransitionDelegate *transitionDelegate;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation FirstNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.transitionDelegate = [[ZCSNavigationControllerTransitionDelegate alloc] init];
    self.delegate = self.transitionDelegate;
}

- (void)viewWillAppear:(BOOL)animated {
    UIViewController *firstVC = [self.viewControllers firstObject];
    if (firstVC) {
        if (firstVC.navigationItem.rightBarButtonItem == nil) {
            firstVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                      target:self
                                                                                                      action:@selector(HandleFirstNavigationVCRighBarBtn:)];
         }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)HandleFirstNavigationVCRighBarBtn:(UIBarButtonItem *)sender {
    UIViewController *pushVC = [[UIViewController alloc] init];
    pushVC.view.backgroundColor = [UIColor blueColor];
    
    if (self.panGesture == nil) {
        self.panGesture = [[UIPanGestureRecognizer alloc] init];
        [self.panGesture addTarget:self action:@selector(handlePan:)];
        [self.view addGestureRecognizer:self.panGesture];
    }
    
    [self pushViewController:pushVC animated:YES];
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    UIView *view = self.view;
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [gesture locationInView:view];
        CGFloat velocityX = [gesture velocityInView:self.view].x;
        if (location.x <  CGRectGetMidX(view.bounds) &&
            self.viewControllers.count > 1 &&
            velocityX > 0)
        { // left half
            self.transitionDelegate.interactive = YES;
            [self popViewControllerAnimated:YES];
        }
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [gesture translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.transitionDelegate.interactionController updateInteractiveTransition:d];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if ([gesture velocityInView:view].x > 0)
        {
            [self.transitionDelegate.interactionController finishInteractiveTransition];
        }
        else
        {
            [self.transitionDelegate.interactionController cancelInteractiveTransition];
        }
        self.transitionDelegate.interactive = NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
