//
//  SliderModel.h
//  WeiLingPai
//  首页幻灯片model
//  Created by han chao on 14-1-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SliderModel : NSObject

@property (nonatomic,retain) NSString *sid;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *openUrl;
@property (nonatomic,retain) NSString *imageUrl;

-(id)initWithDict:(NSDictionary *)dict;
@end
