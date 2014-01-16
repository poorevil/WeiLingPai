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
#import <ZXingWidgetController.h>
#import <QRCodeReader.h>
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"

#pragma mark - WaitRegistResult
@protocol WaitRegistResultDelegate <NSObject>

-(void)requestRegistResultDidFinished:(NSDictionary *)jsonDict;
-(void)requestRegistResultDidFailed:(NSError *)error;

@end

@interface WaitRegistResult : NSObject

@property (nonatomic,copy) NSString *uuid;
@property (nonatomic,assign) id<WaitRegistResultDelegate> delegate;

@property (nonatomic,assign) WaitRegistResult *bself;

-(void)requestRegistResultByUUID:(NSString *)uuid;

@end

@implementation WaitRegistResult

//等待账号绑定结果
-(void)requestRegistResultByUUID:(NSString *)uuid
{
    self.uuid = uuid;
    
//    __block typeof(self) bself = self;
    self.bself = self;
//    __block NSString *uuid_block = self.uuid;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/regist/clientTestRegistResult/%@/",BASEURL,self.uuid] parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.bself.delegate requestRegistResultDidFinished:responseObject];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self.bself.delegate requestRegistResultDidFailed:error];
         }];
}

-(void)dealloc
{
    self.bself = nil;
    self.uuid = nil;
    [super dealloc];
}

@end


#pragma mark - PortalDetailViewController
@interface PortalDetailViewController () <UITableViewDataSource,UITableViewDelegate,ZXingDelegate,
MBProgressHUDDelegate, WaitRegistResultDelegate>{
    BOOL _isLogined;//是否已登录成功
}

@property (nonatomic, retain) NSString *uuid;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) WaitRegistResult *waitRegistResult;

@end

@implementation PortalDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isLogined = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initLoginBtn];
    [self updateDateAndState];
    
    self.title = self.portalModel.name;
    
    UIBarButtonItem *backBtnItem = [[[UIBarButtonItem alloc] initWithTitle:@"< 返回"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(navBackBtnAction:)] autorelease];
    
    [self.navigationItem setLeftBarButtonItem:backBtnItem];
    
    self.waitRegistResult = [[[WaitRegistResult alloc] init] autorelease];
    self.waitRegistResult.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
//    NSLog(@"========dealloc=========");
    
    self.waitRegistResult.delegate = nil;
    self.waitRegistResult = nil;
    
    self.uuid = nil;
    
    self.loginBtn = nil;
    self.mTableView = nil;
    self.loginLabel = nil;
    self.hud.delegate = nil;
    self.hud = nil;
    
    [super dealloc];
}

#pragma mark - private method

// 初始化登录按钮
-(void)initLoginBtn
{
    if(!_isLogined){//未登录
        //存在accesstoken，登录按钮
        if (self.portalModel.accessToken && self.portalModel.accessToken.length>0) {
            [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            self.loginLabel.text = @"扫描网页上的二维码进行登录";
        }else{
            //不存在accesstoken，绑定账号按钮
            [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];//绑定账号
            self.loginLabel.text = @"首次登录需要进行账号绑定";
        }
        
    }else{
        //TODO:已登录成功
        [self.loginBtn setTitle:@"登出" forState:UIControlStateNormal];
        self.loginLabel.text = @"点击登出按钮退出登录";
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

-(void)navBackBtnAction:(id)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.navigationController popViewControllerAnimated:YES];
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
//    if (self.portalModel.accessToken && self.portalModel.accessToken.length > 0) {
//
//        //TODO:登录
//        
//    }else{
//        
//        RegisterViewController *registVC = [[[RegisterViewController alloc] initWithNibName:@"RegisterViewController"
//                                                                                     bundle:nil] autorelease];
//        
//        [self.navigationController pushViewController:registVC animated:YES];
//    }
    
    //未登录
    if(!_isLogined){
    
        //二维码
        ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
        NSMutableSet *readers = [[NSMutableSet alloc ] init];
        QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
        [readers addObject:qrcodeReader];
        [qrcodeReader release];
        widController.readers = readers;
        [readers release];
        [self presentViewController:widController animated:YES completion:nil];
        [widController release];
        
    }else{
        //TODO:已登录
        
    }
}

//等待账号绑定结果
-(void)requestRegistResult
{
    [self.waitRegistResult requestRegistResultByUUID:self.uuid];
}

#pragma mark - WaitRegistResultDelegate

-(void)requestRegistResultDidFinished:(NSDictionary *)jsonDict
{
    //绑定成功
    //{"result_code":208,"msg":"regist succeed！！！","accessToken":"%s"}
    if(jsonDict && [[jsonDict objectForKey:@"result_code"] integerValue] == 208){
        //提示登录成功
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"登录成功"
                                                   delegate:nil
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:nil];
        [alert show];
        [alert release];

        _isLogined = YES;
        
        [self.hud hide:YES];
        
        //保存accessToken
        NSString *accessToken = [jsonDict objectForKey:@"accessToken"];
        self.portalModel.accessToken = accessToken;
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"portalList" ofType:@"plist"];
        NSMutableDictionary *portalList = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        for(NSMutableDictionary *dict in portalList){
            if([self.portalModel.pid isEqualToString:[dict objectForKey:@"pid"]]){
                [dict setValue:accessToken forKey:@"accessToken"];
            }
        }
        //保存到plist中
        [portalList writeToFile:plistPath atomically:NO];
        
        
        //更新登录按钮状态
        [self initLoginBtn];
        
    }else{

        [self performSelector:@selector(requestRegistResult) withObject:nil afterDelay:1];//1秒后继续尝试
    }

}

-(void)requestRegistResultDidFailed:(NSError *)error
{
    NSLog(@"Error: %@", error);
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

#pragma mark - ZXingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result
{
    NSLog(@"result:%@",result);
    self.uuid = result;
    
    if (self.portalModel.accessToken && self.portalModel.accessToken.length > 0) {

        //TODO:登录
        
        
        
    }else{
        //TODO:账号绑定
        
        //提交二维码内容，账号绑定第一步
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"deviceId": @"deviceId111",//TODO:生成设备唯一标识
                                     @"portalId":@"1",
                                     @"uuid":self.uuid};

        [manager POST:[NSString stringWithFormat:@"%@/regist/clientRegist",BASEURL] parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  //{"regist_result":200,"msg":"go to login page"}
                  NSLog(@"Success: %@", responseObject);

              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
              }];
        
        //启动绑定结果监听功能，等待获取绑定结果
        [self requestRegistResult];
        
        //启动等待界面
        [self.hud hide:NO];
        self.hud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
        [self.view addSubview:self.hud];
        self.hud.dimBackground = YES;
        self.hud.delegate = self;
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.labelText = @"登录中，请注意网页内容变化";
        [self.hud show:NO];
    
    }

    [controller dismissViewControllerAnimated:NO completion:nil];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
{
    [controller dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
	[self.hud removeFromSuperview];
}

@end
