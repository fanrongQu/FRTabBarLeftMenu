//
//  LeftMenuViewController.h
//  tabbarMenu
//
//  Created by 1860 on 16/1/7.
//  Copyright © 2016年 QuFanrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRDrawerController.h"

@interface LeftMenuViewController : UITableViewController<FRDrawerControllerChild, FRDrawerControllerPresenting>

@property(nonatomic, weak) FRDrawerController *drawer;

@end
