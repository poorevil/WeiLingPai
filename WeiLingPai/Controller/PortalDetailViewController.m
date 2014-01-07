//
//  PortalDetailViewController.m
//  WeiLingPai
//
//  Created by han chao on 14-1-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "PortalDetailViewController.h"
#import "PortalModel.h"

@interface PortalDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation PortalDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /*
     * 登录按钮
     */
    // the space between the image and text
    CGFloat spacing = 6.0;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = self.loginBtn.imageView.frame.size;
    self.loginBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0,
                                                     - imageSize.width,
                                                     - (imageSize.height + spacing),
                                                     0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = self.loginBtn.titleLabel.frame.size;
    self.loginBtn.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing),
                                                     0.0,
                                                     0.0,
                                                     - titleSize.width);
    
    self.title = self.portalModel.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.loginBtn = nil;
    self.mTableView = nil;
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"查看异常登录";
            cell.detailTextLabel.text = @"通过查询历史登录记录从而发现账户登录情况";
            cell.imageView.image = [UIImage imageNamed:@"detail_tableviewcell_alert"];
            break;
        case 1:
            cell.textLabel.text = @"锁定账号";
            cell.detailTextLabel.text = @"将账号临时修改为锁定状态从而保护账号安全";
            cell.imageView.image = [UIImage imageNamed:@"detail_tableviewcell_lock"];
            break;
        case 2:
            cell.textLabel.text = @"账号解绑";
            cell.detailTextLabel.text = @"解除账号绑定状态";
            cell.imageView.image = [UIImage imageNamed:@"detail_tableviewcell_power"];
            break;
    }
    
    return cell ;
}



@end
