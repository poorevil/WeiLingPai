//
//  RegisterViewController.m
//  WeiLingPai
//
//  Created by han chao on 14-1-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "RegisterViewController.h"
#import <ZXingWidgetController.h>
#import <QRCodeReader.h>
#import "AFHTTPRequestOperationManager.h"

@interface RegisterViewController ()<ZXingDelegate>

@end

@implementation RegisterViewController

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
    
    [self initBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.mtableView = nil;
    self.scanQRCodeBtn = nil;
    
    [super dealloc];
}

#pragma mark - private method
// 初始化登录按钮
-(void)initBtn
{
    [self.scanQRCodeBtn setTitle:@"扫描二维码" forState:UIControlStateNormal];
//    self.loginLabel.text = @"通过扫描页面上的二维码绑定账号";
    
    // the space between the image and text
    CGFloat spacing = 6.0;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = self.scanQRCodeBtn.imageView.frame.size;
    self.scanQRCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0,
                                                     - imageSize.width,
                                                     - (imageSize.height + spacing),
                                                     0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = self.scanQRCodeBtn.titleLabel.frame.size;
    self.scanQRCodeBtn.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing),
                                                     0.0,
                                                     0.0,
                                                     - titleSize.width);
    
    [self.scanQRCodeBtn addTarget:self
                      action:@selector(loginBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
}

-(void)loginBtnAction:(id)sender
{
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
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"其他绑定方式";
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
            cell.textLabel.text = @"手机号码";
            cell.detailTextLabel.text = @"通过手机号码绑定账号";
            cell.imageView.image = [UIImage imageNamed:@"detail_tableviewcell_lock"];
            break;
        case 1:
            cell.textLabel.text = @"内网账号";
            cell.detailTextLabel.text = @"通过内网账号绑定账号";
            cell.imageView.image = [UIImage imageNamed:@"detail_tableviewcell_power"];
            break;
    }
    
    return cell ;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    //TODO:跳转页面
    
//    switch (indexPath.row) {
//        case 0:
//            //TODO:手机号码
//            break;
//        case 1:
//            //TODO:内网账号
//            break;
//    }
    
}

#pragma mark - ZXingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result
{
    NSLog(@"result:%@",result);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"deviceId": @"deviceId111",@"portalId":@"zgdx",@"uuid":result};
    
    [manager POST:[NSString stringWithFormat:@"%@/regist/clientRegist",BASEURL] parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              //{"regist_result":200,"msg":"go to login page"}
              NSLog(@"Success: %@", responseObject);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
{
    [controller dismissViewControllerAnimated:NO completion:nil];
}


@end
