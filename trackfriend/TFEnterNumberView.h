//
//  TFEnterNumberView.h
//  trackfriend
//
//  Created by Ming Zhou on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class TZGradientButton;
@class TFMapView;

@interface TFEnterNumberView : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) TFMapView *mapView;

- (IBAction)prsBackground:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backgroundImg;

- (IBAction)prsEnterNameLbl:(id)sender;
- (IBAction)firstNameDone:(id)sender;
- (IBAction)lastNameDone:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *enterNamesLbl;
@property (strong, nonatomic) IBOutlet UITextField *firstNameBox;
@property (strong, nonatomic) IBOutlet UITextField *lastNameBox;


- (IBAction)prsEnterNumberLbl:(id)sender;
- (IBAction)phoneNumberDone:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *enterNumberLbl;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberBox;

- (IBAction)scanBtnTouch:(id)sender;
- (IBAction)scanBtn:(id)sender;
@property (strong, nonatomic) IBOutlet TZGradientButton *gradientScanBtn;

- (IBAction)beganEdit:(id)sender;


@end
