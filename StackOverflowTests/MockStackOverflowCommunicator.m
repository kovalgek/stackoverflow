//
//  MockStackOverflowCommunicator.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator()
{
    BOOL wasAskedToFetchQuestions;
}
@end

@implementation MockStackOverflowCommunicator

- (void)searchForQuestionsForTag:(NSString *)tag
{
    wasAskedToFetchQuestions = YES;
}

- (BOOL)wasAskedToFetchQuestions
{
    return wasAskedToFetchQuestions;
}

@end
