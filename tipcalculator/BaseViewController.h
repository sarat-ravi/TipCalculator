//
//  BaseViewController.h
//  tipcalculator
//
//  Created by Sarat Tallamraju on 12/18/14.
//  Copyright (c) 2014 sarattallamraju. All rights reserved.
//

#ifndef tipcalculator_BaseViewController_h
#define tipcalculator_BaseViewController_h

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/*
 Sets the background of the view using two colors that are part of a gradient.
 */
-(void)setBackgroundGradient;

/*
 Get the tip percent for the given key from the user settings, or return some default value if no such setting is found.
 */
-(int)getTipPercentForKey:(NSString *)key;

@end

#endif
