//
//  GLLottoBallView.h
//  GetLucky
//
//  Created by Mert Buran on 02/03/15.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLLottoBallView : UIView
- (void)setNumber:(NSUInteger)newNumber animationDuration:(double)animDuration withCompletionHandler:(void (^)(void))completion;
@end
