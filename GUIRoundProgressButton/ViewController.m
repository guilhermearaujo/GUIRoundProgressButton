//
//  ViewController.m
//  GUIRoundProgressButton
//
//  Created by Guilherme Araújo on 26/04/15.
//  Copyright (c) 2015 Guilherme Araújo. All rights reserved.
//

#import "ViewController.h"
#import "GUIRoundProgressButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet GUIRoundProgressButton *buttonIB;

@end

@implementation ViewController

@synthesize buttonIB;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Configuring the button added via Interface Builder
  
  [buttonIB setBorderWidth:5.0f];
  [buttonIB setBorderColor:[UIColor colorWithWhite:1.0f alpha:0.7f]];
  [buttonIB setForegroundColor:[UIColor colorWithWhite:1.0f alpha:0.3f]];
  [buttonIB setTouchBorderColor:[UIColor whiteColor]];
  [buttonIB setTouchForegroundColor:[UIColor clearColor]];
  
  [buttonIB setImage:[UIImage imageNamed:@"octocat"]];
  [buttonIB setContentPadding:30];
  [buttonIB setActionBlock:^(GUIRoundProgressButton *weakButton) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [buttonIB finish];
    });
  }];
  
  // Adding the button programmatically
  
  GUIRoundProgressButton *button = [GUIRoundProgressButton buttonWithCenter:CGPointMake(375.0f / 2, 150.0f) radius:40.0f];
  [button setBorderWidth:2.0f];
  [button setBorderColor:[UIColor colorWithWhite:0.0f alpha:0.7f]];
  [button setForegroundColor:[UIColor colorWithWhite:1.0f alpha:0.5f]];
  [button setTouchBorderColor:[UIColor whiteColor]];
  [button setTouchForegroundColor:[UIColor colorWithRed:0.076 green:0.578 blue:0.128 alpha:1.000]];
  [button setProgressIndicatorColor:[UIColor colorWithRed:0.998 green:0.807 blue:0.098 alpha:1.000]];
  
  NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:48.0f],
                               NSForegroundColorAttributeName: [UIColor whiteColor]};
  NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"⚽️" attributes:attributes];
  [button setAttributedText:text];
  
  [button setActionBlock:^(GUIRoundProgressButton *weakButton) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [weakButton finish];
    });
  }];
  
  [self.view addSubview:button];
}

@end
