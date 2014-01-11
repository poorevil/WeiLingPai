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

#import "CycleScrollView.h"

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *portalArray;

@property (nonatomic,retain) CycleScrollView *cycleScrollView;//循环滚动scrollView
@property (nonatomic,retain) NSMutableArray *headerScrollViewArray;//轮播图数组

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.portalArray = [NSMutableArray array];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"portalList" ofType:@"plist"];
        NSArray *portalList = [[NSArray alloc] initWithContentsOfFile:plistPath];
        
        for (NSDictionary *dict in portalList) {
            PortalModel *model = [[[PortalModel alloc] initWithDictionary:dict] autorelease];
            
            [self.portalArray addObject:model];
        }
        
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.sliderViewParent = nil;
    
    [super dealloc];
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


@end
