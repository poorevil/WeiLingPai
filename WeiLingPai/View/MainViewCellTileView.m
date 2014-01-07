//
//  MainViewCellTileView.m
//  WeiLingPai
//
//  Created by han chao on 14-1-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewCellTileView.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "PortalDetailViewController.h"

@interface MainViewCellTileView()

@property (nonatomic,retain) CALayer *selectLayer;

@end

@implementation MainViewCellTileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    self.selectLayer = [CALayer layer];
    self.selectLayer.frame = self.frame;
    self.selectLayer.backgroundColor = [[UIColor colorWithRed:0
                                                        green:0
                                                         blue:0
                                                        alpha:0.3f]
                                        CGColor];
    self.selectLayer.hidden = YES;
    [self.layer addSublayer:self.selectLayer];
}

-(void)setModel:(PortalModel *)model
{
    [_model release];
    _model = nil;
    _model = [model retain];
    
    for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
        [self removeGestureRecognizer:recognizer];
    }
    
    UIGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapAction];
    [tapAction release];
    
    [self.iconView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]
                                                              pathForResource:self.model.iconFileName
                                                              ofType:@"png"]]];
    if (self.model.lastLogin>0) {
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd";
        
        self.lastLoginLabel.text = [NSString stringWithFormat:@"上次登录时间:%@",
                                    [df stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.model.lastLogin]]];
        [df release];
        
    }else{
        self.lastLoginLabel.text = @"从未登录";
    }
    
}

-(void)tapAction:(UIGestureRecognizer *)sender
{
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    
    PortalDetailViewController *pdvc = [[[PortalDetailViewController alloc] initWithNibName:@"PortalDetailViewController"
                                                                                     bundle:nil] autorelease];
    pdvc.portalModel = self.model;
    
    [appdelegate.mainViewController.navigationController pushViewController:pdvc
                                                                   animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [super touchesBegan:touches withEvent:event];
    
    self.selectLayer.hidden = NO;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [super touchesEnded:touches withEvent:event];
    self.selectLayer.hidden = YES;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event\
{
//    [super touchesCancelled:touches withEvent:event];
    self.selectLayer.hidden = YES;
}

-(void)dealloc
{
    self.model = nil;
    
    self.lastLoginLabel = nil;
    self.iconView = nil;
    
    [super dealloc];
}

@end
