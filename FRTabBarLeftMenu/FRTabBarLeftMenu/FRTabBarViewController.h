//
//  FRTabBarViewController.h
//
//  Created by Mac on 15/9/21.
//  Copyright © 2015年 FR. All rights reserved.
//

#import "FRTabBarController.h"
#import "FRDrawerController.h"

@interface FRTabBarViewController : FRTabBarController<FRDrawerControllerChild, FRDrawerControllerPresenting>

@property(nonatomic, weak) FRDrawerController *drawer;


@end
