//
//  FRTabBarController.h
//  爱鲜蜂
//
//  Created by 1860 on 16/4/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRTabBarController : UITabBarController

/**
 *  为tabBarController添加子控制器
 *
 *  @param childController 子控制器
 *  @param title           子控制器标题
 *  @param image           子控制器tabBarItem图片
 *  @param selectedImage   子控制器tabBarItem选中图片
 */
- (void)addChildViewController:(UINavigationController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;

@end
