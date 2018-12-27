//
//  MTStatisticsTableViewCell.m
//  WorkAssistant
//
//  Created by mt y on 2018/7/10.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTStatisticsTableViewCell.h"

@implementation MTStatisticsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)monthBtn:(UIButton *)sender {
    sender.backgroundColor = ZHCololorRGB(253, 107, 101, 1);
    [sender setTitleColor:ZHCololorRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    self.weekBtn.backgroundColor = ZHCololorRGB(239, 239, 239, 1);
    [self.weekBtn setTitleColor:ZHCololorRGB(102, 102, 102, 1) forState:UIControlStateNormal];
    self.dayBtn.backgroundColor = ZHCololorRGB(239, 239, 239, 1);
    [self.dayBtn setTitleColor:ZHCololorRGB(102, 102, 102, 1) forState:UIControlStateNormal];
    if (self.btnBlock) {
        self.btnBlock(0);
    }
}
- (IBAction)weekBtn:(UIButton *)sender {
    sender.backgroundColor = ZHCololorRGB(253, 107, 101, 1);
    [sender setTitleColor:ZHCololorRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    self.monthBtn.backgroundColor = ZHCololorRGB(239, 239, 239, 1);
    [self.monthBtn setTitleColor:ZHCololorRGB(102, 102, 102, 1) forState:UIControlStateNormal];
    self.dayBtn.backgroundColor = ZHCololorRGB(239, 239, 239, 1);
    [self.dayBtn setTitleColor:ZHCololorRGB(102, 102, 102, 1) forState:UIControlStateNormal];
    if (self.btnBlock) {
        self.btnBlock(1);
    }
}
- (IBAction)dayBtn:(UIButton *)sender {
    sender.backgroundColor = ZHCololorRGB(253, 107, 101, 1);
    [sender setTitleColor:ZHCololorRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    self.weekBtn.backgroundColor = ZHCololorRGB(239, 239, 239, 1);
    [self.weekBtn setTitleColor:ZHCololorRGB(102, 102, 102, 1) forState:UIControlStateNormal];
    self.monthBtn.backgroundColor = ZHCololorRGB(239, 239, 239, 1);
    [self.monthBtn setTitleColor:ZHCololorRGB(102, 102, 102, 1) forState:UIControlStateNormal];
    if (self.btnBlock) {
        self.btnBlock(2);
    }
}

@end
