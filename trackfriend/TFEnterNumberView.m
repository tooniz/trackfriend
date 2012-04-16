//
//  TFEnterNumberView.m
//  trackfriend
//
//  Created by Ming Zhou on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFRootView.h"
#import "TFEnterNumberView.h"
#import "TFMapView.h"
#import "TFPersonClass.h"
#import "TZGradientButton.h"
#import "TFAppDelegate.h"

@interface TFEnterNumberView()
-(void)initBox:(UITextField *)text;
-(void)scan;
//-(void)alertOkCancelAction;

@property (strong, nonatomic) NSString *enterNamesDefault;
@property (strong, nonatomic) NSString *enterNumberDefault;

@property (strong, nonatomic) UIBarButtonItem *doneBtn;
@property (strong, nonatomic) UIBarButtonItem *settingsBtn;

@end

@implementation TFEnterNumberView
@synthesize mapView;

@synthesize gradientScanBtn;
@synthesize backgroundImg;
@synthesize enterNumberLbl;
@synthesize phoneNumberBox;
@synthesize enterNamesLbl;
@synthesize firstNameBox;
@synthesize lastNameBox;

@synthesize enterNamesDefault;
@synthesize enterNumberDefault;
@synthesize doneBtn;
@synthesize settingsBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"PeopleLocate"];
    doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(Done:)];

    UIButton *a1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a1 setFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
    [a1 addTarget:self action:@selector(Settings:) forControlEvents:UIControlEventTouchUpInside];
    [a1 setImage:[UIImage imageNamed:@"settings_icon.png"] forState:UIControlStateNormal];
    UIBarButtonItem *random = [[UIBarButtonItem alloc] initWithCustomView:a1];
    random.customView.layer.shadowRadius = 3;
    random.customView.layer.shadowColor = [UIColor whiteColor].CGColor;
    random.customView.layer.shadowOffset = CGSizeMake(0, 0);
    random.customView.layer.shadowOpacity = 1;
    
    settingsBtn = random;
    self.navigationItem.leftBarButtonItem = settingsBtn;

    [self initBox:firstNameBox];
    [self initBox:lastNameBox];
    [self initBox:phoneNumberBox];
    
    [enterNamesLbl.titleLabel setTextAlignment:UITextAlignmentCenter];    
    [enterNumberLbl.titleLabel setTextAlignment:UITextAlignmentCenter];    

    enterNamesLbl.titleLabel.layer.shadowOffset = CGSizeMake(0, 0);
    enterNamesLbl.titleLabel.layer.shadowRadius = 2;
    enterNamesLbl.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    enterNamesLbl.titleLabel.layer.shadowOpacity = 0.8;

    enterNumberLbl.titleLabel.layer.shadowOffset = CGSizeMake(0, 0);
    enterNumberLbl.titleLabel.layer.shadowRadius = 2;
    enterNumberLbl.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    enterNumberLbl.titleLabel.layer.shadowOpacity = 0.8;
    
    enterNamesDefault = enterNamesLbl.titleLabel.text;
    enterNumberDefault = enterNumberLbl.titleLabel.text;

    [gradientScanBtn setAlpha:kGradientBtnAlpha];
    [gradientScanBtn setHighColor:[UIColor grayColor]];
    [gradientScanBtn setLowColor:[UIColor blackColor]];
}

- (void)viewDidUnload
{
    [self setEnterNamesLbl:nil];
    [self setFirstNameBox:nil];
    [self setLastNameBox:nil];
    [self setEnterNumberLbl:nil];
    [self setPhoneNumberBox:nil];
    [self setBackgroundImg:nil];
    [self setGradientScanBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    mapView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)initBox:(UITextField *)text {
    text.layer.cornerRadius=8.0f;
    text.layer.masksToBounds=YES;
    text.layer.borderColor=[[[UIColor alloc] initWithWhite:0.2 alpha:0.8] CGColor];
    text.layer.borderWidth= 1.0f;
    text.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 5, text.bounds.size.height)];
    text.leftViewMode = UITextFieldViewModeAlways;
    text.rightView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 5, text.bounds.size.height)];
    text.rightViewMode = UITextFieldViewModeAlways;
    
    text.layer.shadowOffset = CGSizeMake(0, 0);
    text.layer.shadowRadius = 11.0;
    text.layer.shadowColor = [UIColor whiteColor].CGColor;
    text.layer.shadowOpacity = 0.8;
}

#pragma mark - Nib UI Controls Methods
- (IBAction)prsBackground:(id)sender {
    [self lastNameDone:nil];
    [self phoneNumberDone:nil];
}

