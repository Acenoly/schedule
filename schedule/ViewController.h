//
//  ViewController.h
//  schedule
//
//  Created by zbc on 15/10/17.
//  Copyright © 2015年 zbc. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIScrollView *titleWeekView;
@property (nonatomic,strong) UIScrollView *LeftTimeView;
@property float KYScrollView;
@property float KXScrollView;
@property float KX_AVG_View;

@end

