//
//  FRTabBarViewController.h
//
//  Created by Mac on 15/9/21.
//  Copyright © 2015年 FR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRDrawerController.h"

@interface FRTabBarViewController : UITabBarController<FRDrawerControllerChild, FRDrawerControllerPresenting>

@property(nonatomic, weak) FRDrawerController *drawer;


@end
