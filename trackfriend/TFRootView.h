//
//  TFRootView.h
//  trackfriend
//
//  Created by Ming Zhou on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFTableView;
@class TZGradientButton;

@interface TFRootView : UIViewController

- (IBAction)prsViewNumber:(id)sender;
- (IBAction)prsBeganViewNumber:(id)sender;

@property (strong, nonatomic) IBOutlet TZGradientButton *viewNumberBtn;

@property (strong, nonatomic) TFTableView *viewNumberView;
@property (strong, nonatomic) IBOutlet UITextView *textBox;

@end
