//
//  ViewController.m
//  schedule
//
//  Created by zbc on 15/10/17.
//  Copyright © 2015年 zbc. All rights reserved.
//

#import "ViewController.h"
#import "BCClassButton.h"

@interface ViewController ()

@end

@implementation ViewController

const float KX = 30;
const float KXInScrollView = 0;
const float KX_5s_ScrollView = 340;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    if([self judgeMent] == 0){
        self.KYScrollView = 736-64-49-45;
        self.KXScrollView = self.view.bounds.size.width - KX;//显示日期
    }
    else if([self judgeMent] == 1){
        self.KYScrollView = 667-64-49-45;
        self.KXScrollView = self.view.bounds.size.width - KX;//显示日期
    }
    else{
        self.KYScrollView = 667-64-49-45;
        self.KXScrollView = KX_5s_ScrollView;
    }
    self.KX_AVG_View = self.KXScrollView/7.0;
}

-(void) viewWillAppear:(BOOL)animated{
    [self draw];
}

- (IBAction)ClickRightButton:(id)sender {
    [self performSegueWithIdentifier:@"AddClass" sender:self];
}

- (void)draw{
    [self drawMianScreen];
    [self drawLeftTimeView];
    [self addClassToSchedule];
    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.height);
    [self drawTimeLine];
    [self drawTitleWeek];
}

-(void) drawMianScreen{
    
    const float OneHour = (self.KYScrollView)/14;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(KX,45,self.KXScrollView, self.KYScrollView)];
    
    int judgeNumber = [self judgeMent];
    if(judgeNumber == 2){
        self.scrollView.contentSize = CGSizeMake(KX_5s_ScrollView+50,self.KYScrollView+99);//5s
    }
    else if(judgeNumber == 3){
        self.scrollView.contentSize = CGSizeMake(self.KXScrollView+50,self.KYScrollView+99+88);//4s
    }
    else{
        self.scrollView.contentSize = CGSizeMake(self.KXScrollView,0);//6,6p
    }
    
    [self.scrollView setBounces:false];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f
                                                      green:246.0f/255.0f
                                                       blue:246.0f/255.0f
                                                      alpha:1.0f];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    
    
    UILabel *SeparateLine;
    float x = 0;
    for(int i=0;i<15;i++){
        SeparateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, x , 444, 0.5)];
        SeparateLine.layer.borderWidth = 1;
        SeparateLine.layer.borderColor = [[UIColor colorWithRed:0.0f/255.0f
                                                          green:0.0f/255.0f
                                                           blue:0.0f/255.0f
                                                          alpha:0.1f] CGColor];
        x+=OneHour;
        [self.scrollView addSubview:SeparateLine];
    }
    
}

