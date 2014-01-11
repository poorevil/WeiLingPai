//
//  SliderResponseSerializer.m
//  WeiLingPai
//
//  Created by han chao on 14-1-11.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SliderResponseSerializer.h"
#import "SliderModel.h"

@implementation SliderResponseSerializer

#pragma mark - AFURLRequestSerialization
-(id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
//    [
//     {
//         "imageUrl": "http://www.baidu.com",
//         "title": "中国银行",
//         "openUrl": "http://www.baidu.com",
//         "sid": "111"
//     }
//     ]
    
    NSArray *resultlist = [super responseObjectForResponse:response
                                                      data:data
                                                     error:error];
    
    
    NSMutableArray * sliderArray = [NSMutableArray new];
    if (resultlist != nil)
    {
        [resultlist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [sliderArray addObject:[[[SliderModel alloc] initWithDict:obj] autorelease]];
        }];
    }
    return sliderArray;
}

@end
