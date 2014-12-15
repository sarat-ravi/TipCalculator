//
//  TipViewController.m
//  tipcalculator
//
//  Created by Sarat Tallamraju on 12/13/14.
//  Copyright (c) 2014 sarattallamraju. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *serviceSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;
@property (weak, nonatomic) IBOutlet UIStepper *tipPercentStepper;
@property (weak, nonatomic) IBOutlet UIStepper *numberOfPeopleStepper;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *youPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

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

-(void)updateValues
{
    NSLog(@"updateValues called");
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // inputs
    float billAmount = [[nf numberFromString:self.billTextField.text] floatValue];
    float tipPercent = [self.tipPercentLabel.text intValue] / 100.0;
    int numPeople = [self.numberOfPeopleLabel.text intValue];
    
    // outputs
    float tipAmount = billAmount * tipPercent;
    float totalAmount = billAmount + tipAmount;
    float youPay = totalAmount / numPeople;
    
    // update labels
    self.billTextField.text = [NSString stringWithFormat:@"$%0.2f", billAmount];
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.youPayLabel.text = [NSString stringWithFormat:@"$%0.2f", youPay];
    self.totalAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateValues];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // DIspose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing: YES];
    [self updateValues];
}

@end
