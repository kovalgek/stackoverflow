//
//  FakeURLResponse.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 12.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeURLResponse : NSObject
{
    NSInteger statusCode;
}

- (id)initWithStatusCode: (NSInteger)code;
- (NSInteger)statusCode;

@end
