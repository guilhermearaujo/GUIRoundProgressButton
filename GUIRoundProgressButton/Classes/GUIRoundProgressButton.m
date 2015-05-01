//
//  GUIRoundProgressButton.m
//  GUIRoundProgressButton
//
//  Created by Guilherme Araújo on 26/04/15.
//  Copyright (c) 2015 Guilherme Araújo. All rights reserved.
//

#import "GUIRoundProgressButton.h"

@interface GUIRoundProgressButton ()

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIActivityIndicatorView *progressIndicator;

@end

@implementation GUIRoundProgressButton

+ (instancetype)buttonWithCenter:(CGPoint)center radius:(CGFloat)radius {
  CGRect frame = CGRectMake(center.x - radius, center.y - radius, radius * 2.0f, radius * 2.0f);
  
  GUIRoundProgressButton *button = [[super alloc] initWithFrame:frame];
  
  return button;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  [self setupWithRadius:MAX(CGRectGetWidth(frame), CGRectGetHeight(frame)) / 2.0f];
  
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  [self setupWithRadius:MAX(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) / 2.0f];
  
  return self;
}

- (void)setupWithRadius:(CGFloat)radius {
  [self setClipsToBounds:YES];
  [self.layer setCornerRadius:radius];
  
  [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
  [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
  [self addTarget:self action:@selector(touchDragExit) forControlEvents:UIControlEventTouchDragExit];
}

#pragma mark - Visual Customization

- (void)setBorderWidth:(CGFloat)borderWidth {
  _borderWidth = borderWidth;
  
  [self.layer setBorderWidth:borderWidth];
}

- (void)setBorderColor:(UIColor *)borderColor {
  _borderColor = borderColor;
  
  [self.layer setBorderColor:[borderColor CGColor]];
}

- (void)setForegroundColor:(UIColor *)foregroundColor {
  _foregroundColor = foregroundColor;
  
  [self setBackgroundColor:foregroundColor];
}

- (void)setProgressIndicatorColor:(UIColor *)progressIndicatorColor {
  _progressIndicatorColor = progressIndicatorColor;
  
  if (self.progressIndicator) {
    [self.progressIndicator setColor:progressIndicatorColor];
  }
}

- (void)setText:(NSString *)text {
  [self setAttributedText:[[NSAttributedString alloc] initWithString:text]];
}

- (void)setAttributedText:(NSAttributedString *)text {
  if (self.textLabel == nil) {
    self.textLabel = [[UILabel alloc] initWithFrame:[self frameWithoutBorder]];
    [self addSubview:self.textLabel];
  }
  
  NSMutableAttributedString *centeredText = [text mutableCopy];
  
  NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
  [paragraph setAlignment:NSTextAlignmentCenter];
  [centeredText addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, [text length])];
  [self.textLabel setAttributedText:centeredText];
  
  [self.textLabel setHidden:NO];
  
  if (self.imageView) {
    [self.imageView setHidden:YES];
  }
}

- (void)setImage:(UIImage *)image {
  if (self.imageView == nil) {
    self.imageView = [[UIImageView alloc] initWithFrame:[self frameWithoutBorder]];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.imageView];
  }
  
  [self.imageView setImage:image];
  [self.imageView setHidden:NO];
  
  if (self.textLabel) {
    [self.textLabel setHidden:YES];
  }
}

#pragma mark - Event Control

- (void)touchDown {
  [UIView animateWithDuration:0.5f
                   animations:^{
                     [self setBackgroundColor:self.touchForegroundColor];
                     [self.layer setBorderColor:[self.touchBorderColor CGColor]];
                   }];
  
}

- (void)touchUpInside {
  if (self.progressIndicator == nil) {
    self.progressIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.progressIndicator setFrame:self.bounds];
    [self.progressIndicator setColor:self.progressIndicatorColor];
    [self addSubview:self.progressIndicator];
  }
  [self.progressIndicator setAlpha:0.0f];
  [self.progressIndicator startAnimating];
  
  [UIView animateWithDuration:0.5f
                   animations:^{
                     if (self.textLabel) {
                       [self.textLabel setAlpha:0.0f];
                     }
                     
                     if (self.imageView) {
                       [self.imageView setAlpha:0.0f];
                     }
                     
                     [self.progressIndicator setAlpha:1.0f];
                   } completion:^(BOOL finished) {
                     [self setEnabled:NO];
                   }];
  
  if (self.actionBlock) {
    self.actionBlock(self);
  }
}

- (void)touchDragExit {
  [UIView animateWithDuration:0.5f
                   animations:^{
                     [self setBackgroundColor:self.foregroundColor];
                     [self.layer setBorderColor:[self.borderColor CGColor]];
                   }];
}

- (void)finish {
  [UIView animateWithDuration:0.5f
                   animations:^{
                     [self setBackgroundColor:self.foregroundColor];
                     [self.layer setBorderColor:[self.borderColor CGColor]];
                     
                     if (self.textLabel) {
                       [self.textLabel setAlpha:1.0f];
                     }
                     
                     if (self.imageView) {
                       [self.imageView setAlpha:1.0f];
                     }
                     
                     [self.progressIndicator setAlpha:0.0f];
                   } completion:^(BOOL finished) {
                     [self.progressIndicator stopAnimating];
                     [self setEnabled:YES];
                   }];
}

- (CGRect)frameWithoutBorder {
  // Removes the border width plus 20% for padding
  CGRect frame = self.bounds;
  frame.origin.x += self.borderWidth * 1.2f;
  frame.origin.y += self.borderWidth * 1.2f;
  frame.size.width -= 2.4f * self.borderWidth;
  frame.size.height -= 2.4f * self.borderWidth;
  return frame;
}

@end
