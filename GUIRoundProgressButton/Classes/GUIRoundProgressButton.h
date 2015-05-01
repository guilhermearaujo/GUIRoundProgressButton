//
//  GUIRoundProgressButton.h
//  GUIRoundProgressButton
//
//  Created by Guilherme Araújo on 26/04/15.
//  Copyright (c) 2015 Guilherme Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GUIRoundProgressButton : UIControl

@property (assign, nonatomic) CGFloat contentPadding;
@property (assign, nonatomic) CGFloat borderWidth;
@property (strong, nonatomic) UIColor *borderColor;
@property (strong, nonatomic) UIColor *touchBorderColor;

@property (strong, nonatomic) UIColor *foregroundColor;
@property (strong, nonatomic) UIColor *touchForegroundColor;

@property (strong, nonatomic) UIColor *progressIndicatorColor;

@property (copy, nonatomic) void (^actionBlock)(GUIRoundProgressButton *weakButton);

+ (instancetype)buttonWithCenter:(CGPoint)center radius:(CGFloat)radius;

- (void)setText:(NSString *)text;
- (void)setAttributedText:(NSAttributedString *)text;
- (void)setImage:(UIImage *)image;

- (void)finish;

@end
