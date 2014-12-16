//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Sarat Tallamraju on 12/15/14.
//  Copyright (c) 2014 sarattallamraju. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // self = [super initWithNibName:nibNameOrNil bundle:<#nibBundleOrNil#>];
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
}


@end
