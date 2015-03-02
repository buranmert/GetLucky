//
//  ViewController.m
//  GetLucky
//
//  Created by Mert Buran on 02/03/15.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "GLMainViewController.h"
#import "GLLottoBallView.h"

static const NSUInteger upperBound = 40;
static const NSUInteger numberOfBalls = 5;
static const double longPressDuration = 0.7;
static const double shufflingAnimationDuration = 1.4;

@interface GLMainViewController ()
@property (weak, nonatomic) IBOutlet UIView *longPressView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic) BOOL isShufflingDone;
@end

@implementation GLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self.longPressView addGestureRecognizer:longPressGesture];
    self.isShufflingDone = YES;
}

- (void)longPressed:(UILongPressGestureRecognizer *)recognizer {
    UIView *longPressView = self.longPressView;
    if (recognizer.state == UIGestureRecognizerStateBegan && self.isShufflingDone) {
        [UIView animateWithDuration:longPressDuration
                              delay:0.f
                            options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             longPressView.backgroundColor = [GLMainViewController activeAreaColor];
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [self randomiseLottoBalls];
                             }
                         }];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:longPressDuration/2.0
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             longPressView.backgroundColor = [GLMainViewController idleAreaColor];
                         }
                         completion:nil];
    }
}

- (void)randomiseLottoBalls {
    double animDuration = shufflingAnimationDuration;
    for (NSInteger i = 1; i <= numberOfBalls; i++) {
        NSInteger tag = 11*i;
        GLLottoBallView *lottoBallView = (GLLottoBallView *)[self.view viewWithTag:tag];
        if (i == numberOfBalls) {
            self.isShufflingDone = NO;
            __weak typeof(self) weakSelf = self;
            [lottoBallView setNumber:(arc4random_uniform(upperBound)+1) animationDuration:animDuration withCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Moment Of Truth" message:@"Are you a billionaire now??!" delegate:self cancelButtonTitle:@"Maybe, next time :(" otherButtonTitles:@"WOOOUHOOOOO!!!", nil];
                    [av show];
                    weakSelf.isShufflingDone = YES;
                });
            }];
        }
        else {
            [lottoBallView setNumber:(arc4random_uniform(upperBound)+1) animationDuration:animDuration withCompletionHandler:nil];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        self.resultLabel.text = @":(";
    }
    else {
        self.resultLabel.text = @":)";
    }
}

+ (UIColor *)idleAreaColor {
    return [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
}

+ (UIColor *)activeAreaColor {
    return [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:1.f];
}

@end
