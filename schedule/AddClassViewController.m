//
//  AddClassViewController.m
//  schedule
//
//  Created by zbc on 15/10/18.
//  Copyright © 2015年 zbc. All rights reserved.
//

#import "AddClassViewController.h"
#import "schedule-Swift.h"
@interface AddClassViewController ()

@end

@implementation AddClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@",self.navigationItem.leftBarButtonItem.title);
//    self.navigationItem.leftBarButtonItem.title = @"✖️";
    
    
//    [self showWaitOverlayWithText:@"正在加载"];
    // Do any additional setup after loading the view.
}
- (IBAction)cancel:(UIBarButtonItem *)sender {
//    [self removeAllOverlays];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
