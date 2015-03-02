//
//  GLLottoBallView.m
//  GetLucky
//
//  Created by Mert Buran on 02/03/15.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "GLLottoBallView.h"

static const CGFloat fixedDiameter = 65.f;

@interface GLLottoBallView ()
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation GLLottoBallView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, fixedDiameter, fixedDiameter)];
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, fixedDiameter, fixedDiameter)];
    [self prepareCircleView];
    [self prepareNumberLabel];
    
    [self addSubview:self.circleView];
    [self addSubview:self.numberLabel];
}

- (void)prepareCircleView {
    [self.circleView setBackgroundColor:[UIColor blueColor]];
    [self.circleView.layer setCornerRadius:[self maxDiameter]/2.f];
}

- (void)prepareNumberLabel {
    [self.numberLabel setBackgroundColor:[UIColor clearColor]];
    [self.numberLabel setTextColor:[UIColor whiteColor]];
    [self.numberLabel setTextAlignment:NSTextAlignmentCenter];
    UIFont *currentFont = self.numberLabel.font;
    [self.numberLabel setFont:[UIFont fontWithName:currentFont.familyName size:44.f]];
    [self.numberLabel setMinimumScaleFactor:0.1f];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat newDiameter = [self maxDiameter];
    CGRect centralizedFrame = CGRectMake((width-newDiameter)/2.f, (height-newDiameter)/2.f, newDiameter, newDiameter);
    [self.circleView setFrame:centralizedFrame];
    [self.numberLabel setFrame:centralizedFrame];
}

- (CGFloat)maxDiameter {
    return MIN(MIN(self.bounds.size.height, self.bounds.size.width), fixedDiameter);
}

+ (UIColor *)normalTextColor {
    return [UIColor whiteColor];
}

+ (UIColor *)inAnimationTextColor {
    return [UIColor redColor];
}

- (void)setNumber:(NSUInteger)newNumber animationDuration:(double)animDuration withCompletionHandler:(void (^)(void))completion {
    __weak typeof(self) weakSelf = self;
    self.numberLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)newNumber];
    [self.numberLabel setTextColor:[GLLottoBallView inAnimationTextColor]];
    [self.numberLabel.layer setZPosition:[self maxDiameter]];
    
    CATransform3D firstCircleTransform = CATransform3DMakeRotation(M_PI, 0.f, 0.5f, 0.f);
    CATransform3D lastCircleTransform = CATransform3DMakeRotation(0.f, 0.f, 0.5f, 0.f);
    CATransform3D firstNumberTransform = CATransform3DMakeScale(0.25f, 0.25f, 0.25f);
    CATransform3D lastNumberTransform = CATransform3DMakeScale(1.f, 1.f, 1.f);
    
    [UIView animateWithDuration:animDuration/2.0
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         weakSelf.circleView.layer.transform = firstCircleTransform;
                         weakSelf.numberLabel.layer.transform = firstNumberTransform;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:animDuration/2.0
                                               delay:0.f
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              weakSelf.circleView.layer.transform = lastCircleTransform;
                                              weakSelf.numberLabel.layer.transform = lastNumberTransform;
                                          }
                                          completion:^(BOOL finished) {
                                              [weakSelf.numberLabel setTextColor:[GLLottoBallView normalTextColor]];
                                              if (completion != nil) {
                                                  completion();
                                              }
                                          }];
                     }];
}

@end
