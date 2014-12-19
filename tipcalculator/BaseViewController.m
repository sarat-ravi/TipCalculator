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

-(int)getTipPercentForKey:(NSString *)tipKey {
    
    // Define some defaults.
    NSDictionary *tipKeyToDefaultMapping = @{
        @"TERRIBLE_SERVICE_PERCENT": @10,
        @"DECENT_SERVICE_PERCENT": @15,
        @"GREAT_SERVICE_PERCENT": @20,
    };
    
    // Assert that the tip key is valid.
    if ([tipKeyToDefaultMapping objectForKey:tipKey] == nil) {
        [NSException raise: @"Invalid key" format: @"Key '%@' is invalid", tipKey];
    }
    
    // Attempt to load the tip percent from user settings, or set to default.
    int tipPercent = [[tipKeyToDefaultMapping objectForKey: tipKey] intValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey: tipKey] != nil) {
        tipPercent = (int) [defaults integerForKey: tipKey];
    }
    return tipPercent;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

-(void)setBackgroundGradient {
    // Grab the controller's view.
    UIView *view = self.view;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    
    // Set the top and bottom color.
    UIColor *bottomColor = [UIColor colorWithRed:0.10 green:0.64 blue:0.61 alpha:1.0];
    UIColor *topColor = [UIColor colorWithRed:0.30 green:0.47 blue:0.75 alpha:1.0];
    
    // Set the gradient with these two colors.
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
}

@end