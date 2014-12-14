//
//  TipViewController.m
//  tipcalculator
//
//  Created by Sarat Tallamraju on 12/13/14.
//  Copyright (c) 2014 sarattallamraju. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@end

@implementation TipViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // self = [super initWithNibName:nibNameOrNil bundle:<#nibBundleOrNil#>];
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

-(void)viewDidload
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // DIspose of any resources that can be recreated.
}

@end
