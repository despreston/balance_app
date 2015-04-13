//
//  BANavigationController.m
//  Balance
//
//  Created by Desmond Preston on 4/10/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "BANavigationController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation BANavigationController

- (void)viewDidLoad {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x333333)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor],
      NSForegroundColorAttributeName,
      [UIColor whiteColor],
      NSForegroundColorAttributeName,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Helvetica Neue Medium" size:0.0],
      NSFontAttributeName,
      nil]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [super viewDidLoad];
}

@end
