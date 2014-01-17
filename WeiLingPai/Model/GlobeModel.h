//
//  GlobeModel.h
//  WeiLingPai
//
//  Created by hanchao on 14-1-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobeModel : NSObject

@property (nonatomic,retain) NSString *deviceId;

+(GlobeModel *)sharedSingleton;

//获取portal list
-(NSMutableArray *)getPortalList;

//保存portal list
-(void)savePortalList:(NSMutableArray *)portalList;
@end
