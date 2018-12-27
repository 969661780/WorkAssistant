//
//  MTAddWorkViewController.h
//  WorkAssistant
//
//  Created by mt y on 2018/7/10.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTAddWorkViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *myTitleLable;
@property (weak, nonatomic) IBOutlet UITextField *remarkLable;
@property (weak, nonatomic) IBOutlet UITextField *revenueLable;
@property (nonatomic, copy) NSString *titleStr;
@end
