//
//  RootViewController.m
//  ZCSTransitionDemo
//
//  Created by Cusen on 16/4/6.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "RootViewController.h"
#import "UIColor+Random.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *vcArray = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        UIViewController *tabVc = [[UIViewController alloc] init];
        tabVc.view.backgroundColor = [UIColor randomColor];
        UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:tabVc];
        NSString *title = [NSString stringWithFormat:@"Tab%d",i];
        navigationVC.tabBarItem.title = title;
        navigationVC.tabBarItem.image = [UIImage imageNamed:@"home_tab_icon_1"];
        tabVc.navigationItem.title = title;
        [vcArray addObject:navigationVC];
    }
    self.viewControllers = vcArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
