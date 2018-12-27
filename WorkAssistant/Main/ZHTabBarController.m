//
//  WQTabBarController.m
//  魔颜
//
//  Created by abc on 15/9/23.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "ZHTabBarController.h"
#import "MTHomeeViewController.h"
#import "MTStatisticsViewController.h"
#import "MTDetailsViewController.h"
@interface ZHTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic) BOOL needPushMess;

@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加所有的子控制器
    [self setupChildVcs];
    
    if (self.needPushMess) {
        
        [self pushMessageVC];
    }
    
    //设置item属性
    [self setItems];
    
    self.delegate = self;

}



- (void)needPushMessage {
    
    self.needPushMess = YES;
}



/**
 *  添加所有的子控制器
 */
- (void)setupChildVcs {
    
    [self addChildVC:[[MTHomeeViewController alloc] init] title:@"Home" imageName:@"1" selIamgeName:@"1XZ"];
    
    [self addChildVC:[[MTStatisticsViewController alloc] init] title:@"Statistics" imageName:@"2" selIamgeName:@"2xz"];
    
    [self addChildVC:[[MTDetailsViewController alloc] init] title:@"Details" imageName:@"3" selIamgeName:@"3xz"];
    
}

/**
 *  设置item文字属性
 */
- (void)setItems{
    
    //设置文字属性
    NSMutableDictionary *attrsNomal = [NSMutableDictionary dictionary];
    //文字颜色
    attrsNomal[NSForegroundColorAttributeName] = UIColorWithRGB(0xbbbfcb);
    //文字大小
    attrsNomal[NSFontAttributeName] = ZHFontSize(10);
    
    NSMutableDictionary *attrsSelected = [NSMutableDictionary dictionary];
    //选中文字颜色
    attrsSelected[NSForegroundColorAttributeName] = UIColorWithRGB(0xee3747);
    
    //统一整体设置
    UITabBarItem *item = [UITabBarItem appearance]; //拿到底部的tabBarItem
    [item setTitleTextAttributes:attrsNomal forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrsSelected forState:UIControlStateSelected];
}

/**
 *  添加一个子控制器
 *
 *  @param VC            控制器
 *  @param title         标题
 *  @param imageName     图标
 *  @param selImageName  选中的图标
 */
-(void)addChildVC:(UIViewController *)VC title:(NSString *)title imageName:(NSString *)imageName selIamgeName:(NSString *)selImageName{
    
    VC.tabBarItem.title = title;
    UIImage *selectedImage1=[UIImage imageNamed:imageName];
    selectedImage1 = [selectedImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [VC.tabBarItem setImage:selectedImage1];
    UIImage *selectedImage=[UIImage imageNamed:selImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [VC.tabBarItem setSelectedImage:selectedImage];

    [self addChildViewController:VC];
}



@end

