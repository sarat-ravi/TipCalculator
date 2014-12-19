//
//  BaseViewController.m
//  tipcalculator
//
//  Created by Sarat Tallamraju on 12/18/14.
//  Copyright (c) 2014 sarattallamraju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewDidLoad
{
    NSLog(@"BaseViewController: viewDidLoad");
    [super viewDidLoad];
    [self setBackgroundGradient];
}

-(void)setBackgroundGradient {
    // UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    UIView *view = self.view;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    UIColor *bottomColor = [UIColor colorWithRed:0.10 green:0.64 blue:0.61 alpha:1.0];
    UIColor *topColor = [UIColor colorWithRed:0.30 green:0.47 blue:0.75 alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    // gradient.colors = [NSArray arrayWithObjects:(id)topColor, (id)bottomColor, nil];
    [view.layer insertSublayer:gradient atIndex:0];
}

@end