//
//  MTAddWorkViewController.m
//  WorkAssistant
//
//  Created by mt y on 2018/7/10.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTAddWorkViewController.h"
#import <SVProgressHUD.h>
#import "MTMoneyMode.h"
@interface MTAddWorkViewController ()

@end

@implementation MTAddWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitleLable.text = self.titleStr;
}

#pragma mark -touch
- (IBAction)finishBtn:(UIButton *)sender {
    if (self.remarkLable.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your remark"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    if (self.revenueLable.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your revenue"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }

    MTMoneyMode *mode = [MTMoneyMode new];
    mode.remarkMode = self.remarkLable.text;
    mode.revenueMode = self.revenueLable.text;
    mode.dateMode = [MTGetDate getCurrentDate];
    NSMutableArray *myArr = [MTDataTool getAllCardMode:self.titleStr];
    if (myArr) {
        [myArr addObject:mode];
    }else{
        myArr = [NSMutableArray new];
        [myArr addObject:mode];
    }
    [MTDataTool putAllCardMode:myArr type:self.titleStr];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
