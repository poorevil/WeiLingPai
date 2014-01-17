//
//  MainViewCellTileView.h
//  WeiLingPai
//
//  Created by han chao on 14-1-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PortalModel.h"
#import "EGOImageView.h"

@interface MainViewCellTileView : UIView

@property (nonatomic,retain) PortalModel *model;

@property (nonatomic,retain) IBOutlet EGOImageView *iconView;
@property (nonatomic,retain) IBOutlet UILabel *lastLoginLabel;

@end
