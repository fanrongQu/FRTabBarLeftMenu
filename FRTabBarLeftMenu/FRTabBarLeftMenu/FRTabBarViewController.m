//
//  FRTabBarViewController.m
//
//  Created by Mac on 15/9/21.
//  Copyright © 2015年 FR. All rights reserved.
//

#import "FRTabBarViewController.h"
#import "FRNavigationController.h"
#import "ViewController.h"


@interface FRTabBarViewController ()<UINavigationControllerDelegate>

@property(nonatomic, strong) UIButton *openDrawerButton;


@end

@implementation FRTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.openDrawerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openDrawerButton.frame = CGRectMake(10.0f, 20.0f, 44.0f, 44.0f);
    [self.openDrawerButton setTitle:@"菜单" forState:UIControlStateNormal];
    [self.openDrawerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.openDrawerButton addTarget:self action:@selector(openDrawer:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.openDrawerButton];
    
    
    ViewController *mainVC = [[ViewController alloc]init];
    [self addChildVc:mainVC title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    ViewController *health = [[ViewController alloc]init];
    [self addChildVc:health title:@"健康" image:@"tabbar_health" selectedImage:@"tabbar_health_selected"];
    
    ViewController *life = [[ViewController alloc]init];
    [self addChildVc:life title:@"生活" image:@"tabbar_life" selectedImage:@"tabbar_life_selected"];
    
    ViewController *profile = [[ViewController alloc]init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
 
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:241/255.0 green:0 blue:0 alpha:1];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    FRNavigationController *nav = [[FRNavigationController alloc] initWithRootViewController:childVc];
    nav.delegate = self;
    // 添加为子控制器
    [self addChildViewController:nav];
}

#pragma mark -- UINavigationControllerDelegate 在这里实现对菜单按钮的隐藏与显示

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    int child_count = (int)navigationController.childViewControllers.count;
    if (child_count > 1) {
        self.openDrawerButton.hidden = YES;
        _openDrawerButton.userInteractionEnabled = NO;
    }else{
        self.openDrawerButton.hidden = NO;
        _openDrawerButton.userInteractionEnabled = YES;
    }
}

#pragma mark - FRDrawerControllerPresenting

- (void)drawerControllerWillOpen:(FRDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(FRDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

#pragma mark - Open drawer button

- (void)openDrawer:(id)sender
{
    [self.drawer open];
}


@end
