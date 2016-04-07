//
//  RootViewController.m
//  ZCSTransitionDemo
//
//  Created by Cusen on 16/4/6.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "RootViewController.h"
#import "UIColor+Random.h"
#import "ZCSTabBarControllerTarnsitionDelegate.h"
#import "FirstNavigationController.h"

@interface RootViewController ()
@property (nonatomic, strong) ZCSTabBarControllerTarnsitionDelegate *transitionDelegate;
@property (nonatomic, assign) NSUInteger subViewControllerCount;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *vcArray = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        UIViewController *tabVc = [[UIViewController alloc] init];
        tabVc.view.backgroundColor = [UIColor randomColor];
        UINavigationController *navigationVC;
        if (i == 0) {
            navigationVC = [[FirstNavigationController alloc] initWithRootViewController:tabVc];
        }
        else {
            navigationVC = [[UINavigationController alloc] initWithRootViewController:tabVc];
        }
        NSString *title = [NSString stringWithFormat:@"Tab%d",i];
        navigationVC.tabBarItem.title = title;
        navigationVC.tabBarItem.image = [UIImage imageNamed:@"home_tab_icon_1"];
        tabVc.navigationItem.title = title;
        [vcArray addObject:navigationVC];
    }
    self.viewControllers = vcArray;
    
    self.transitionDelegate = [[ZCSTabBarControllerTarnsitionDelegate alloc] init];
    self.delegate = self.transitionDelegate;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
    [panGesture addTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)subViewControllerCount {
    if (self.viewControllers) {
        return self.viewControllers.count;
    }
    else {
        return 0;
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGFloat translationX = [gesture translationInView:self.view].x;
    translationX = fabs(translationX);
    CGFloat progress = translationX / self.view.frame.size.width;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.transitionDelegate.interactive = YES;
        CGFloat velocityX = [gesture velocityInView:self.view].x;
        if (velocityX < 0) {
            if (self.selectedIndex < self.subViewControllerCount - 1) {
                self.selectedIndex += 1;
            }
        }
        else {
            if (self.selectedIndex > 0) {
                self.selectedIndex -= 1;
            }
        }
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.transitionDelegate.interactionController updateInteractiveTransition:progress];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded ||
             gesture.state == UIGestureRecognizerStateCancelled) {
        /*这里有个小问题，转场结束或是取消时有很大几率出现动画不正常的问题。在8.1以上版本的模拟器中都有发现，7.x 由于缺乏条件尚未测试，
         但在我的 iOS 9.2 的真机设备上没有发现，而且似乎只在 UITabBarController 的交互转场中发现了这个问题。在 NavigationController 暂且没发现这个问题，
         Modal 转场尚未测试，因为我在 Demo 里没给它添加交互控制功能。
         
         测试不完整，具体原因也未知，解决手段是修改交互控制器的 completionSpeed 为1以下的数值，这个属性用来控制动画速度，猜测是内部实现在边界判断上有问题。
         这里其修改为0.99，既解决了 Bug 同时尽可能贴近原来的动画设定。
         */
        if (progress > 0.3) {
            self.transitionDelegate.interactionController.completionSpeed = 0.99;
            [self.transitionDelegate.interactionController finishInteractiveTransition];
        }
        else {
            //转场取消后，UITabBarController 自动恢复了 selectedIndex 的值，不需要我们手动恢复。
            self.transitionDelegate.interactionController.completionSpeed = 0.99;
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
