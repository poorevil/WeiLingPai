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
    //    "id":   obj.id,
    //    "name": obj.name,
    //    "iconUrl": obj.iconUrl,
    //    "homepageUrl": obj.homepageUrl,
    //    "registInterfaceUrl": obj.registInterfaceUrl,
    
    if (self = [super init]) {
        self.name = [dict objectForKey:@"name"];
        self.pid = [dict objectForKey:@"id"];
        self.iconFileName = [dict objectForKey:@"iconUrl"];
        self.homepageUrl = [dict objectForKey:@"homepageUrl"];
        self.isRegisted = [dict objectForKey:@"isRegisted"]==nil?NO:[[dict objectForKey:@"isRegisted"] boolValue];
        self.lastLogin = [dict objectForKey:@"lastLogin"]==nil?0:[[dict objectForKey:@"lastLogin"] doubleValue];
    }
    
    return self;
}

-(void)dealloc
{
    self.name = nil;
    self.pid = nil;
    self.iconFileName = nil;
    self.homepageUrl = nil;
    
    [super dealloc];
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.pid forKey:@"pid"];
    [aCoder encodeObject:self.iconFileName forKey:@"iconFileName"];
    [aCoder encodeBool:self.isRegisted forKey:@"isRegisted"];
    [aCoder encodeDouble:self.lastLogin forKey:@"lastLogin"];
    [aCoder encodeObject:self.homepageUrl forKey:@"homepageUrl"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init]){
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.pid = [aDecoder decodeObjectForKey:@"pid"];
        self.iconFileName = [aDecoder decodeObjectForKey:@"iconFileName"];
        self.isRegisted = [aDecoder decodeBoolForKey:@"isRegisted"];
        self.lastLogin = [aDecoder decodeDoubleForKey:@"lastLogin"];
        self.homepageUrl = [aDecoder decodeObjectForKey:@"homepageUrl"];
        
    }
    
    return self;
}

@end
