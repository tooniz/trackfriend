//
//  TFPersonClass.h
//  trackfriend
//
//  Created by Ming Zhou on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@interface TFPersonClass : NSObject <NSCoding, NSCopying>

@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic) NSString *phoneNumber;
@property (copy, nonatomic) NSDate *date;

@property (copy, nonatomic) CLLocation *location;


@end
