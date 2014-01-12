//
//  PortalModel.m
//  WeiLingPai
//
//  Created by han chao on 14-1-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "PortalModel.h"

@implementation PortalModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = [dict objectForKey:@"name"];
        self.pid = [dict objectForKey:@"pid"];
        self.iconFileName = [dict objectForKey:@"iconFileName"];
        self.accessToken = [dict objectForKey:@"accessToken"];
        self.lastLogin = [[dict objectForKey:@"lastLogin"] doubleValue];
    }
    
    return self;
}

-(void)dealloc
{
    self.name = nil;
    self.pid = nil;
    self.iconFileName = nil;
    self.accessToken = nil;
    
    [super dealloc];
}

@end
