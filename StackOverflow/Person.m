//
//  Person.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 16.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name
              avatarLocation:(NSString *)avatarLocation
{
    if(self = [super init])
    {
        _name = [name copy];
        _avatarURL = [NSURL URLWithString:avatarLocation];
    }
    return self;
}

@end
