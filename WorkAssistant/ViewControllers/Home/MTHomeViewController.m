//
//  MTHomeViewController.m
//  WorkAssistant
//
//  Created by mt y on 2018/7/9.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTHomeTitleTableViewCell.h"
#import "MTDetailyTableViewCell.h"
#import "MTAddWorkViewController.h"
#import "MTMoneyMode.h"
#import <Masonry.h>

@interface MTHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLable;
@property (weak, nonatomic) IBOutlet UILabel *wagesLable;
@property (weak, nonatomic) IBOutlet UILabel *overTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *otherLable;
@property (weak, nonatomic) IBOutlet UIButton *overTimerBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UIButton *bonusBtn;
@property (weak, nonatomic) IBOutlet UIButton *subsidyBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeDetailyLable;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *detailsOverTime;
@property (nonatomic, strong)NSMutableArray *detailsOthers;
@property (nonatomic, strong)NSMutableArray *detailsBonus;
@property (nonatomic, strong)NSMutableArray *detailsSubsidy;

@property (nonatomic, assign)NSInteger detailsOverTimeMoney;
@property (nonatomic, assign)NSInteger detailsOthersMoney;
@property (nonatomic, assign)NSInteger detailsBonusMoney;
@property (nonatomic, assign)NSInteger detailsSubsidyMoney;
@property (nonatomic, assign)NSInteger detailsAllMoney;



@end

@implementation MTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUi];
}

#pragma mark -getData
-(void)getData
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:firstInstallApp]) {
         self.timeLable.text = [NSString stringWithFormat:@"%@~%@",[[NSUserDefaults standardUserDefaults] objectForKey:firstInstallApp],[MTGetDate getCurrentDate]];
    }else{
         self.timeLable.text = [NSString stringWithFormat:@"%@~%@",[MTGetDate getCurrentDate],[MTGetDate getCurrentDate]];
    }
   
    
    NSMutableArray *overTimeArr = [MTDataTool getAllCardMode:@"overTime"];
    NSMutableArray *othersTimeArr = [MTDataTool getAllCardMode:@"others"];
    NSMutableArray *bonusArr = [MTDataTool getAllCardMode:@"bonus"];
    NSMutableArray *subsidyArr = [MTDataTool getAllCardMode:@"Subsidy"];
    
    __block NSInteger totalRevenueMoney = 0;//算总金额
    __block NSInteger overTimerMoney = 0;//算加班金额
    
    //得到当天的各种消费对象
    self.detailsOverTime = [NSMutableArray new];
    self.detailsOthers = [NSMutableArray new];
    self.detailsSubsidy = [NSMutableArray new];
    self.detailsBonus = [NSMutableArray new];
    
    
    
    [overTimeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        totalRevenueMoney += ([mode.revenueMode integerValue]);
        overTimerMoney += ([mode.revenueMode integerValue]);
        if ([MTGetDate dayIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            [self.detailsOverTime addObject:mode];
        }
    }];
    [othersTimeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        totalRevenueMoney += ([mode.revenueMode integerValue]);
        if ([MTGetDate dayIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            [self.detailsOthers addObject:mode];
        }
    }];
    [bonusArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        totalRevenueMoney += ([mode.revenueMode integerValue]);
        if ([MTGetDate dayIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            [self.detailsBonus addObject:mode];
        }
    }];
    [subsidyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        totalRevenueMoney += ([mode.revenueMode integerValue]);
        if ([MTGetDate dayIsOk:[MTGetDate weekDateCompontents:[NSDate date]] dateFormat:mode.dateMode]) {
            [self.detailsSubsidy addObject:mode];
        }
    }];
    self.detailsAllMoney = 0;
    self.detailsSubsidyMoney = 0;
    self.detailsBonusMoney = 0;
    self.detailsOverTimeMoney = 0;
    self.detailsOthersMoney = 0;
    //总月薪
    NSInteger month = [MTGetDate numberOfDaysWithFromDate:[MTGetDate getDate:[[NSUserDefaults standardUserDefaults] objectForKey:firstInstallApp]] toDate:[NSDate date]];
    totalRevenueMoney += month * [[[NSUserDefaults standardUserDefaults] objectForKey:monthWages] integerValue];
    self.totalMoneyLable.text = [NSString stringWithFormat:@"+%ld",totalRevenueMoney];
    self.wagesLable.text = [NSString stringWithFormat:@"+%ld",month * [[[NSUserDefaults standardUserDefaults] objectForKey:monthWages] integerValue]];
    self.overTimeLable.text = [NSString stringWithFormat:@"+%ld",overTimerMoney];
    self.otherLable.text = [NSString stringWithFormat:@"+%ld",totalRevenueMoney - overTimerMoney -  month * [[[NSUserDefaults standardUserDefaults] objectForKey:monthWages] integerValue]];
   
    [self.detailsOverTime enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        self.detailsOverTimeMoney += ([mode.revenueMode integerValue]);
        self.detailsAllMoney += ([mode.revenueMode integerValue]);
    }];
    [self.detailsOthers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        self.detailsOthersMoney += ([mode.revenueMode integerValue]);
        self.detailsAllMoney += ([mode.revenueMode integerValue]);
    }];
    [self.detailsBonus enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        self.detailsBonusMoney += ([mode.revenueMode integerValue]);
        self.detailsAllMoney += ([mode.revenueMode integerValue]);
    }];
    [self.detailsSubsidy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        self.detailsSubsidyMoney += ([mode.revenueMode integerValue]);
        self.detailsAllMoney += ([mode.revenueMode integerValue]);
    }];
    [self.myTableView reloadData];
}
#pragma mark -setUi
- (void)setUi
{
    self.overTimerBtn.layer.cornerRadius = (ZHScreenW - 124)/4/2;
    self.overTimerBtn.layer.masksToBounds = YES;
    self.otherBtn.layer.cornerRadius = (ZHScreenW - 124)/4/2;
    self.otherBtn.layer.masksToBounds = YES;
    self.bonusBtn.layer.cornerRadius = (ZHScreenW - 124)/4/2;
    self.bonusBtn.layer.masksToBounds = YES;
    self.subsidyBtn.layer.cornerRadius = (ZHScreenW - 124)/4/2;
    self.subsidyBtn.layer.masksToBounds = YES;
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTHomeTitleTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTHomeTitleTableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTDetailyTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTDetailyTableViewCell class])];
    self.myTableView.rowHeight = 50;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
 
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    static BOOL isFirstEnter ;
    if (!isFirstEnter && ![[NSUserDefaults standardUserDefaults] objectForKey:@"firstApp"]) {
        UIAlertController *alerter = [UIAlertController alertControllerWithTitle:@"Wages" message:@"Please enter the monthly salary" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSString *wagesMoney =  [alerter.textFields[0] text];
            if ([wagesMoney isEqualToString:@""]) {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:monthWages];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self dismissViewControllerAnimated:YES completion:^{
                    [self getData];
                }];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:wagesMoney forKey:monthWages];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self dismissViewControllerAnimated:YES completion:^{
                    [self getData];
                }];
            }
           
        }];
        [alerter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.placeholder = @"Wages";
        }];
        [alerter addAction:action];
        [self presentViewController:alerter animated:YES completion:nil];
        isFirstEnter = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"13" forKey:@"firstApp"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
   
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MTHomeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTHomeTitleTableViewCell class]) forIndexPath:indexPath];
        cell.moneyLable.text = [NSString stringWithFormat:@"+%ld",self.detailsAllMoney];
        return cell;
    }
    MTDetailyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTDetailyTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row == 1) {
        cell.homeImageView.image = [UIImage imageNamed:@"11"];
        cell.homeTitleLable.text = @"Overtime";
        cell.homeMoneyLable.text = [NSString stringWithFormat:@"+%ld",self.detailsOverTimeMoney];
    }else if(indexPath.row == 2){
        cell.homeImageView.image = [UIImage imageNamed:@"22"];
        cell.homeTitleLable.text = @"Others";
        cell.homeMoneyLable.text = [NSString stringWithFormat:@"+%ld",self.detailsOthersMoney];
    }else if (indexPath.row == 3){
        cell.homeImageView.image = [UIImage imageNamed:@"33"];
        cell.homeTitleLable.text = @"Bonus";
        cell.homeMoneyLable.text = [NSString stringWithFormat:@"+%ld",self.detailsBonusMoney];
    }else{
        cell.homeImageView.image = [UIImage imageNamed:@"44"];
        cell.homeTitleLable.text = @"Subsidy";
        cell.homeMoneyLable.text = [NSString stringWithFormat:@"+%ld",self.detailsSubsidyMoney];
    }
   
    return cell;
}
#pragma Mark -touchs

