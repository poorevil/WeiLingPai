//
//  RegisterViewController.h
//  WeiLingPai
//
//  Created by han chao on 14-1-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) IBOutlet UITableView *mtableView;
@property (nonatomic,retain) IBOutlet UIButton *scanQRCodeBtn;
@end
