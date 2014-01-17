//
//  MainViewController.m
//  WeiLingPai
//
//  Created by hanchao on 14-1-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewController.h"
#import "PortalModel.h"
#import "MainViewCell.h"
#import "MainViewHeaderView.h"
#import "AFHTTPRequestOperationManager.h"
#import "CycleScrollView.h"
#import "PortalListResponseSerializer.h"
#import "GlobeModel.h"

#import "MBProgressHUD.h"

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@property (nonatomic,retain) NSMutableArray *portalArray;

@property (nonatomic,retain) CycleScrollView *cycleScrollView;//循环滚动scrollView
@property (nonatomic,retain) NSMutableArray *headerScrollViewArray;//轮播图数组

@property (nonatomic,retain) MBProgressHUD *hud;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.portalArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
	[self.navigationItem setTitle:@"微令牌"];
    self.sliderViewParent.backgroundColor = [UIColor blackColor];
    
    MainViewHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MainViewHeaderView"
                                                                   owner:self
                                                                  options:nil] objectAtIndex:0];
    [self.sliderViewParent addSubview:headerView];
    
    [self initPortalList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.sliderViewParent = nil;
    self.hud.delegate = nil;
    self.hud = nil;
    
    self.portalArray = nil;
    
    self.cycleScrollView = nil;//循环滚动scrollView
    self.headerScrollViewArray = nil;//轮播图数组
    
    [super dealloc];
}

#pragma mark - private method
//初始化portal list
-(void)initPortalList
{
    NSMutableArray *portalList = [[GlobeModel sharedSingleton] getPortalList];
    if(portalList!=nil && portalList.count>0)
    {
        self.portalArray = [NSMutableArray arrayWithArray:portalList];
    }else{
        //启动等待界面
        [self.hud hide:NO];
        self.hud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
        [self.view addSubview:self.hud];
        self.hud.dimBackground = YES;
        self.hud.delegate = self;
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.labelText = @"正在获取门户列表，请稍后...";
        [self.hud show:NO];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"appid": APP_ID,@"deviceId":[GlobeModel sharedSingleton].deviceId};
        manager.responseSerializer = [PortalListResponseSerializer serializer];
        [manager GET:[NSString stringWithFormat:@"%@/interface/portalList",BASEURL]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSLog(@"Success: %@", responseObject);
                 
                 if ([responseObject isKindOfClass:[NSArray class]]) {
                     self.portalArray = [NSMutableArray arrayWithArray:responseObject];
                     [[GlobeModel sharedSingleton] savePortalList:self.portalArray];
                     
                     [self.mTableView reloadData];
                 }
                 
                 [self.hud hide:YES];
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 //TODO:处理失败请求
                 
                 self.hud.labelText = @"获取门户列表失败!";
                 [self.hud hide:YES afterDelay:3];
             }];

    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (int)ceilf((float)self.portalArray.count / 2.0f);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    if (self.portalArray.count > indexPath.row * 2) {
        [cell setLeftViewByProtal:[self.portalArray objectAtIndex:indexPath.row*2]];
    }
    
    if (self.portalArray.count > (indexPath.row * 2 + 1)) {
        [cell setRightViewByProtal:[self.portalArray objectAtIndex:indexPath.row*2+1]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [self.hud removeFromSuperview];
}

@end
