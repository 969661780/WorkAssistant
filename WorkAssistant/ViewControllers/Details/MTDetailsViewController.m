//
//  MTDetailsViewController.m
//  WorkAssistant
//
//  Created by mt y on 2018/7/9.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTDetailsViewController.h"
#import "MTHomeTitleTableViewCell.h"
#import "MTMoneyMode.h"
#import <Masonry.h>
@interface MTDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *overTimeArr;
@property (nonatomic, strong)NSMutableArray *othersTimeArr;
@property (nonatomic, strong)NSMutableArray *bonusArr;
@property (nonatomic, strong)NSMutableArray *subsidyArr;
@property (nonatomic, assign)NSInteger detailsOverTimeMoney;
@property (nonatomic, assign)NSInteger detailsOthersMoney;
@property (nonatomic, assign)NSInteger detailsBonusMoney;
@property (nonatomic, assign)NSInteger detailsSubsidyMoney;
@property (nonatomic, strong)UIView *noData;
@property (nonatomic, strong)UIImageView *imageVIew;
@property (nonatomic, strong)UILabel *abe;

@end

@implementation MTDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTHomeTitleTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTHomeTitleTableViewCell class])];
    self.myTableView.rowHeight = 50;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
}
- (void)addNoDateView
{
    CHKit_WeakSelf
    //    self.noData.frame = CGRectMake(self.myTableView.x, self.myTableView.y, ZHScreenW, self.myTableView.height);
    [self.view addSubview:self.noData];
    [self.noData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.myTableView);
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
#pragma mark -getData
- (void)getData
{
    self.detailsOverTimeMoney = 0;
    self.detailsOthersMoney = 0;
    self.detailsBonusMoney = 0;
    self.detailsSubsidyMoney = 0;
    self.overTimeArr = [MTDataTool getAllCardMode:@"overTime"];
    self.othersTimeArr = [MTDataTool getAllCardMode:@"others"];
    self.bonusArr = [MTDataTool getAllCardMode:@"bonus"];
    self.subsidyArr = [MTDataTool getAllCardMode:@"Subsidy"];
    [self.overTimeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        self.detailsOverTimeMoney += ([mode.revenueMode integerValue]);
    }];
    [self.othersTimeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        self.detailsOthersMoney += ([mode.revenueMode integerValue]);
    }];
    [self.bonusArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        self.detailsBonusMoney += ([mode.revenueMode integerValue]);
    }];
    [self.subsidyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        self.detailsSubsidyMoney += ([mode.revenueMode integerValue]);
    }];
    if (self.overTimeArr.count == 0 && self.othersTimeArr.count== 0 && self.bonusArr.count== 0 && self.subsidyArr.count== 0) {
        [self renoveDataView];
        [self addNoDateView];
    }else{
        [self renoveDataView];
    }
    [self.myTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.overTimeArr.count;
            break;
        case 1:
            return self.othersTimeArr.count;
            break;
        case 2:
            return self.subsidyArr.count;
            break;
        default:
            return self.bonusArr.count;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTHomeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTHomeTitleTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        MTMoneyMode *mode = self.overTimeArr[indexPath.row];
        cell.titleLable.text = mode.dateMode;
        cell.markLable.text = mode.remarkMode;
        cell.moneyLable.text = [NSString stringWithFormat:@"+%@",mode.revenueMode];
    }else if (indexPath.section == 1){
        MTMoneyMode *mode = self.othersTimeArr[indexPath.row];
        cell.titleLable.text = mode.dateMode;
        cell.markLable.text = mode.remarkMode;
        cell.moneyLable.text = [NSString stringWithFormat:@"+%@",mode.revenueMode];
    }else if (indexPath.section == 2){
        MTMoneyMode *mode = self.subsidyArr[indexPath.row];
        cell.titleLable.text = mode.dateMode;
        cell.markLable.text = mode.remarkMode;
        cell.moneyLable.text = [NSString stringWithFormat:@"+%@",mode.revenueMode];
    }else{
        MTMoneyMode *mode = self.bonusArr[indexPath.row];
        cell.titleLable.text = mode.dateMode;
        cell.markLable.text = mode.remarkMode;
        cell.moneyLable.text = [NSString stringWithFormat:@"+%@",mode.revenueMode];
    }
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView= [UIView new];
    backView.backgroundColor = ZHCololorRGB(233, 233, 233, 1);
    UILabel *myLable = [UILabel new];
    myLable.font = ZHFont_Detitle;
    myLable.textColor = ZHCololorRGB(53, 53, 53, 1);
    [backView addSubview:myLable];
    [myLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.left.equalTo(@(10));
    }];
    UILabel *moneyLable = [UILabel new];
    moneyLable.font = ZHFont_Detitle;
    moneyLable.textColor = ZHCololorRGB(253, 107, 102, 1);
    [backView addSubview:moneyLable];
    [moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.right.equalTo(@(-13));
    }];
    if (section == 0)
    {
       myLable.text = @"Overtime";
       moneyLable.text = [NSString stringWithFormat:@"+%ld",self.detailsOverTimeMoney];

    }else if (section== 1)
    {
        myLable.text = @"Others";
        moneyLable.text = [NSString stringWithFormat:@"+%ld",self.detailsOthersMoney];
    }else if (section == 2)
    {
        myLable.text = @"Subsidy";
        moneyLable.text = [NSString stringWithFormat:@"+%ld",self.detailsSubsidyMoney];
    }else
    {
        myLable.text = @"Bonus";
        moneyLable.text = [NSString stringWithFormat:@"+%ld",self.detailsBonusMoney];
    }
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
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
