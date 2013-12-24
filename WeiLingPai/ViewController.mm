//
//  ViewController.m
//  WeiLingPai
//
//  Created by han chao on 13-12-22.
//  Copyright (c) 2013年 evil. All rights reserved.
//

#import "ViewController.h"

#import <ZXingWidgetController.h>
#import <QRCodeReader.h>

#import "AFHTTPRequestOperationManager.h"

@interface ViewController () <ZXingDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"scan qr code" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 200, 30);
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(scanPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scanPressed:(id)sender {
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
    NSDictionary *parameters = @{@"username": @"evil",@"pwd":@"evil",@"uuid":result};
    
    [manager POST:[NSString stringWithFormat:@"%@/clientLogin",BASEURL] parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"Success: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
