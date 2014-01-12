//
//  PortalDetailViewController.m
//  WeiLingPai
//
//  Created by han chao on 14-1-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "PortalDetailViewController.h"
#import "PortalModel.h"
#import "RegisterViewController.h"

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
    
    [self initLoginBtn];
    [self updateDateAndState];
    
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
    self.loginLabel = nil;
    
    [super dealloc];
}

#pragma mark - private method

// 初始化登录按钮
-(void)initLoginBtn
{
    //存在accesstoken，登录按钮
    if (self.portalModel.accessToken && self.portalModel.accessToken.length>0) {
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        self.loginLabel.text = @"扫描网页上的二维码进行登录";
    }else{
        //不存在accesstoken，绑定账号按钮
        [self.loginBtn setTitle:@"绑定账号" forState:UIControlStateNormal];
        self.loginLabel.text = @"扫描网页上的二维码进行绑定账号";
    }
    
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
    
    [self.loginBtn addTarget:self
                      action:@selector(loginBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateDateAndState
{
    [self.mTableView reloadData];
    
    if (self.portalModel.accessToken && self.portalModel.accessToken.length > 0){
        self.mTableView.allowsSelection = YES;
    }else{
        self.mTableView.allowsSelection = NO;
    }
}

-(void)loginBtnAction:(id)sender
{
    if (self.portalModel.accessToken && self.portalModel.accessToken.length > 0) {

        //TODO:登录
        
    }else{
        
        RegisterViewController *registVC = [[[RegisterViewController alloc] initWithNibName:@"RegisterViewController"
                                                                                     bundle:nil] autorelease];
        
        [self.navigationController pushViewController:registVC animated:YES];
    }
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
    
    if (self.portalModel.accessToken && self.portalModel.accessToken.length > 0){
        cell.textLabel.enabled = YES;
        cell.detailTextLabel.enabled = YES;
    }else{
        cell.textLabel.enabled = NO;
        cell.detailTextLabel.enabled = NO;
    }

    
    return cell ;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.portalModel.accessToken && self.portalModel.accessToken.length > 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        
        
    }
}

@end
