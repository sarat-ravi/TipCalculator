//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Sarat Tallamraju on 12/15/14.
//  Copyright (c) 2014 sarattallamraju. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

// Labels
@property (weak, nonatomic) IBOutlet UILabel *greatServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *decentServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *terribleServiceLabel;

// Steppers
@property (weak, nonatomic) IBOutlet UIStepper *greatServiceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *decentServiceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *terribleServiceStepper;

// Actions
- (IBAction)onGreatServiceStepperValueChanged:(id)sender;
- (IBAction)onDecentServiceStepperValueChanged:(id)sender;
- (IBAction)onTerribleServiceStepperValueChanged:(id)sender;

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
    [self loadValues];
}

-(void)loadValues {
    
    // Get the tip percents for the given keys.
    int greatServicePercent = [self getTipPercentForKey: @"GREAT_SERVICE_PERCENT"];
    int decentServicePercent = [self getTipPercentForKey: @"DECENT_SERVICE_PERCENT"];
    int terribleServicePercent = [self getTipPercentForKey: @"TERRIBLE_SERVICE_PERCENT"];
    
    // Set labels
    self.greatServiceLabel.text = [self formatPercent: greatServicePercent];
    self.decentServiceLabel.text = [self formatPercent: decentServicePercent];
    self.terribleServiceLabel.text = [self formatPercent: terribleServicePercent];
    
    // Set steppers
    self.greatServiceStepper.value = greatServicePercent;
    self.decentServiceStepper.value = decentServicePercent;
    self.terribleServiceStepper.value = terribleServicePercent;
}

-(NSString *)formatPercent:(int)percent {
    return [NSString stringWithFormat: @"%d%%", percent];
}

-(void)saveValues {
    // Save the tip percents for the given keys.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: (int) self.greatServiceStepper.value forKey: @"GREAT_SERVICE_PERCENT"];
    [defaults setInteger: (int) self.decentServiceStepper.value forKey: @"DECENT_SERVICE_PERCENT"];
    [defaults setInteger: (int) self.terribleServiceStepper.value forKey: @"TERRIBLE_SERVICE_PERCENT"];
    [defaults synchronize];
}

- (IBAction)onGreatServiceStepperValueChanged:(UIStepper *) uiStepper {
    int newValue = (int) uiStepper.value;
    self.greatServiceLabel.text = [self formatPercent: newValue];
    [self saveValues];
}

- (IBAction)onDecentServiceStepperValueChanged:(UIStepper *) uiStepper {
    int newValue = (int) uiStepper.value;
    self.decentServiceLabel.text = [self formatPercent: newValue];
    [self saveValues];
}

- (IBAction)onTerribleServiceStepperValueChanged:(UIStepper *) uiStepper {
    int newValue = (int) uiStepper.value;
    self.terribleServiceLabel.text = [self formatPercent: newValue];
    [self saveValues];
}
@end
