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

@class Topic;

enum
{
    StackOverflowManagerErrorQuestionSearchCode
};

@interface StackOverflowManager : NSObject

@property (weak,   nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong, nonatomic) StackOverflowCommunicator *communicator;
@property (strong, nonatomic) QuestionBuilder *questionBuilder;
- (void)fetchQuestionOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
@end
