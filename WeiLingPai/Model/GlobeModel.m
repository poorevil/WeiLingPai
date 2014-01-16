//
//  GlobeModel.m
//  WeiLingPai
//
//  Created by hanchao on 14-1-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "GlobeModel.h"

@implementation GlobeModel


//生成uuid
- (NSString *)getUniqueStrByUUID
{
    
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    
    NSString    *uuidString = (NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString ;
    
}


@end
