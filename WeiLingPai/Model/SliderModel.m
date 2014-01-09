//
//  SliderModel.m
//  WeiLingPai
//
//  Created by han chao on 14-1-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SliderModel.h"

@implementation SliderModel

-(void)dealloc
{
    self.sid = nil;
    self.title = nil;
    self.openUrl = nil;
    self.imageUrl = nil;
    
    [super dealloc];
}

@end
