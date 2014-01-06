//
//  MainViewCell.h
//  WeiLingPai
//
//  Created by han chao on 14-1-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PortalModel;

@interface MainViewCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UIView *leftView;
@property (nonatomic,retain) IBOutlet UIView *rightView;

-(void)setLeftViewByProtal:(PortalModel *)model;

-(void)setRightViewByProtal:(PortalModel *)model;

@end
