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
    FRNavigationController *mainNav = [[FRNavigationController alloc] initWithRootViewController:mainVC];
    mainNav.delegate = self;
    [self addNavigationController:mainNav title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    ViewController *health = [[ViewController alloc]init];
    FRNavigationController *healthNav = [[FRNavigationController alloc] initWithRootViewController:health];
    healthNav.delegate = self;
    [self addNavigationController:healthNav title:@"健康" image:@"tabbar_health" selectedImage:@"tabbar_health_selected"];
    
    ViewController *life = [[ViewController alloc]init];
    FRNavigationController *lifeNav = [[FRNavigationController alloc] initWithRootViewController:life];
    lifeNav.delegate = self;
    [self addNavigationController:lifeNav title:@"生活" image:@"tabbar_life" selectedImage:@"tabbar_life_selected"];
    
    ViewController *profile = [[ViewController alloc]init];
    FRNavigationController *profileNav = [[FRNavigationController alloc] initWithRootViewController:profile];
    profileNav.delegate = self;
    [self addNavigationController:profileNav title:@"我的" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
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
