//
//  MainViewCell.m
//  WeiLingPai
//
//  Created by han chao on 14-1-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewCell.h"
#import "MainViewCellTileView.h"
#import "PortalModel.h"

@implementation MainViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    self.rightView.hidden = YES;
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLeftViewByProtal:(PortalModel *)model
{
    self.leftView.hidden = NO;
    MainViewCellTileView *tileView = [[[NSBundle mainBundle] loadNibNamed:@"MainViewCellTileView"
                                                                   owner:self
                                                                  options:nil] objectAtIndex:0];
    tileView.model = model;
    [self.leftView addSubview:tileView];
    
}

-(void)setRightViewByProtal:(PortalModel *)model
{
    self.rightView.hidden = NO;
    MainViewCellTileView *tileView = [[[NSBundle mainBundle] loadNibNamed:@"MainViewCellTileView"
                                                                    owner:self
                                                                  options:nil] objectAtIndex:0];
    tileView.model = model;
    [self.rightView addSubview:tileView];

}

-(void)dealloc
{
    self.leftView = nil;
    self.rightView = nil;
    
    [super dealloc];
}

@end
