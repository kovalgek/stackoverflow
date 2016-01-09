//
//  StackOverflowManager.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "StackOverflowManager.h"
#import "Topic.h"
#import "Question.h"

NSString *StackOverflowManagerError             = @"StackOverflowManagerError";
NSString *StackOverflowManagerSearchFailedError = @"StackOverflowManagerSearchFailedError";

@implementation StackOverflowManager

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate
{
    if(newDelegate && ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)])
    {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object doesnt' conform to the delegate protocol" userInfo:nil] raise];
    }
    _delegate = newDelegate;
}

- (void)fetchQuestionOnTopic:(Topic *)topic
{
    [self.communicator searchForQuestionsForTag:[topic tag]];
}

- (void)fetchBodyForQuestion:(Question *)question
{
    self.questionNeedingBody = question;
    [self.communicator downloadInformationForQuestionWithID:question.questionID];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error
{
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = nil;
    if (error)
    {
        errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerError
                                                   code: StackOverflowManagerErrorQuestionBodyFetchCode
                                               userInfo:errorInfo];
    [self.delegate fetchingQuestionBodyFailedWithError: reportableError];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation
{
    NSError *error = nil;
    NSArray *questions = [self.questionBuilder questionsFromJSON:objectNotation error:&error];
    if(!questions)
    {
        [self tellDelegateAboutQuestionSearchError:error];
    }
    else
    {
        [self.delegate didReceiveQuestions:questions];
    }
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation
{
    [self.questionBuilder fillInDetailsForQuestion:self.questionNeedingBody fromJSON:objectNotation];
}

- (void) tellDelegateAboutQuestionSearchError:(NSError *)error
{
    NSDictionary *errorInfo = nil;
    if (error)
    {
        errorInfo = [NSDictionary dictionaryWithObject: error
                                                forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerSearchFailedError
                                                   code: StackOverflowManagerErrorQuestionSearchCode
                                               userInfo: errorInfo];
    [self.delegate fetchingQuestionsOnTopic:nil failedWithError:reportableError];
    //[self.delegate fetchingQuestionsFailedWithError: reportableError];
}

@end
