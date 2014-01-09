//
//  MainViewHeaderView.h
//  WeiLingPai
//
//  Created by han chao on 14-1-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CycleScrollView.h"

@interface MainViewHeaderView : UIView

@property (nonatomic,retain) CycleScrollView *cycleScrollView;//循环滚动scrollView
@property (nonatomic,retain) NSMutableArray *headerScrollViewArray;//轮播图数组

@property (nonatomic,retain) IBOutlet UIView *titleBgView;
@property (nonatomic,retain) IBOutlet UILabel *slideShowTitleLabel;

@property (nonatomic,assign) NSInteger currPageNum;

@property (nonatomic,retain) NSMutableArray *sliderList;

@end