//显示时间
-(void) drawLeftTimeView{
    
    const float OneHour = (self.KYScrollView)/14;
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    self.LeftTimeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, KX,self.KYScrollView)];
    self.LeftTimeView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f
                                                        green:246.0f/255.0f
                                                         blue:246.0f/255.0f
                                                        alpha:1.0f];
    [self.view addSubview:self.LeftTimeView];
    
    
    float diet = (hour-8) + minute/60.0;
    
    UILabel *timeLine = [[UILabel alloc] initWithFrame:CGRectMake(0,diet * OneHour,30,2)];
    timeLine.layer.borderWidth = 1;
    timeLine.layer.borderColor = [[UIColor redColor] CGColor];
    [self.LeftTimeView addSubview:timeLine];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,diet * OneHour-15, 30, 20)];
    if(minute < 10){
        timeLabel.text = [NSString stringWithFormat:@"%ld:0%ld",(long)hour,(long)minute];
    }
    else{
        timeLabel.text = [NSString stringWithFormat:@"%ld:%ld",(long)hour,(long)minute];
    }
    
    timeLabel.font = [UIFont fontWithName:@"Helvetica" size:8];
    [self.LeftTimeView addSubview:timeLabel];
    
    
    
    UILabel *SeparateLine;
    float x = 0;
    for(int i=0;i<15;i++){
        SeparateLine = [[UILabel alloc] initWithFrame:CGRectMake(0,x,444,0.5)];
        SeparateLine.layer.borderWidth = 1;
        SeparateLine.layer.borderColor = [[UIColor colorWithRed:0.0f/255.0f
                                                          green:0.0f/255.0f
                                                           blue:0.0f/255.0f
                                                          alpha:0.1f] CGColor];
        x+=OneHour;
        [self.LeftTimeView addSubview:SeparateLine];
    }
    
    
    UILabel *HourLabel;
    x=0;
    for(int i=0;i<15;i++){
        HourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,x,30,OneHour)];
        HourLabel.textAlignment = UITextAlignmentCenter;
        HourLabel.text = [NSString stringWithFormat:@"%d",i+8];
        HourLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        HourLabel.textColor = [UIColor colorWithRed:0.0f/255.0f
                                              green:0.0f/255.0f
                                               blue:0.0f/255.0f
                                              alpha:0.2f];
        x+=OneHour;
        [self.LeftTimeView addSubview:HourLabel];
    }
}

//显示星期
-(void) drawTitleWeek{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [NSDate date];
    int daysToAdd = 0;
    NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth  fromDate:newDate];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    
    self.titleWeekView = [[UIScrollView alloc] initWithFrame:CGRectMake(KX,0,self.KXScrollView,45)];
    self.titleWeekView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleWeekView];
    NSArray *WeekArray = [[NSArray alloc] initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    UIButton *ButtonLabel;
    int x = 0;
    
    
    //星期下面的横线
    int week = [self getWeek];
    for(int i=0;i<7;i++){
        ButtonLabel = [[UIButton alloc] initWithFrame:CGRectMake(x,0,self.KX_AVG_View,45)];
        x+=self.KX_AVG_View;
        [ButtonLabel setTitle:[WeekArray objectAtIndex:i]forState:UIControlStateNormal];
        [ButtonLabel setFont:[UIFont fontWithName:@"yuanti" size: 8.0]];
        if(week == i){
            [ButtonLabel setTitleColor:[UIColor colorWithRed:102.0f/255.0f
                                                       green:205.0f/255.0f
                                                        blue:0.0f/255.0f
                                                       alpha:1.0f]
                              forState:UIControlStateNormal];
            
        }else{
            [ButtonLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [self.titleWeekView addSubview:ButtonLabel];
    }
    
    UILabel *weekLine =  [[UILabel alloc] initWithFrame:CGRectMake(week * self.KX_AVG_View,43,self.KX_AVG_View,2)];
    
    weekLine.layer.borderWidth = 1;
    weekLine.layer.borderColor = [[UIColor colorWithRed:102.0f/255.0f
                                                  green:205.0f/255.0f
                                                   blue:0.0f/255.0f
                                                  alpha:1.0f] CGColor];
    weekLine.backgroundColor = [UIColor colorWithRed:102.0f/255.0f
                                               green:205.0f/255.0f
                                                blue:0.0f/255.0f
                                               alpha:1.0f];
    [self.titleWeekView addSubview:weekLine];
    
    int a = 0;
    for(int i=0;i<7;i++){
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *date = [NSDate date];
        int daysToAdd = 0;
        if(i-week<0){
            daysToAdd = 7-week+i;
        }
        else{
            daysToAdd = i-week;
        }
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth  fromDate:newDate];
        NSInteger month = [comps month];
        NSInteger day = [comps day];
        NSLog(@"%ld %ld\n",(long)month,(long)day);
        
        UILabel *dateLine = [[UILabel alloc] initWithFrame:CGRectMake(a,33,self.KX_AVG_View,10)];
        if((long)day<10){
            dateLine.text = [NSString stringWithFormat:@"%ld-0%ld",(long)month,(long)day];
        }
        else{
            dateLine.text = [NSString stringWithFormat:@"%ld-%ld",(long)month,(long)day];
        }
        dateLine.font= [UIFont fontWithName:@"Helvetica" size: 10.0];
        if(week == i){
            dateLine.textColor = [UIColor colorWithRed:102.0f/255.0f
                                                 green:205.0f/255.0f
                                                  blue:0.0f/255.0f
                                                 alpha:1.0f];
        }else{
            dateLine.textColor = [UIColor blackColor];
        }
        dateLine.textAlignment = UITextAlignmentCenter;
        [self.titleWeekView addSubview:dateLine];
        a+=self.KX_AVG_View;
    }
    
}


//添加课程
-(void) addClassToSchedule{
    
    const float OneHour = (self.KYScrollView)/14;
    
    NSLog(@"%f,%f,%f",OneHour,OneHour*2,OneHour*3);
    
    BCClassButton *button = [[BCClassButton alloc] initWithFrame:CGRectMake(KXInScrollView,0,self.KX_AVG_View,2*OneHour)];
    button.backgroundColor = [UIColor colorWithRed:30.0f/255.0f
                                             green:144.0f/255.0f
                                              blue:250.0f/255.0f
                                             alpha:1.0f];
    [button DrawButton:@"科技大师讲座" ClassTime:@"@N103"];
    [self.scrollView addSubview:button];
    
    BCClassButton *button2 = [[BCClassButton alloc] initWithFrame:CGRectMake(KXInScrollView,0 + 5 * OneHour,self.KX_AVG_View,3*OneHour)];
    button2.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                              green:105.0f/255.0f
                                               blue:180.0f/255.0f
                                              alpha:1.0f];
    [button2 DrawButton:@"离散数学" ClassTime:@"@C302"];
    [self.scrollView addSubview:button2];
    
    
    BCClassButton *button3 = [[BCClassButton alloc] initWithFrame:CGRectMake(KXInScrollView + self.KX_AVG_View * 4,0 + 3 * OneHour,self.KX_AVG_View,3*OneHour)];
    button3.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                              green:105.0f/255.0f
                                               blue:180.0f/255.0f
                                              alpha:1.0f];
    [button3 DrawButton:@"计算机组成原理" ClassTime:@"@C302"];
    
    [self.scrollView addSubview:button3];
}


