//
//  GlobeModel.m
//  WeiLingPai
//
//  Created by hanchao on 14-1-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "GlobeModel.h"
#import "KeyChainTool.h"

#define kDeviceID   @"deviceId"
#define kUserDefaultPortalListKey   @"kUserDefaultPortalListKey"

@implementation GlobeModel

+(GlobeModel *)sharedSingleton
{
    static GlobeModel *sharedSingleton=nil;
    
    @synchronized(self)
    {
        if (!sharedSingleton) {
            sharedSingleton = [[GlobeModel alloc] init];
        }
        return sharedSingleton;
    }
}

-(id)init{
    if (self = [super init]) {
        self.deviceId = [KeyChainTool getValueByKey:kDeviceID];
        
        if (self.deviceId == nil) {
            self.deviceId = [self getUniqueStrByUUID];
            [KeyChainTool setValue:self.deviceId forKey:kDeviceID];
        }
    }
    
    return self;
}

//生成uuid
- (NSString *)getUniqueStrByUUID
{
    
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    
    NSString    *uuidString = (NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString ;
    
}

//获取portal list
-(NSMutableArray *)getPortalList
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:kUserDefaultPortalListKey];
    
    if(data.length>0){
        NSMutableArray *portalList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return portalList;
    }
    
    return nil;
}

//保存portal list
-(void)savePortalList:(NSMutableArray *)portalList
{
    if(portalList.count > 0){
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:portalList];
        [ud setObject:udObject forKey:kUserDefaultPortalListKey];
    }
}

-(void)dealloc
{
    self.deviceId = nil;
    [super dealloc];
}
@end
