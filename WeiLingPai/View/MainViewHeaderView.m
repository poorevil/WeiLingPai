//
//  MainViewHeaderView.m
//  WeiLingPai
//
//  Created by han chao on 14-1-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewHeaderView.h"
#import "AFHTTPRequestOperationManager.h"
#import "SliderResponseSerializer.h"
#import "SliderModel.h"
#import "EGOImageView.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "SVWebViewController.h"

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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"appid": APP_ID};
    manager.responseSerializer = [SliderResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"%@/sliderList",BASEURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"Success: %@", [responseObject class]);
             
             if ([responseObject isKindOfClass:[NSArray class]]) {
                 self.sliderList = [NSMutableArray arrayWithArray:responseObject];
                 
                 if (self.sliderList.count>0) {
                     [self.cycleScrollView removeFromSuperview];
                     self.cycleScrollView = nil;
                     self.headerScrollViewArray = [NSMutableArray array];
                     
                     //初始化轮播数组内容
                     for (int i=0;i<self.sliderList.count;i++) {
                         SliderModel *model = [self.sliderList objectAtIndex:i];
                         //创建首页轮播图item
                         EGOImageView *imageView = [[EGOImageView alloc]
                                                    initWithFrame:CGRectMake(0,0
                                                                             , self.frame.size.width
                                                                             , self.frame.size.width)];
                         imageView.contentMode = UIViewContentModeScaleToFill;
                         
                         imageView.imageURL = [NSURL URLWithString:model.imageUrl];
                         imageView.userInteractionEnabled = YES;
                         
                         //添加点击事件
                         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(showDetail:)];
                         [imageView addGestureRecognizer:tap];
                         [tap release];
                         
                         
                         
                         [self.headerScrollViewArray addObject:imageView];
                         [imageView release];
                     }
                     
                     self.cycleScrollView = [[[CycleScrollView alloc]
                                              initWithFrame:CGRectMake(0, 0, 320, 320)
                                              cycleDirection:CycleDirectionLandscape
                                              views:self.headerScrollViewArray] autorelease];
                     self.cycleScrollView.delegate = self;
                     [self insertSubview:self.cycleScrollView
                            belowSubview:self.titleBgView];
                     
                     self.slideShowTitleLabel.text = [[self.sliderList objectAtIndex:0] title];
                     
                     
                     [self showAutoPlay];
                     
                 }
                 
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
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
    SliderModel *model = [self.sliderList objectAtIndex:self.currPageNum];
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UINavigationController *currentController = (UINavigationController *)mainDelegate.mainViewController.navigationController;
    
    NSURL *URL = [NSURL URLWithString:model.openUrl];
    
    SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithURL:URL] autorelease];
    
    [currentController pushViewController:webViewController animated:YES];
    
}

@end
