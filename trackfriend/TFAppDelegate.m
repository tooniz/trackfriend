//
//  TFAppDelegate.m
//  trackfriend
//
//  Created by Ming Zhou on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFAppDelegate.h"
#import "TFEnterNumberView.h"

@implementation TFAppDelegate

@synthesize window = _window;
@synthesize personAry;
@synthesize enterNumberView;
@synthesize navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    // Create image for navigation background - portrait
    UIImage *NavigationPortraitBackground = [[UIImage imageNamed:@"nav_bar.gif"] 
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    // Set the background image all UINavigationBars
    [[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground 
                                       forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance] setTitle:@"PeopleLocate"];
    
    self.enterNumberView = [[TFEnterNumberView alloc] initWithNibName:@"TFEnterNumberView" bundle:nil];
    self.navController = [[UINavigationController alloc] init];
    navController.title = @"PeopleLocate";
    navController.navigationBar.tintColor = [UIColor blackColor]; //[UIColor colorWithRed:0.4 green:00 blue:00 alpha:1];
    navController.navigationBar.alpha = 1;
    [navController pushViewController:self.enterNumberView animated:NO];
    [self.window addSubview:navController.view];

    iPhoneAddressBook = ABAddressBookCreate();
    personAry = [[NSMutableArray alloc] init];
    [self loadData];
    
    self.window.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.window makeKeyAndVisible];
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - Persons Array Methods

- (void)storeData {
    NSString *filepath = [[[NSString alloc] initWithFormat:kDataPath] stringByExpandingTildeInPath];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver encodeObject:personAry forKey:kDataKey];
    [archiver finishEncoding];
    
    [data writeToFile:filepath atomically:YES];
}

- (void)loadData {
    NSString *filepath = [[[NSString alloc] initWithFormat:kDataPath] stringByExpandingTildeInPath];
    NSData *data = [[NSMutableData alloc]
                    initWithContentsOfFile:filepath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                     initForReadingWithData:data];
    NSMutableArray *loaddata = [unarchiver decodeObjectForKey:kDataKey];
    [unarchiver finishDecoding];
    [personAry removeAllObjects];
    if (loaddata.count > 0) {
        personAry = loaddata;
    }
}

@end
