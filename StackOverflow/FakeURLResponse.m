//
//  FakeURLResponse.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 12.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "FakeURLResponse.h"

@implementation FakeURLResponse

- (instancetype)initWithStatusCode:(NSInteger)code
{
    if ((self = [super init]))
    {
        statusCode = code;
    }
    return self;
}

- (NSInteger)statusCode
{
    return statusCode;
}

@end
