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

-(void)loadValues
{
    // Set defaults
    int greatServicePercent = 20;
    int decentServicePercent = 15;
    int terribleServicePercent = 10;
    
    // Load settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey: @"GREAT_SERVICE_PERCENT"] != nil) {
        greatServicePercent = (int) [defaults integerForKey: @"GREAT_SERVICE_PERCENT"];
    }
    
    if ([defaults objectForKey: @"DECENT_SERVICE_PERCENT"] != nil) {
        decentServicePercent = (int) [defaults integerForKey: @"DECENT_SERVICE_PERCENT"];
    }
    
    if ([defaults objectForKey: @"TERRIBLE_SERVICE_PERCENT"] != nil) {
        terribleServicePercent = (int) [defaults integerForKey: @"TERRIBLE_SERVICE_PERCENT"];
    }

    
    // Set labels
    self.greatServiceLabel.text = [[NSString alloc] initWithFormat:@"%d%%", greatServicePercent];
    self.decentServiceLabel.text = [[NSString alloc] initWithFormat:@"%d%%", decentServicePercent];
    self.terribleServiceLabel.text = [[NSString alloc] initWithFormat:@"%d%%", terribleServicePercent];
    
    // Set steppers
    self.greatServiceStepper.value = greatServicePercent;
    self.decentServiceStepper.value = decentServicePercent;
    self.terribleServiceStepper.value = terribleServicePercent;
}

-(void)saveValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: (int) self.greatServiceStepper.value forKey: @"GREAT_SERVICE_PERCENT"];
    [defaults setInteger: (int) self.decentServiceStepper.value forKey: @"DECENT_SERVICE_PERCENT"];
    [defaults setInteger: (int) self.terribleServiceStepper.value forKey: @"TERRIBLE_SERVICE_PERCENT"];
    [defaults synchronize];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}


- (IBAction)onGreatServiceStepperValueChanged:(UIStepper *) uiStepper {
    int newValue = (int) uiStepper.value;
    self.greatServiceLabel.text = [[NSString alloc] initWithFormat:@"%d%%", newValue];
    [self saveValues];
}

- (IBAction)onDecentServiceStepperValueChanged:(UIStepper *) uiStepper {
    int newValue = (int) uiStepper.value;
    self.decentServiceLabel.text = [[NSString alloc] initWithFormat:@"%d%%", newValue];
    [self saveValues];
}

- (IBAction)onTerribleServiceStepperValueChanged:(UIStepper *) uiStepper {
    int newValue = (int) uiStepper.value;
    self.terribleServiceLabel.text = [[NSString alloc] initWithFormat:@"%d%%", newValue];
    [self saveValues];
}
@end
