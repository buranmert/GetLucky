//
//  GLAboutViewController.m
//  GetLucky
//
//  Created by Mert Buran on 02/03/15.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "GLAboutViewController.h"

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
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.string = @"Mert Buran";
    CGRect frame = CGRectZero;
    frame.origin = CGPointMake((self.fullScreenImageView.bounds.size.width - textLayer.bounds.size.width)/2.f, (self.fullScreenImageView.bounds.size.height - textLayer.bounds.size.height)/2.f);
    frame.size = self.fullScreenImageView.bounds.size;
    textLayer.frame = frame;
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self maskImageView];
}

- (void)maskImageView {
        CGRect frame = CGRectZero;
        frame.origin = CGPointMake((self.fullScreenImageView.bounds.size.width - self.textMaskLayer.bounds.size.width)/2.f, (self.fullScreenImageView.bounds.size.height - self.textMaskLayer.bounds.size.height)/2.f);
        frame.size = self.fullScreenImageView.bounds.size;
        self.textMaskLayer.frame = frame;
}

@end
