//
//  TFPersonClass.m
//  trackfriend
//
//  Created by Ming Zhou on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFPersonClass.h"

#define kFirstNameKey @"FirstName"
#define kLastNameKey @"LastName"
#define kLocationKey @"Location"
#define kPhoneNumberKey @"PhoneNumber"
#define kDateKey @"Date"

@implementation TFPersonClass

@synthesize firstName;
@synthesize lastName;
@synthesize location;
@synthesize phoneNumber;
@synthesize date;

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:firstName forKey:kFirstNameKey];
    [encoder encodeObject:lastName forKey:kLastNameKey];
    [encoder encodeObject:location forKey:kLocationKey];
    [encoder encodeObject:phoneNumber forKey:kPhoneNumberKey];
    [encoder encodeObject:date forKey:kDateKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        firstName = [decoder decodeObjectForKey:kFirstNameKey];
        lastName = [decoder decodeObjectForKey:kLastNameKey];
        location = [decoder decodeObjectForKey:kLocationKey];
        phoneNumber = [decoder decodeObjectForKey:kPhoneNumberKey];
        date = [decoder decodeObjectForKey:kDateKey];
    }
    return self;
}

#pragma mark -
#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
    TFPersonClass *copy = [[[self class] allocWithZone: zone] init];
    copy.firstName = [self.firstName copyWithZone:zone];
    copy.lastName = [self.lastName copyWithZone:zone];
    copy.location = [self.location copyWithZone:zone];
    copy.phoneNumber = [self.phoneNumber copyWithZone:zone];
    copy.date = [self.date copyWithZone:zone];
    return copy;
}

@end