-(int) getWeek{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [comps weekday];
    if(weekday == 1){
        weekday = 6;
    }
    else if(weekday == 7){
        weekday = 5;
    }
    else{
        weekday = weekday - 2;
    }
    return weekday;
}


-(void) drawTimeLine{
    const float OneHour = (self.KYScrollView)/14;
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    int week = [self getWeek];
    
    float diet = (hour - 8) + (minute/60.0);
    NSLog(@"%f",diet);
    UILabel *timeLine = [[UILabel alloc] initWithFrame:CGRectMake(KXInScrollView + week * self.KX_AVG_View ,diet * OneHour, self.KX_AVG_View, 2)];
    
    
    timeLine.layer.borderWidth = 1;
    timeLine.layer.borderColor = [[UIColor redColor] CGColor];
    [self.scrollView addSubview:timeLine];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.titleWeekView setContentOffset:CGPointMake(scrollView.contentOffset.x,0)];
    [self.LeftTimeView setContentOffset:CGPointMake(0,scrollView.contentOffset.y)];
}

-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    [scrollView setContentOffset:scrollView.contentOffset animated:NO];
}



-(int) judgeMent{
    if(self.view.bounds.size.height > 700){
        return 0;
    }
    else if(self.view.bounds.size.height > 600 && self.view.bounds.size.height < 700){
        return 1;
    }
    else if(self.view.bounds.size.height> 500 && self.view.bounds.size.height<600){
        return 2;
    }
    else{
        return 3;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
