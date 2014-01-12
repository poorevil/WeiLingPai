//
//  PortalModel.h
//  WeiLingPai
//
//  Created by han chao on 14-1-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PortalModel : NSObject

@property (nonatomic,retain) NSString *pid;             //唯一标识
@property (nonatomic,retain) NSString *name;            //名称
@property (nonatomic,assign) NSTimeInterval lastLogin;  //最后登录时间
@property (nonatomic,retain) NSString *iconFileName;    //图标

@property (nonatomic,retain) NSString *accessToken;     //访问token,此token需要在第一次使用时，由服务器端生成

-(id)initWithDictionary:(NSDictionary *)dict;

@end
