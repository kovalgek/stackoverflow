//
//  MockStackOverflowManagerDelegate.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate

- (void)fetchingQuestionsOnTopic:(Topic *)topic
                 failedWithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions
{
    _receivedQuestions = questions;
}

@end
