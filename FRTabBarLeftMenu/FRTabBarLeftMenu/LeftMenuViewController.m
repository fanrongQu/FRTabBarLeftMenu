//
//  LeftMenuViewController.m
//  tabbarMenu
//
//  Created by 1860 on 16/1/7.
//  Copyright © 2016年 QuFanrong. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "ViewController.h"


@interface LeftMenuViewController ()

@property(nonatomic, strong) NSArray *colors;

@end

@implementation LeftMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *colors = @[@"返回首页",@"1",@"2",@"3"];
    _colors = colors;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _colors.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = _colors[indexPath.row];
    
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        // Close the drawer without no further actions on the center view controller
        [self.drawer close];
    }
    else {
        
        [self.drawer close];
        UITabBarController *tabbarController = (UITabBarController *)self.drawer.centerViewController;
        UINavigationController *navigationController = tabbarController.selectedViewController;
        
        UIViewController *VC = [[UIViewController alloc]init];
        VC.title = @"二级页面";
        VC.view.backgroundColor = [UIColor yellowColor];
        
        [navigationController pushViewController:VC animated:NO];        
    }
}

#pragma mark - FRDrawerControllerPresenting

- (void)drawerControllerWillOpen:(FRDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidOpen:(FRDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

- (void)drawerControllerWillClose:(FRDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(FRDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}


@end