- (IBAction)overTimeBtn:(UIButton *)sender {
    MTAddWorkViewController *mtadd = [MTAddWorkViewController new];
    mtadd.titleStr = @"overTime";
    [mtadd view];
    [self presentViewController:mtadd animated:YES completion:nil];
}
- (IBAction)otherBtn:(UIButton *)sender {
    MTAddWorkViewController *mtadd = [MTAddWorkViewController new];
    mtadd.titleStr = @"others";
    [mtadd view];
    [self presentViewController:mtadd animated:YES completion:nil];
}
- (IBAction)bonusBtn:(id)sender {
    MTAddWorkViewController *mtadd = [MTAddWorkViewController new];
    mtadd.titleStr = @"bonus";
    [mtadd view];
    [self presentViewController:mtadd animated:YES completion:nil];
}
- (IBAction)subsidyBtn:(UIButton *)sender {
    MTAddWorkViewController *mtadd = [MTAddWorkViewController new];
    mtadd.titleStr = @"Subsidy";
    [mtadd view];
    [self presentViewController:mtadd animated:YES completion:nil];
}
- (IBAction)wageBtn:(UIButton *)sender {
    UIAlertController *alerter = [UIAlertController alertControllerWithTitle:@"Wages" message:@"Please enter the monthly salary" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSString *wagesMoney =  [alerter.textFields[0] text];
        if ([wagesMoney isEqualToString:@""]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:monthWages];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismissViewControllerAnimated:YES completion:^{
                [self getData];
            }];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:wagesMoney forKey:monthWages];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismissViewControllerAnimated:YES completion:^{
                [self getData];
            }];
        }
        
    }];
    [alerter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = @"Wages";
    }];
    [alerter addAction:action];
    [self presentViewController:alerter animated:YES completion:nil];
}

@end
