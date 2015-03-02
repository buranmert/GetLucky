//
//  GLSlidingLabel.h
//  GetLucky
//
//  Created by Mert Buran on 02/03/15.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLSlidingLabel : UIView
- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText;
- (void)startAnimatingWithDuration:(CGFloat)duration;
- (void)stopAnimating;
@property (nonatomic, readonly) BOOL isSliding;
@end
