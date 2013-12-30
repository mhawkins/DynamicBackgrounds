//
//  GCViewController.m
//  DynamicBackground
//
//  Created by Matt Hawkins on 12/30/13.
//  Copyright (c) 2013 Matt Hawkins. All rights reserved.
//

#import "GCViewController.h"
#import "GCDynamicBackgroundView.h"

@interface GCViewController ()

@end

@implementation GCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setBackgroundBlue:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - IBActions
- (IBAction)setBackgroundBlue:(id)sender
{
    GCDynamicBackgroundView *backgroundView = (GCDynamicBackgroundView *)self.view;
    backgroundView.startingColor = [UIColor colorWithRed:0.310f green:0.678f blue:0.914f alpha:1.00f];
    backgroundView.endingColor = [UIColor colorWithRed:0.251f green:0.486f blue:0.639f alpha:1.00f];
}

- (IBAction)setBackgroundRed:(id)sender
{
    GCDynamicBackgroundView *backgroundView = (GCDynamicBackgroundView *)self.view;
    backgroundView.startingColor = [UIColor colorWithRed:0.933f green:0.267f blue:0.271f alpha:1.00f];
    backgroundView.endingColor = [UIColor colorWithRed:0.565f green:0.137f blue:0.102f alpha:1.00f];
}
@end
