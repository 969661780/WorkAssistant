//
//  MTStatisticsViewController.m
//  WorkAssistant
//
//  Created by mt y on 2018/7/9.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTStatisticsViewController.h"
#import "MTStatisticsAllTableViewCell.h"
#import "MTStatisticsTableViewCell.h"
#import "MTMoneyMode.h"
#import <Masonry.h>
#import "WSPieChart.h"
@interface MTStatisticsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign)NSInteger btnIndex;
@property (nonatomic, assign)NSInteger totalDayRevenueMoney;
@property (nonatomic, assign)NSInteger totalWeekRevenueMoney;
@property (nonatomic, assign)NSInteger totalMonthRevenueMoney;
//天
@property (nonatomic, strong)NSMutableArray *detailsOverTime;
@property (nonatomic, strong)NSMutableArray *detailsOthers;
@property (nonatomic, strong)NSMutableArray *detailsBonus;
@property (nonatomic, strong)NSMutableArray *detailsSubsidy;
//周
@property (nonatomic, strong)NSMutableArray *weekOverTime;
@property (nonatomic, strong)NSMutableArray *weekOthers;
@property (nonatomic, strong)NSMutableArray *weekBonus;
@property (nonatomic, strong)NSMutableArray *weekSubsidy;
//月
@property (nonatomic, strong)NSMutableArray *monthOverTime;
@property (nonatomic, strong)NSMutableArray *monthOthers;
@property (nonatomic, strong)NSMutableArray *monthBonus;
@property (nonatomic, strong)NSMutableArray *monthSubsidy;

@property (nonatomic, strong)NSMutableDictionary *dataDicDay;
@property (nonatomic, strong)NSMutableDictionary *dataDicWeek;
@property (nonatomic, strong)NSMutableDictionary *dataDicMonth;

@property (nonatomic, strong)WSPieChart *pie;
@property (nonatomic, strong)UIView *noData;
@property (nonatomic, strong)UIImageView *imageVIew;
@property (nonatomic, strong)UILabel *abe;

@end

