//
//  PortalModel.h
//  WeiLingPai
//
//  Created by han chao on 14-1-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PortalModel : NSObject

@property (nonatomic,retain) NSString *pid;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,assign) NSTimeInterval lastLogin;
@property (nonatomic,retain) NSString *iconFileName;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
