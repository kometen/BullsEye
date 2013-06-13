//
//  AboutViewController.h
//  BullsEye
//
//  Created by Claus Guttesen on 12/06/13.
//  Copyright (c) 2013 Claus Guttesen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIWebView *webView;

-(IBAction)close;

@end
