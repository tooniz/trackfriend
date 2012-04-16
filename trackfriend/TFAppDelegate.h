//
//  TFAppDelegate.h
//  trackfriend
//
//  Created by Ming Zhou on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

#define UIAppDelegate ((TFAppDelegate *)[UIApplication sharedApplication].delegate)
#define kDataKey @"Data"
#define kDataPath @"~/Documents/persons.dat"
#define kGradientBtnAlpha 0.8

ABAddressBookRef iPhoneAddressBook;
@class TFEnterNumberView;

@interface TFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *personAry;

@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) TFEnterNumberView *enterNumberView;

-(void) storeData;
-(void) loadData;

@end
