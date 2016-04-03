# FRTabBarLeftMenu
带侧滑菜单的FRTabBarController  LeftMenu 
在第一视图都能够调出左侧菜单并且可以实现当前tabBar显示视图跳转到对应页面

    [self.drawer close];
     UITabBarController *tabbarController = (UITabBarController *)self.drawer.centerViewController;
    UINavigationController *navigationController = tabbarController.selectedViewController;
        
    UIViewController *VC = [[UIViewController alloc]init];
    VC.title = @"二级页面";
    VC.view.backgroundColor = [UIColor yellowColor];
        
    [navigationController pushViewController:VC animated:NO];        


FRTabBarController可以根据Item的图标颜色获取Item字体色，并且Item在点击后能够实现❤️心跳动画
使用只需一行代码就可以实现
1、创建继承于FRTabBarController的TabBarController控制器，self调用下面方法就可以设置控制器的标题、普通图片、选中图片：


/**
 *  为tabBarController添加子控制器
 *
 *  @param childController 子控制器
 *  @param title           子控制器标题
 *  @param image           子控制器tabBarItem图片
 *  @param selectedImage   子控制器tabBarItem选中图片
 */
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;


/**
 *  为tabBarController添加子控制器UINavigationController
 *
 *  @param navigationController 导航控制器
 *  @param title                navigationController的rootViewController的title
 *  @param image                navigationController的rootViewController的image
 *  @param selectedImage        navigationController的rootViewController的selectedImage
 */
- (void)addNavigationController:(UINavigationController *)navigationController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;

