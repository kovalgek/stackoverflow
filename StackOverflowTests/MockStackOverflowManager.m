//
//  MockStackOverflowManager.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 12.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "MockStackOverflowManager.h"

@implementation MockStackOverflowManager

@synthesize delegate;

- (NSInteger)topicFailureErrorCode
{
    return topicFailureErrorCode;
}

- (NSString *)topicSearchString
{
    return topicSearchString;
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error
{
    topicFailureErrorCode = [error code];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation
{
    topicSearchString = objectNotation;
}

@end