@implementation MTStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTStatisticsAllTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTStatisticsAllTableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTStatisticsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTStatisticsTableViewCell class])];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
}
- (void)getData
{
    
    self.detailsOverTime = [NSMutableArray new];
    self.detailsOthers = [NSMutableArray new];
    self.detailsSubsidy = [NSMutableArray new];
    self.detailsBonus = [NSMutableArray new];
    
    self.weekOverTime = [NSMutableArray new];
    self.weekOthers = [NSMutableArray new];
    self.weekBonus = [NSMutableArray new];
    self.weekSubsidy = [NSMutableArray new];
    
    self.monthOverTime = [NSMutableArray new];
    self.monthOthers = [NSMutableArray new];
    self.monthBonus = [NSMutableArray new];
    self.monthSubsidy = [NSMutableArray new];
    //数据源
    self.dataDicDay = [NSMutableDictionary new];
    self.dataDicWeek = [NSMutableDictionary new];
    self.dataDicMonth = [NSMutableDictionary new];
    
    NSMutableArray *overTimeArr = [MTDataTool getAllCardMode:@"overTime"];
    NSMutableArray *othersTimeArr = [MTDataTool getAllCardMode:@"others"];
    NSMutableArray *bonusArr = [MTDataTool getAllCardMode:@"bonus"];
    NSMutableArray *subsidyArr = [MTDataTool getAllCardMode:@"Subsidy"];
    self.totalDayRevenueMoney = 0;//算总金额
    self.totalWeekRevenueMoney = 0;//算总金额
    self.totalMonthRevenueMoney = 0;//算总金额
    __block NSInteger dayOverTimeMoney = 0;
    __block NSInteger dayOthersMoney = 0;
    __block NSInteger dayBonusMoney = 0;
    __block NSInteger daySubsidyMoney = 0;
    __block NSInteger monthOverTimeMoney = 0;
    __block NSInteger monthOthersMoney = 0;
    __block NSInteger monthBonusMoney = 0;
    __block NSInteger monthSubsidyMoney = 0;
    __block NSInteger weekOverTimeMoney = 0;
    __block NSInteger weekOthersMoney = 0;
    __block NSInteger weekBonusMoney = 0;
    __block NSInteger weekSubsidyMoney = 0;
    [overTimeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        if ([MTGetDate dayIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            self.totalDayRevenueMoney += ([mode.revenueMode integerValue]);
            [self.detailsOverTime addObject:mode];
            dayOverTimeMoney += ([mode.revenueMode integerValue]);
        }
        if ([MTGetDate weekIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            self.totalWeekRevenueMoney += ([mode.revenueMode integerValue]);
            [self.weekOverTime addObject:mode];
            weekOverTimeMoney += ([mode.revenueMode integerValue]);
            
        }
        if ([MTGetDate monthIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            self.totalMonthRevenueMoney += ([mode.revenueMode integerValue]);
            [self.monthOverTime addObject:mode];
            monthOverTimeMoney += ([mode.revenueMode integerValue]);
        }
    }];
    if (dayOverTimeMoney != 0) {
         [self.dataDicDay setValue:@(dayOverTimeMoney) forKey:@"Overtime"];
    }
    if (weekOverTimeMoney != 0) {
         [self.dataDicWeek setValue:@(weekOverTimeMoney) forKey:@"Overtime"];
    }
    if (monthOverTimeMoney != 0) {
         [self.dataDicMonth setValue:@(monthOverTimeMoney) forKey:@"Overtime"];
    }
   
   
  
    [othersTimeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        if ([MTGetDate dayIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            self.totalDayRevenueMoney += ([mode.revenueMode integerValue]);
            [self.detailsOthers addObject:mode];
            dayOthersMoney += ([mode.revenueMode integerValue]);
        }
        if ([MTGetDate weekIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            self.totalWeekRevenueMoney += ([mode.revenueMode integerValue]);
            [self.weekOthers addObject:mode];
            weekOthersMoney += ([mode.revenueMode integerValue]);
        }
        if ([MTGetDate monthIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            self.totalMonthRevenueMoney += ([mode.revenueMode integerValue]);
            [self.monthOthers addObject:mode];
            monthOthersMoney += ([mode.revenueMode integerValue]);
        }
    }];
    if (dayOthersMoney != 0) {
        [self.dataDicDay setValue:@(dayOthersMoney) forKey:@"Others"];
    }
    if (weekOthersMoney != 0) {
         [self.dataDicWeek setValue:@(weekOthersMoney) forKey:@"Others"];
    }
    if (monthOthersMoney != 0) {
      [self.dataDicMonth setValue:@(monthOthersMoney) forKey:@"Others"];
    }
    [bonusArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        if ([MTGetDate dayIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            self.totalDayRevenueMoney += ([mode.revenueMode integerValue]);
            [self.detailsBonus addObject:mode];
            dayBonusMoney += ([mode.revenueMode integerValue]);
        }
        if ([MTGetDate weekIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            self.totalWeekRevenueMoney += ([mode.revenueMode integerValue]);
            [self.weekBonus addObject:mode];
            weekBonusMoney += ([mode.revenueMode integerValue]);
        }
        if ([MTGetDate monthIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
             self.totalMonthRevenueMoney += ([mode.revenueMode integerValue]);
            [self.monthBonus addObject:mode];
            monthBonusMoney += ([mode.revenueMode integerValue]);
        }
    }];
    if (dayBonusMoney != 0) {
       [self.dataDicDay setValue:@(dayBonusMoney) forKey:@"Bonus"];
    }
    if (weekBonusMoney != 0) {
         [self.dataDicWeek setValue:@(weekBonusMoney) forKey:@"Bonus"];
    }
    if (monthBonusMoney != 0) {
         [self.dataDicMonth setValue:@(monthBonusMoney) forKey:@"Bonus"];
    }
    [subsidyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        if ([MTGetDate dayIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
             self.totalDayRevenueMoney += ([mode.revenueMode integerValue]);
            [self.detailsSubsidy addObject:mode];
            daySubsidyMoney += ([mode.revenueMode integerValue]);
        }
        if ([MTGetDate weekIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
             self.totalWeekRevenueMoney += ([mode.revenueMode integerValue]);
            [self.weekSubsidy addObject:mode];
             weekSubsidyMoney += ([mode.revenueMode integerValue]);
        }
        if ([MTGetDate monthIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
             self.totalMonthRevenueMoney += ([mode.revenueMode integerValue]);
            [self.monthSubsidy addObject:mode];
             monthSubsidyMoney += ([mode.revenueMode integerValue]);
        }
    }];
    if (daySubsidyMoney != 0) {
        [self.dataDicDay setValue:@(daySubsidyMoney) forKey:@"Subsidy"];
    }
    if (weekSubsidyMoney != 0) {
        [self.dataDicWeek setValue:@(weekSubsidyMoney) forKey:@"Subsidy"];
    }
    if (monthSubsidyMoney != 0) {
       [self.dataDicMonth setValue:@(monthSubsidyMoney) forKey:@"Subsidy"];
    }
    
    if (self.btnIndex == 0) {
        if (self.dataDicMonth.count == 0) {
            [self renoveDataView];
            [self addNoDateView];
        }else{
            [self renoveDataView];
            [self.myTableView reloadData];
        }
    }else if(self.btnIndex == 1){
        if (self.dataDicWeek.count == 0) {
            [self renoveDataView];
            [self addNoDateView];
        }else{
            [self renoveDataView];
            [self.myTableView reloadData];
        }
    }else{
        if (self.dataDicDay.count == 0) {
            [self renoveDataView];
            [self addNoDateView];
        }else{
            [self renoveDataView];
            [self.myTableView reloadData];
        }
    }
    
}
- (void)addNoDateView
{
    CHKit_WeakSelf
    //    self.noData.frame = CGRectMake(self.myTableView.x, self.myTableView.y, ZHScreenW, self.myTableView.height);
    [self.view addSubview:self.noData];
    [self.noData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myTableView);
        make.top.equalTo(self.myTableView).offset(88);
        make.width.bottom.equalTo(self.view);
    }];
    [self.imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_self.noData);
        make.centerY.equalTo(weak_self.noData).offset(-15);
    }];
    [self.abe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_self.noData);
        make.top.equalTo(self.imageVIew.mas_bottom);
    }];
    
}
- (void)renoveDataView
{
    [self.noData removeFromSuperview];
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MTStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTStatisticsTableViewCell class]) forIndexPath:indexPath];

        CHKit_WeakSelf
        cell.btnBlock = ^(int a) {
            weak_self.btnIndex = a;
            [weak_self getData];
        };
        [cell.myBackView addSubview:self.pie];
        if (self.btnIndex == 0) {
            cell.titalLable.text = [NSString stringWithFormat:@"+%ld",self.totalMonthRevenueMoney];
            self.pie.valueArr = self.dataDicMonth.allValues;
            self.pie.descArr = self.dataDicMonth.allKeys;
        }else if(self.btnIndex == 1){
            cell.titalLable.text = [NSString stringWithFormat:@"+%ld",self.totalWeekRevenueMoney];
            self.pie.valueArr = self.dataDicWeek.allValues;
            self.pie.descArr = self.dataDicWeek.allKeys;
        }else{
            cell.titalLable.text = [NSString stringWithFormat:@"+%ld",self.totalDayRevenueMoney];
            self.pie.valueArr = self.dataDicDay.allValues;
            self.pie.descArr = self.dataDicDay.allKeys;
        }
        self.pie.showDescripotion = YES;
        [self.pie showAnimation];
        return cell;
    }
    
    MTStatisticsAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTStatisticsAllTableViewCell class]) forIndexPath:indexPath];
    switch (indexPath.row) {
        case 1:
        {
            cell.headImage.image = [UIImage imageNamed:@"11"];
            cell.nameLable.text = @"Overtime";
            if (self.btnIndex == 0) {
                if ([self.dataDicMonth.allKeys containsObject:@"Overtime"]) {
                    cell.proGress.progress = [self.dataDicMonth[@"Overtime"] floatValue]/self.totalMonthRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicMonth[@"Overtime"] floatValue]/self.totalMonthRevenueMoney*100];
                }
                
            }else if(self.btnIndex == 1){
                if ([self.dataDicWeek.allKeys containsObject:@"Overtime"]) {
                    cell.proGress.progress = [self.dataDicWeek[@"Overtime"] floatValue]/self.totalWeekRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicWeek[@"Overtime"] floatValue]/self.totalWeekRevenueMoney*100];
                }
                
            }else{
                if ([self.dataDicDay.allKeys containsObject:@"Overtime"]) {
                    cell.proGress.progress = [self.dataDicDay[@"Overtime"] floatValue]/self.totalDayRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicDay[@"Overtime"] floatValue]/self.totalDayRevenueMoney*100];
                }
        }
            break;
        case 2:
        {
            cell.headImage.image = [UIImage imageNamed:@"22"];
            cell.nameLable.text = @"Others";
            if (self.btnIndex == 0) {
                if ([self.dataDicMonth.allKeys containsObject:@"Others"]) {
                    cell.proGress.progress = [self.dataDicMonth[@"Others"] floatValue]/self.totalMonthRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicMonth[@"Others"] floatValue]/self.totalMonthRevenueMoney*100];
                }
                
            }else if(self.btnIndex == 1){
                if ([self.dataDicWeek.allKeys containsObject:@"Others"]) {
                    cell.proGress.progress = [self.dataDicWeek[@"Others"] floatValue]/self.totalWeekRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicWeek[@"Others"] floatValue]/self.totalWeekRevenueMoney*100];
                }
                
            }else{
                if ([self.dataDicDay.allKeys containsObject:@"Others"]) {
                    cell.proGress.progress = [self.dataDicDay[@"Others"] floatValue]/self.totalDayRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicDay[@"Others"] floatValue]/self.totalDayRevenueMoney*100];
                }
            }
        }
            break;
        case 3:
        {
            cell.headImage.image = [UIImage imageNamed:@"33"];
            cell.nameLable.text = @"Bonus";
            if (self.btnIndex == 0) {
                if ([self.dataDicMonth.allKeys containsObject:@"Bonus"]) {
                    cell.proGress.progress = [self.dataDicMonth[@"Bonus"] floatValue]/self.totalMonthRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicMonth[@"Bonus"] floatValue]/self.totalMonthRevenueMoney*100];
                }
                
            }else if(self.btnIndex == 1){
                if ([self.dataDicWeek.allKeys containsObject:@"Bonus"]) {
                    cell.proGress.progress = [self.dataDicWeek[@"Bonus"] floatValue]/self.totalWeekRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicWeek[@"Bonus"] floatValue]/self.totalWeekRevenueMoney*100];
                }
                
            }else{
                if ([self.dataDicDay.allKeys containsObject:@"Bonus"]) {
                    cell.proGress.progress = [self.dataDicDay[@"Bonus"] floatValue]/self.totalDayRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicDay[@"Bonus"] floatValue]/self.totalDayRevenueMoney*100];
                }
            }
        }
            break;
        case 4:
        {
            cell.headImage.image = [UIImage imageNamed:@"22"];
            cell.nameLable.text = @"Subsidy";
            if (self.btnIndex == 0) {
                if ([self.dataDicMonth.allKeys containsObject:@"Subsidy"]) {
                    cell.proGress.progress = [self.dataDicMonth[@"Subsidy"] floatValue]/self.totalMonthRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicMonth[@"Subsidy"] floatValue]/self.totalMonthRevenueMoney*100];
                }
                
            }else if(self.btnIndex == 1){
                if ([self.dataDicWeek.allKeys containsObject:@"Subsidy"]) {
                    cell.proGress.progress = [self.dataDicWeek[@"Subsidy"] floatValue]/self.totalWeekRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicWeek[@"Subsidy"] floatValue]/self.totalWeekRevenueMoney*100];
                }
                
            }else{
                if ([self.dataDicDay.allKeys containsObject:@"Subsidy"]) {
                    cell.proGress.progress = [self.dataDicDay[@"Subsidy"] floatValue]/self.totalDayRevenueMoney;
                    cell.biliLable.text = [NSString stringWithFormat:@"%.2f%%",[self.dataDicDay[@"Subsidy"] floatValue]/self.totalDayRevenueMoney*100];
                }
            }
        }
            break;
        default:
            break;
            
    }
 
      
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 327;
    }
    return 50;
}
#pragma mark -getter
- (WSPieChart *)pie
{
    if (!_pie) {
        _pie = [[WSPieChart alloc] initWithFrame:CGRectMake(0 , 20, ZHScreenW, 160)];
        _pie.showDescripotion = NO;
        _pie.backgroundColor = [UIColor whiteColor];
        
    }
    return _pie;
}
- (UIView *)noData{
    if (!_noData) {
        _noData = [UIView new];
        _noData.backgroundColor = ZHBackgroundColor;
        self.imageVIew= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1313"]];
        
        //        imageVIew.frame = CGRectMake(self.myTableView.width/2 - 54, self.myTableView.height/2 - 32, 128, 84);
        [_noData addSubview:self.imageVIew];
        self.abe= [UILabel new];
        self.abe.text = @"There is no data now";
        self.abe.textColor = [UIColor grayColor];
        
        //        abe.frame = CGRectMake(imageVIew.x+ 15, imageVIew.y+imageVIew.height + 10, imageVIew.width, 50);
        [_noData addSubview:self.abe];
    }
    return _noData;
}
@end
