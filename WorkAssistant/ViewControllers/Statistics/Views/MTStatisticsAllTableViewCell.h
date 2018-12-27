//
//  MTStatisticsAllTableViewCell.h
//  WorkAssistant
//
//  Created by mt y on 2018/7/10.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTStatisticsAllTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *biliLable;
@property (weak, nonatomic) IBOutlet UIProgressView *proGress;

@end
