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
    [self addChildViewController:mainNav title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    ViewController *health = [[ViewController alloc]init];
    FRNavigationController *healthNav = [[FRNavigationController alloc] initWithRootViewController:health];
    healthNav.delegate = self;
    [self addChildViewController:healthNav title:@"健康" image:@"tabbar_health" selectedImage:@"tabbar_health_selected"];
    
    ViewController *life = [[ViewController alloc]init];
    FRNavigationController *lifeNav = [[FRNavigationController alloc] initWithRootViewController:life];
    lifeNav.delegate = self;
    [self addChildViewController:lifeNav title:@"生活" image:@"tabbar_life" selectedImage:@"tabbar_life_selected"];
    
    ViewController *profile = [[ViewController alloc]init];
    FRNavigationController *profileNav = [[FRNavigationController alloc] initWithRootViewController:profile];
    profileNav.delegate = self;
    [self addChildViewController:profileNav title:@"我的" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
}





- (UIColor*)mostColorWithImage:(UIImage *)image{
    
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    
    CGSize thumbSize=CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,bitmapInfo);
    
    
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    
    CGContextDrawImage(context, drawRect, image.CGImage);
    
    CGColorSpaceRelease(colorSpace);
    
    
    //第二步 取每个点的像素值
    
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4*(x*y);
            
            int red = data[offset];
            
            int green = data[offset+1];
            
            int blue = data[offset+2];
            
            int alpha =  data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            //剔除透明区域
            if (alpha != 0) {
                [cls addObject:clr];
            }
        }
        
    }
    
    CGContextRelease(context);
    
    //第三步 找到出现次数最多的那个颜色
    
    NSEnumerator *enumerator = [cls objectEnumerator];
    
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    
    NSUInteger MaxCount=0;
    
    while ( (curColor = [enumerator nextObject]) != nil ) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        
        MaxColor=curColor;
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
    
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
