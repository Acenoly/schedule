//
//  BCClassButton.m
//  MUSTBEE
//
//  Created by zbc on 15/10/19.
//  Copyright © 2015年 zbc. All rights reserved.
//

#import "BCClassButton.h"

@implementation BCClassButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

- (void) DrawButton:(NSString *)className ClassTime:(NSString *)ClassTime{
    UILabel *ClassNameLabel;
    UILabel *PlaceLabel;
    ClassNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10,40)];
    [ClassNameLabel setNumberOfLines:2];
    ClassNameLabel.textAlignment = UITextAlignmentCenter;
    UIFont *font = [UIFont fontWithName:@"Arial" size:10];
    ClassNameLabel.font = font;
    ClassNameLabel.text = className;
    ClassNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:ClassNameLabel];
    
    PlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,self.frame.size.height - 40, self.frame.size.width-10,40)];
    PlaceLabel.font = font;
    PlaceLabel.text = ClassTime;
    PlaceLabel.textAlignment = UITextAlignmentCenter;
    PlaceLabel.textColor = [UIColor whiteColor];
    [self addSubview:PlaceLabel];

}

@end
