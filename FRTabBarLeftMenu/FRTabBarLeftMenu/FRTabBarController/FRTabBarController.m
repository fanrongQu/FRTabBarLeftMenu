//
//  FRTabBarController.m
//  爱鲜蜂
//
//  Created by 1860 on 16/4/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//


#import "FRTabBarController.h"
#import "FRTabBar.h"

@interface FRTabBarController ()<FRTabBarDelegate>

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) FRTabBar *customTabBar;

@end

@implementation FRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化tabbar
    [self setupTabbar];
}


/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    FRTabBar *customTabBar = [[FRTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

#pragma mark - FRTabBar Delegate
- (void)tabBar:(FRTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}



- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UIViewController *viewController = childController.childViewControllers[0];
    //标题
    viewController.title = title;
    
    //图片
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:childController];
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarItemWithItem:viewController.tabBarItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

@end
