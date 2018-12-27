//
//  MTStatisticsTableViewCell.h
//  WorkAssistant
//
//  Created by mt y on 2018/7/10.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnBlock)(int);

@interface MTStatisticsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *weekBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UIView *myBackView;
@property (weak, nonatomic) IBOutlet UILabel *titalLable;
@property (nonatomic, copy)btnBlock btnBlock;
@end
