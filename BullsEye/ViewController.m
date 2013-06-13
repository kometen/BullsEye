//
//  ViewController.m
//  BullsEye
//
//  Created by Claus Guttesen on 09/06/13.
//  Copyright (c) 2013 Claus Guttesen. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    targetValue = 1 + (arc4random() % 100);

    self.slider.value = currentValue;
    [self updateLabels];
}

-(void)startNewGame {
    score = 0;
    round = 0;
    average = 0;
    [self startNewRound];
}

- (void)viewDidLoad {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
    [super viewDidLoad];
    [self startNewGame];
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
        score += 100;
        title = @"Perfect!";
    } else if (difference < 5) {
        if (difference == 1) {
            score += 50;
        }
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
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

-(IBAction)showInfo {
    AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

-(IBAction)sliderMoved:(UISlider *)sender {
    currentValue = lroundf(sender.value);
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self startNewRound];
}

@end
