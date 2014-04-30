//
//  ViewController.m
//  Calculator
//
//  Created by Justin Alm on 2014-04-29.
//  Copyright (c) 2014 Justin Alm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setNeedsStatusBarAppearanceUpdate];
    valueString = @"";
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)tappedClear:(id)sender
{
    total = 0;
    valueString = @"";
    label.text = @"0";
    mode = 0;
}

-(IBAction)tappedNumber:(UIButton*)btn
{
    int num = (int)btn.tag;
    if (num == 0 && total == 0) {
        return;
    }
    if (lastButtonWasMode) {
        lastButtonWasMode = NO;
        valueString = @"";
    }
    NSString *numAsString = [NSString stringWithFormat:@"%i", num];
    valueString = [valueString stringByAppendingString:numAsString];
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *n = [formatter numberFromString:valueString];
    label.text = [formatter stringFromNumber:n];
    if (total == 0) {
        total = [valueString intValue];
    }
}

-(IBAction)tappedPlus:(id)sender
{
    [self setMode:1];
}

-(IBAction)tappedMinus:(id)sender
{
    [self setMode:-1];
}

-(IBAction)tappedMultiply:(id)sender
{
    [self setMode:2];
}

-(IBAction)tappedEquals:(id)sender
{
    if (mode == 0) {
        return;
    }
    if (mode == 1) {
        total += [valueString intValue];
    }
    if (mode == -1) {
        total -= [valueString intValue];
    }
    if (mode == 2) {
        total *= [valueString intValue];
    }
    valueString = [NSString stringWithFormat:@"%i", total];
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *n = [formatter numberFromString:valueString];
    label.text = [formatter stringFromNumber:n];
    mode = 0;
}

-(void)setMode:(int)m
{
    if (total == 0) {
        return;
    }
    mode = m;
    lastButtonWasMode = YES;
    total = [valueString intValue];
}

@end
