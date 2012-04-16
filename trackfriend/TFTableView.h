//
//  TFTableView.h
//  trackfriend
//
//  Created by Ming Zhou on 12-02-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFTableView : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *personAry;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
