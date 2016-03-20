//
//  UIBarButtonItem+FR.h
//  FRDemo
//
//  Created by 1860 on 16/1/5.
//  Copyright © 2016年 QuFanrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FR)
+(UIBarButtonItem *)ItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
+(UIBarButtonItem *)ItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
