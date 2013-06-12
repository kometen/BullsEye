//
//  ViewController.m
//  BullsEye
//
//  Created by Claus Guttesen on 09/06/13.
//  Copyright (c) 2013 Claus Guttesen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    int currentValue;
    int targetValue;
    int score;
    int round;
    int average;
}

-(void)updateLabels {
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
    if (round > 0) {
        average = score / round;
    }
    self.averageLabel.text = [NSString stringWithFormat:@"%d", average];
}

-(void)startNewRound {
    currentValue = 50;
    do {
        targetValue = 1 + (arc4random() % 100);
    } while ((targetValue % 50) == 0);

    self.slider.value = currentValue;
//    [self updateLabels];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNewRound];
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

-(IBAction)showAlert {
    int difference = abs(targetValue - currentValue);
    int points = self.slider.maximumValue - difference;
    score += points;
    round++;

    NSString *message = [NSString stringWithFormat:@"You scored %d points: ", points];
    NSString *title;
    if (difference == 0) {
        title = @"Perfect!";
    } else if (difference < 5) {
        title = @"Almost!";
    } else if (difference < 10) {
        title = @"Somewhat!";
    } else {
        title = @"Not!";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

-(IBAction)startOver{
    score = 0;
    round = 0;
    average = 0;
    [self startNewRound];
    [self updateLabels];
}

-(IBAction)sliderMoved:(UISlider *)sender {
    currentValue = lroundf(sender.value);
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self startNewRound];
    [self updateLabels];
}

@end
