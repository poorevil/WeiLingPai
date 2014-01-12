//
//  PortalDetailViewController.h
//  WeiLingPai
//
//  Created by han chao on 14-1-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PortalModel;

@interface PortalDetailViewController : UIViewController

@property (nonatomic,retain) PortalModel *portalModel;

@property (nonatomic,retain) IBOutlet UIButton *loginBtn;
@property (nonatomic,retain) IBOutlet UILabel *loginLabel;
@property (nonatomic,retain) IBOutlet UITableView *mTableView;

@end
