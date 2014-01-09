//
//  MainViewHeaderView.m
//  WeiLingPai
//
//  Created by han chao on 14-1-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewHeaderView.h"

@implementation MainViewHeaderView

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
    self.userInteractionEnabled = YES;
    
    self.titleBgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.titleBgView.layer.shadowOpacity = 0.58;
    
//    // shadow
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    
//    CGPoint topLeft      = CGPointMake(0.0, 6.0);//self.bgView.bounds.origin;
//    CGPoint bottomLeft   = CGPointMake(0.0, CGRectGetHeight(self.titleBgView.bounds)+3);
//    CGPoint bottomRight  = CGPointMake(CGRectGetWidth(self.titleBgView.bounds)+6, CGRectGetHeight(self.titleBgView.bounds)+3);
//    CGPoint topRight     = CGPointMake(CGRectGetWidth(self.titleBgView.bounds)+6, 6.0);
//    
//    [path moveToPoint:topLeft];
//    [path addLineToPoint:bottomLeft];
//    [path addLineToPoint:bottomRight];
//    [path addLineToPoint:topRight];
//    [path addLineToPoint:topLeft];
//    [path closePath];
//    
//    self.titleBgView.layer.shadowPath = path.CGPath;
//    
//    self.titleBgView.alpha = 0;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)showAutoPlay
{
    [self.cycleScrollView showNextPage];
    [self performSelector:@selector(showAutoPlay) withObject:nil afterDelay:3];
}

#pragma mark - CycleScrollViewDelegate method
- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didScrollView:(int)index
{
    if (self.currPageNum != (index - 1)) {
        self.currPageNum = (index -1);
        
        //    self.slideShowPageControl.currentPage = index-1;
        [UIView animateWithDuration:0.1
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
         | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.slideShowTitleLabel.alpha = 0;
                         } completion:^(BOOL finished) {
                             
                             if (finished) {
                                 [UIView animateWithDuration:0.1
                                                       delay:0
                                                     options:UIViewAnimationOptionBeginFromCurrentState
                                  | UIViewAnimationCurveEaseInOut
                                                  animations:^{
                                                      self.slideShowTitleLabel.text
                                                      = [[self.sliderList objectAtIndex:index-1] title];
                                                      self.slideShowTitleLabel.alpha = 1;
                                                  } completion:nil];
                             }
                             
                         }];
    }
    
}

-(void)dealloc
{
    
    self.cycleScrollView = nil;
    
    self.slideShowTitleLabel = nil;
    self.sliderList = nil;
    self.headerScrollViewArray = nil;
    self.titleBgView = nil;
    
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    UIView *highlightDot = [[UIView alloc] initWithFrame:CGRectMake(point.x - 25
                                                                    , point.y - 25
                                                                    , 50, 50)];
    highlightDot.clipsToBounds = YES;
    
    //    [highlightDot setBackgroundColor:[UIColor grayColor]];
    [highlightDot setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"highlight_dot" ofType:@"png"]]]];
    
    
    highlightDot.layer.cornerRadius = 10;
    [self addSubview:highlightDot];
    
    [highlightDot release];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         highlightDot.alpha = 0;
                     } completion:^(BOOL finished) {
                         [highlightDot removeFromSuperview];
                     }];
    
}

-(void)showDetail:(UITapGestureRecognizer *)sender
{
//    TaobaokeItemModel *model = [self.taobaokeItemArray objectAtIndex:self.currPageNum];
//    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    UINavigationController *currentController = (UINavigationController *)mainDelegate.tabBarController.selectedViewController;
//    
//    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&ttid=400000_21125417@txx_iPhone_0.0.0"
//                                       , model.clickUrl]];
//    
//    SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithURL:URL
//                                                                            thumbImage:[(EGOImageView *)sender.view image]
//                                                                                 title:model.title] autorelease];
//    
//    [currentController pushViewController:webViewController animated:YES];
    
}

@end