- (IBAction)prsEnterNameLbl:(id)sender {
    [UIView beginAnimations:@"fade" context:nil];
    enterNamesLbl.alpha = 0;
    firstNameBox.alpha = 1;
    lastNameBox.alpha = 1;
    [UIView commitAnimations];
    
    if (enterNumberLbl.alpha == 0) {
        [self phoneNumberDone:nil];
    }
    [firstNameBox becomeFirstResponder];
}

- (IBAction)firstNameDone:(id)sender {
    [firstNameBox resignFirstResponder];
    [lastNameBox becomeFirstResponder];
}

- (IBAction)lastNameDone:(id)sender {
    [firstNameBox resignFirstResponder];
    [lastNameBox resignFirstResponder];
    [UIView beginAnimations:@"fade" context:nil];
    enterNamesLbl.alpha = 1;
    if ((firstNameBox.text.length != 0) || (lastNameBox.text.length != 0)) {
        enterNamesLbl.titleLabel.text = [NSString stringWithFormat:@"%@ %@", firstNameBox.text, lastNameBox.text];
    }
    else {
        enterNamesLbl.titleLabel.text = enterNamesDefault;
    }
    firstNameBox.alpha = 0;
    lastNameBox.alpha = 0;
    [UIView commitAnimations];
    self.navigationItem.rightBarButtonItem = nil;
}

- (IBAction)prsEnterNumberLbl:(id)sender {
    [UIView beginAnimations:@"fade" context:nil];
    enterNumberLbl.alpha = 0;
    phoneNumberBox.alpha = 1;
    [UIView commitAnimations];
    self.navigationItem.rightBarButtonItem = nil;

    if (enterNamesLbl.alpha == 0) {
        [self lastNameDone:nil];
    }
    [phoneNumberBox becomeFirstResponder];
}

- (IBAction)phoneNumberDone:(id)sender {
    [phoneNumberBox resignFirstResponder];
    if (phoneNumberBox.text.length != 0) {
        enterNumberLbl.titleLabel.text = [NSString stringWithFormat:@"%@", phoneNumberBox.text];
    }
    else {
        enterNumberLbl.titleLabel.text = enterNumberDefault;
    }
    enterNumberLbl.alpha = 1;
    [UIView beginAnimations:@"fade" context:nil];
    phoneNumberBox.alpha = 0;
    [UIView commitAnimations];
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark Map View Button
- (IBAction)scanBtnTouch:(id)sender {
    [gradientScanBtn setAlpha:1];
}

- (IBAction)scanBtn:(id)sender {
    [gradientScanBtn setAlpha:kGradientBtnAlpha];
    mapView = [[TFMapView alloc] initWithNibName:@"TFMapView" bundle:nil];
    if (phoneNumberBox.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"Phone number missing!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
        [alert show];        
    }
    else {
        mapView.person.phoneNumber = phoneNumberBox.text;
        if ((firstNameBox.text.length == 0) || (lastNameBox.text.length == 0)) {
            if (firstNameBox.text.length == 0) {
                mapView.person.firstName = @"Unknown";
            } else {
                mapView.person.firstName = firstNameBox.text;
            }    
            if (lastNameBox.text.length == 0) {
                mapView.person.lastName = @"Unknown";
            } else {
                mapView.person.lastName = lastNameBox.text;
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Names are not complete" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alert show];
        }
        else {
            mapView.person.firstName = firstNameBox.text;
            mapView.person.lastName = lastNameBox.text;
            [self scan];
        }
    }
}

- (void)scan {
    [gradientScanBtn setAlpha:kGradientBtnAlpha];
    firstNameBox.text = @"";
    lastNameBox.text = @"";
    phoneNumberBox.text =@"";
    [self prsBackground:nil];
    mapView.isScanMode = 1;
    [self.navigationController pushViewController:mapView animated:YES];
    mapView = nil;
}

#pragma mark Done Button Methods
- (IBAction)beganEdit:(id)sender {
    self.navigationItem.rightBarButtonItem = doneBtn;
}
- (IBAction) Done:(id)sender{
    if (firstNameBox.isFirstResponder) {
        [self firstNameDone:firstNameBox];
    }
    else if (lastNameBox.isFirstResponder) {
        [self lastNameDone:lastNameBox];
        self.navigationItem.rightBarButtonItem = nil;
    }
    else if (phoneNumberBox.isFirstResponder) {
        [self phoneNumberDone:phoneNumberBox];
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (IBAction)Settings:(id)sender {
    TFRootView *settingsView = [[TFRootView alloc] initWithNibName:@"TFRootView" bundle:nil];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:settingsView animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        [self scan];
    }
}
@end
