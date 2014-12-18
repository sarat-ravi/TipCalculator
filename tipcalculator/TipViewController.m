//
//  TipViewController.m
//  tipcalculator
//
//  Created by Sarat Tallamraju on 12/13/14.
//  Copyright (c) 2014 sarattallamraju. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

// Properties
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *serviceSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;
@property (weak, nonatomic) IBOutlet UIStepper *tipPercentStepper;
@property (weak, nonatomic) IBOutlet UIStepper *numberOfPeopleStepper;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *youPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (strong, nonatomic) NSString *currencySymbol;

// Actions
- (IBAction)onSegmentedControlValueChanged:(id)sender;
- (IBAction)onTap:(id)sender;
- (IBAction)onTipPercentStepperValueChanged:(id)sender;
- (IBAction)onNumberOfPeopleStepperValueChanged:(id)sender;
- (IBAction)billTextFieldDidBeginEditing:(id)sender;
- (IBAction)onBillTextFieldEditingChanged:(id)sender;
- (IBAction)billTextFieldEditingDidEnd:(id)sender;

// Helper Functions
- (void)updateValues;

@end

@implementation TipViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // self = [super initWithNibName:nibNameOrNil bundle:<#nibBundleOrNil#>];
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
        [self setCurrencySymbol];
    }
    return self;
}

-(void)setCurrencySymbol {
    NSLocale *currentLocale = [NSLocale currentLocale];
    self.currencySymbol = [currentLocale objectForKey:NSLocaleCurrencySymbol];
}

-(void)updateValues
{
    NSLog(@"updateValues called");
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // inputs
    float billAmount = [[nf numberFromString:self.billTextField.text] floatValue];
    if (billAmount == 0.0) {
        billAmount = [self.billTextField.text floatValue];
    }
    float tipPercent = [self.tipPercentLabel.text intValue] / 100.0;
    int numPeople = [self.numberOfPeopleLabel.text intValue];
    
    // outputs
    float tipAmount = billAmount * tipPercent;
    float totalAmount = billAmount + tipAmount;
    float youPay = totalAmount / numPeople;
    
    // update labels
    self.billTextField.text = [self formatCurrency: billAmount];
    self.tipAmountLabel.text = [self formatCurrency: tipAmount];
    self.youPayLabel.text = [self formatCurrency: youPay];
    self.totalAmountLabel.text = [self formatCurrency: totalAmount];
}

-(NSString *)formatCurrency: (float) amount {
    return [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, amount];
}

-(int)getTipPercentForSegmentedControlIndex: (int) index {
    NSArray *tipKeys = @[@"TERRIBLE_SERVICE_PERCENT", @"DECENT_SERVICE_PERCENT", @"GREAT_SERVICE_PERCENT"];
    NSArray *defaultTipPercents = @[@(10), @(15), @(20)];
    NSString *tipKey = [tipKeys objectAtIndex: index];
    
    int tipPercent = [[defaultTipPercents objectAtIndex: index] intValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey: tipKey] != nil) {
        tipPercent = (int) [defaults integerForKey: tipKey];
    }
    return tipPercent;
}

-(void)loadValues {
    int index = (int) self.serviceSegmentedControl.selectedSegmentIndex;
    int tipPercent = [self getTipPercentForSegmentedControlIndex: index];
    
    self.tipPercentLabel.text = [NSString stringWithFormat: @"%d%%", tipPercent];
    self.tipPercentStepper.value = (double) tipPercent;
}

-(void)viewDidLoad
{
    NSLog(@"TipViewController: viewDidLoad");
    [super viewDidLoad];
    [self loadValues];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"TipViewController: viewDidAppear");
    [super viewDidAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: [self getCustomSettingsButton]];
    [self updateValues];
}

-(UIButton *)getCustomSettingsButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"⚙" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25.0f];

    button.frame=CGRectMake(0.0, 100.0, 60.0, 30.0);
    [button addTarget:self action:@selector(onSettingsButton)  forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void) onSettingsButton
{
    NSLog(@"onSettingsButton");
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
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

- (IBAction)onSegmentedControlValueChanged:(id)sender {
    NSLog(@"onSegmentedControlValueChanged");
    [self.view endEditing: YES];
    
    int index = (int) self.serviceSegmentedControl.selectedSegmentIndex;
    int tipPercent = [self getTipPercentForSegmentedControlIndex: index];

    [self.tipPercentStepper setValue: tipPercent];
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%d%%", tipPercent];
    [self updateValues];
}


- (IBAction)onTap:(id)sender {
    [self.view endEditing: YES];
    [self updateValues];
}

- (IBAction)onTipPercentStepperValueChanged:(UIStepper *)sender {
    [self.view endEditing: YES];

    int tipPercent = sender.value;
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%d%%", tipPercent];
    [self updateValues];
}

- (IBAction)onNumberOfPeopleStepperValueChanged:(UIStepper *)sender {
    [self.view endEditing: YES];

    int numPeople = sender.value;
    self.numberOfPeopleLabel.text = [NSString stringWithFormat: @"%d", numPeople];
    [self updateValues];
}

- (IBAction)billTextFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"billTextFieldDidBeginEditing");
    textField.text = [self formatCurrency: 0.0];
}

- (NSString *)shiftRightText:(NSString *)textInput {
    // 0.1 --> 0.01
    // 12.3 --> 1.23
    
    NSMutableString *text = [NSMutableString stringWithString: textInput];

    int targetPosition = (int) [text length] - 3;
    [text deleteCharactersInRange: NSMakeRange(targetPosition + 1, 1)];
    [text insertString:@"." atIndex:targetPosition];
    
    if ([text characterAtIndex: 0] == '.') {
        [text insertString: @"0" atIndex: 0];
    }

    return text;
}

- (NSString *)shiftLeftText:(NSString *)textInput {
    // 0.1* --> 0.01
    // 12.345 --> 123.45
    
    NSMutableString *text = [NSMutableString stringWithString: textInput];
    
    int targetPosition = (int) [text length] - 2;
    [text insertString:@"." atIndex:targetPosition];

    [text deleteCharactersInRange: NSMakeRange(targetPosition - 2 , 1)];
    
    int consumeUntil = 0;
    for (int i = 0; i < targetPosition - 2; i++) {
        if ([text characterAtIndex: i] == '0') {
            consumeUntil++;
        }
    }
    [text deleteCharactersInRange: NSMakeRange(0, consumeUntil)];

    return text;
}

- (IBAction)onBillTextFieldEditingChanged:(UITextField *)textField {
    NSString *billText = textField.text;
    NSString *stringAfterDollar = [billText substringFromIndex: 1];
    NSString *stringAfterDot = [[billText componentsSeparatedByString:@"."] lastObject];
    float billAmount;
    if ([stringAfterDot length] == 1) {
        billAmount = [[self shiftRightText: stringAfterDollar] floatValue];
    } else {
        billAmount = [[self shiftLeftText: stringAfterDollar] floatValue];
    }
    
    textField.text = [self formatCurrency: billAmount];
}

- (IBAction)billTextFieldEditingDidEnd:(UITextField *)textField {
    NSLog(@"billTextFieldEditingDidEnd");
}

@end
