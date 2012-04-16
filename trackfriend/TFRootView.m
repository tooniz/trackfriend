//
//  TFRootView.m
//  trackfriend
//
//  Created by Ming Zhou on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFRootView.h"
#import "TFEnterNumberView.h"
#import "TFTableView.h"
#import "TZGradientButton.h"
#import "TFAppDelegate.h"

@implementation TFRootView
@synthesize viewNumberBtn;
@synthesize viewNumberView;
@synthesize textBox;

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
    //[self.navigationController setNavigationBarHidden:YES];
    [viewNumberBtn setAlpha:kGradientBtnAlpha];
    [viewNumberBtn setHighColor:[UIColor grayColor]];
    [viewNumberBtn setLowColor:[UIColor blackColor]];
    
    [self setTitle:@"PeopleLocate"];
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(Search:)];    
    search.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = search;

    textBox.layer.cornerRadius=15.0f;
    textBox.layer.masksToBounds=YES;
    textBox.layer.borderColor=[[[UIColor alloc] initWithWhite:0.2 alpha:0.8] CGColor];
    textBox.layer.borderWidth= 1.0f;
    
}

- (void)viewDidUnload
{
    [self setViewNumberBtn:nil];
    [self setTextBox:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    viewNumberView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)prsViewNumber:(id)sender {
    viewNumberView =[[TFTableView alloc] initWithNibName:@"TFTableView" bundle:nil];
    [self.navigationController pushViewController:viewNumberView animated:YES];
    viewNumberBtn.alpha = kGradientBtnAlpha;
}

- (IBAction)prsBeganViewNumber:(id)sender {
    viewNumberBtn.alpha = 1;
}

- (IBAction)Search:(id)sender {
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.375];
    [self.navigationController popViewControllerAnimated:NO];
    [UIView commitAnimations];
    
}
@end
