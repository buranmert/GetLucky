//
//  GLSlidingLabel.m
//  GetLucky
//
//  Created by Mert Buran on 02/03/15.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "GLSlidingLabel.h"

@interface GLSlidingLabel ()
@property (nonatomic, weak) UILabel *textLabel;
@end

@implementation GLSlidingLabel

- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText {
    self = [super init];
    if (self != nil) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _isSliding = NO;
        //http://stackoverflow.com/a/8056260/1515075 says do not use self.propertyName
        UILabel *textLabel = [[UILabel alloc] init];
        [textLabel setNumberOfLines:1];
        [textLabel setAttributedText:attributedText];
        [textLabel sizeToFit];
        CGRect bounds = CGRectMake(0.f, 0.f, width, CGRectGetHeight(textLabel.bounds));
        self.bounds = bounds;
        [self addSubview:textLabel];
        _textLabel = textLabel;
    }
    return self;
}

- (void)stopAnimating {
    if (_isSliding) {
        _isSliding = NO;
        [self.textLabel.layer removeAllAnimations]; //ends animation too roughly
    }
}

- (void)startAnimatingWithDuration:(CGFloat)duration {
    if (CGRectGetWidth(self.textLabel.bounds) > CGRectGetWidth(self.bounds)) {
        _isSliding = YES;
        CGFloat selfWidth = CGRectGetWidth(self.bounds);
        UILabel *animatingLabel = self.textLabel;
        [UIView animateWithDuration:duration
                              delay:0.f
                            options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             CGRect frame = animatingLabel.frame;
                             frame.origin.x = -CGRectGetWidth(animatingLabel.bounds);
                             [animatingLabel setFrame:frame];
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 CGRect frame = animatingLabel.frame;
                                 frame.origin.x = selfWidth;
                                 [animatingLabel setFrame:frame];
                                 [UIView animateWithDuration:duration
                                                       delay:0.f
                                                     options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear
                                                  animations:^{
                                                      CGRect frame = animatingLabel.frame;
                                                      frame.origin.x = -CGRectGetWidth(animatingLabel.bounds);
                                                      [animatingLabel setFrame:frame];
                                                  } completion:nil];
                             }
                         }];
    }
}

@end
