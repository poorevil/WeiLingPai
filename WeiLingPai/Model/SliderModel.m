//
//  SliderModel.m
//  WeiLingPai
//
//  Created by han chao on 14-1-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SliderModel.h"

@implementation SliderModel

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.sid = [dict objectForKey:@"sid"];
        self.title = [dict objectForKey:@"title"];
        self.openUrl = [dict objectForKey:@"openUrl"];
        self.imageUrl = [dict objectForKey:@"imageUrl"];
    }
    return self;
}


-(void)dealloc
{
    self.sid = nil;
    self.title = nil;
    self.openUrl = nil;
    self.imageUrl = nil;
    
    [super dealloc];
}

@end
