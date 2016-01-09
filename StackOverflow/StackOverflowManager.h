//
//  StackOverflowManager.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"
#import "StackOverflowCommunicator.h"
#import "QuestionBuilder.h"

@class Topic, Question;

enum
{
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerErrorQuestionBodyFetchCode,
    StackOverflowManagerErrorAnswerFetchCode
};

@interface StackOverflowManager : NSObject

@property (weak,   nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong, nonatomic) StackOverflowCommunicator *communicator;
@property (strong, nonatomic) QuestionBuilder *questionBuilder;
@property (strong, nonatomic) Question *questionNeedingBody;
- (void)fetchQuestionOnTopic:(Topic *)topic;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;
@end
