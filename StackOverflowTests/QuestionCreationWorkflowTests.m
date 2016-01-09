//
//  QuestionCreationTests.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowManager.h"
#import "StackOverflowManagerDelegate.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "Topic.h"
#import "Question.h"
#import "FakeQuestionBuilder.h"

@interface QuestionCreationWorkflowTests : XCTestCase
{
@private
    StackOverflowManager *mgr;
    MockStackOverflowManagerDelegate *delegate;
    MockStackOverflowCommunicator *communicator;
    NSError *underlyingError;
    FakeQuestionBuilder *questionBuilder;
    
    NSArray *questionArray;
    Question *questionToFetch;
}
@end

@implementation QuestionCreationWorkflowTests

- (void)setUp
{
    [super setUp];
    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    questionBuilder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = questionBuilder;
    
    questionToFetch = [[Question alloc] init];
    questionToFetch.questionID = 123;
    questionArray = [NSArray arrayWithObject: questionToFetch];
    communicator = [[MockStackOverflowCommunicator alloc] init];
    mgr.communicator = communicator;
}

- (void)tearDown
{
    mgr = nil;
    delegate = nil;
    underlyingError = nil;
    questionBuilder = nil;
    questionToFetch = nil;
    questionArray   = nil;
    [super tearDown];
}

// delegate
- (void) testNonConformingObjectCannotBeDelegate
{
    XCTAssertThrows(mgr.delegate = (id<StackOverflowManagerDelegate>)[NSNull null], @"NSNull should not be used as the delegate as doesn't conform to the delegate protocol");
}

- (void) testConformingObjectCanBeDelegate
{
    XCTAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void) testManagerAccepsNilAsDelegate
{
    XCTAssertNoThrow(mgr.delegate = nil, @"It should be acceptable to use nul as an object's delegate");
}

//коммуникатор реагирует на запрос менеджера
- (void) testAskingForQuestionsMeansRequestingData
{
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionOnTopic:topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data");
}

//делегат получает обернутую ошибку
- (void) testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator
{
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

// проверим что делгату идет ошибка с запакованной системной ошибкой
- (void) testErrorReturnedToDelegateDocumentsUnderlyingError
{
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

// проверим что при получении менеджером json строки она передается билдеру
- (void)testQuestionJSONIsPassedToQuestionBuilder
{
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.JSON, @"Fake JSON", @"Downloaded JSON is sent to the builder");
    mgr.questionBuilder = nil;
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails
{
    questionBuilder.arrayToReturn = nil;
    questionBuilder.errorToSet = underlyingError;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], @"The delegate should have found out about the error");
    mgr.questionBuilder = nil;
}

- (void)testDelegateNotToldAboutErrorWhenQuestionsReceived
{
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertNil([delegate fetchError], @"No error should be received on success");
}

- (void)testDelegateReceivesTheQuestionsDiscoveredByManager
{
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], questionArray, @"The manager should have sent its questions to the delegate");
}

- (void)testEmptyArrayIsPassedToDelegate
{
    questionBuilder.arrayToReturn = [NSArray array];
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], [NSArray array], @"Returning an empty array is not an error");
}

- (void)testAskingForQuestionBodyMeansRequestingData
{
    [mgr fetchBodyForQuestion: questionToFetch];
    XCTAssertTrue([communicator wasAskedToFetchBody], @"The communicator should need to retrieve data for the question body");
}


- (void)testDelegateNotifiedOfFailureToFetchQuestion
{
    [mgr fetchingQuestionBodyFailedWithError: underlyingError];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], @"Delegate should have found out about this error");
}

- (void)testManagerPassesRetrievedQuestionBodyToQuestionBuilder
{
    [mgr receivedQuestionBodyJSON: @"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.JSON, @"Fake JSON", @"Successfully-retrieved data should be passed to the builder");
}

- (void)testManagerPassesQuestionItWasSentToQuestionBuilderForFillingIn
{
    [mgr fetchBodyForQuestion: questionToFetch];
    [mgr receivedQuestionBodyJSON: @"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.questionToFill, questionToFetch, @"The question should have been passed to the builder");
}

@end
