//
//  MainViewCellTileView.m
//  WeiLingPai
//
//  Created by han chao on 14-1-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewCellTileView.h"


@implementation MainViewCellTileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setModel:(PortalModel *)model
{
    [_model release];
    _model = nil;
    _model = [model retain];
    
    //TODO:
}

-(void)dealloc
{
    self.model = nil;
    [super dealloc];
}

@end
