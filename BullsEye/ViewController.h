//
//  ViewController.h
//  BullsEye
//
//  Created by Claus Guttesen on 09/06/13.
//  Copyright (c) 2013 Claus Guttesen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *targetLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *roundLabel;
@property (nonatomic, strong) IBOutlet UILabel *averageLabel;

-(IBAction)showAlert;
-(IBAction)startOver;
-(IBAction)showInfo;
-(IBAction)sliderMoved:(UISlider *)slider;

@end
