//
//  GLAboutViewController.m
//  GetLucky
//
//  Created by Mert Buran on 02/03/15.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "GLAboutViewController.h"

static const CGFloat fixedMaskTextHeight = 100.f;

@interface GLAboutViewController()
@property (weak, nonatomic) IBOutlet UIImageView *fullScreenImageView;
@property (nonatomic, strong) CATextLayer *textMaskLayer;
@end

@implementation GLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandling:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.string = @"Mert Buran";
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.fontSize = 55.f;
    textLayer.contentsScale = [[UIScreen mainScreen] scale];
    textLayer.alignmentMode = kCAAlignmentCenter;
    self.fullScreenImageView.layer.mask = textLayer;
    self.textMaskLayer = textLayer;
}

- (void)swipeHandling:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
    CGPoint tapLocation = [recognizer locationInView:self.view];
    tapLocation.x -= 10.f;
    tapLocation.y -= 10.f;
    self.textMaskLayer.alignmentMode = kCAAlignmentLeft;
    CGRect frame = self.textMaskLayer.frame;
    frame.origin = tapLocation;
    self.textMaskLayer.frame = frame;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self centralizeMaskLayer];
}

- (void)centralizeMaskLayer {
    CGRect frame = CGRectMake(0.f, (self.fullScreenImageView.bounds.size.height-fixedMaskTextHeight)/2.f , self.fullScreenImageView.bounds.size.width, self.fullScreenImageView.bounds.size.height);
    self.textMaskLayer.frame = frame;
}

@end
