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
    BOOL wasAskedToFetchBody;
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

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier
{
    wasAskedToFetchBody = YES;
}

- (BOOL)wasAskedToFetchBody
{
    return wasAskedToFetchBody;
}

@end
