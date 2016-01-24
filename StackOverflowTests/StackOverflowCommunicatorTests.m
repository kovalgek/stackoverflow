//
//  StackOverflowCommunicatorTests.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 09.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InspectableStackOverflowCommunicator.h"
#import "NonNetworkedStackOverflowCommunicator.h"
#import "MockStackOverflowManager.h"
#import "FakeURLResponse.h"

@interface StackOverflowCommunicatorTests : XCTestCase
{
    InspectableStackOverflowCommunicator *communicator;
    NonNetworkedStackOverflowCommunicator *nnCommunicator;
    MockStackOverflowManager *manager;
    FakeURLResponse *fourOhFourResponse;
    NSData *receivedData;
}
@end

@implementation StackOverflowCommunicatorTests

- (void)setUp
{
    [super setUp];
    communicator = [[InspectableStackOverflowCommunicator alloc] init];
    nnCommunicator = [[NonNetworkedStackOverflowCommunicator alloc] init];
    manager = [[MockStackOverflowManager alloc] init];
    nnCommunicator.delegate = manager;
    fourOhFourResponse = [[FakeURLResponse alloc] initWithStatusCode: 404];
    receivedData = [@"Result" dataUsingEncoding: NSUTF8StringEncoding];
}

- (void)tearDown
{
    [communicator cancelAndDiscardURLConnection];
    communicator = nil;
    nnCommunicator = nil;
    manager = nil;
    fourOhFourResponse = nil;
    receivedData = nil;
    [super tearDown];
}

// вызываем нужные урлы
- (void)testSearchingForQuestionsOnTopicCallsTopicAPI
{
    [communicator searchForQuestionsForTag: @"ios"];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"https://api.stackexchange.com/2.2/search?pagesize=20&order=desc&sort=activity&tagged=ios&site=stackoverflow", @"Use the search API to find questions with a particular tag");
}

- (void)testFillingInQuestionBodyCallsQuestionAPI
{
    [communicator downloadInformationForQuestionWithID: 12345];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"https://api.stackexchange.com/2.2/questions/12345?site=stackapps&filter=withbody", @"Use the question API to get the body for a question");
}

- (void)testFetchingAnswersToQuestionCallsQuestionAPI
{
    [communicator downloadAnswersToQuestionWithID: 12345];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"https://api.stackexchange.com/2.2/questions/12345/answers?order=desc&sort=activity&site=stackoverflow", @"Use the question API to get answers on a given question");
}

// устанавливаем соединение
- (void)testSearchingForQuestionsCreatesURLConnection
{
    [communicator searchForQuestionsForTag: @"ios"];
    XCTAssertNotNil([communicator currentURLConnection], @"There should be a URL connection in-flight now.");
}

// новое соединение обрывает старое
- (void)testStartingNewSearchThrowsOutOldConnection
{
    [communicator searchForQuestionsForTag: @"ios"];
    NSURLConnection *firstConnection = [communicator currentURLConnection];
    [communicator searchForQuestionsForTag: @"cocoa"];
    XCTAssertFalse([[communicator currentURLConnection] isEqual: firstConnection], @"The communicator needs to replace its URL connection to start a new one");
}

- (void)testReceivingResponseDiscardsExistingData
{
    nnCommunicator.receivedData = [@"Hello" dataUsingEncoding: NSUTF8StringEncoding];
    [nnCommunicator searchForQuestionsForTag: @"ios"];
    [nnCommunicator connection: nil didReceiveResponse: nil];
    XCTAssertEqual([nnCommunicator.receivedData length], (NSUInteger)0, @"Data should have been discarded");
}

- (void)testReceivingResponseWith404StatusPassesErrorToDelegate
{
    [nnCommunicator searchForQuestionsForTag: @"ios"];
    [nnCommunicator connection: nil didReceiveResponse: (NSURLResponse *)fourOhFourResponse];
    XCTAssertEqual([manager topicFailureErrorCode], 404, @"Fetch failure was passed through to delegate");
}

- (void)testNoErrorReceivedOn200Status
{
    FakeURLResponse *twoHundredResponse = [[FakeURLResponse alloc] initWithStatusCode: 200];
    [nnCommunicator searchForQuestionsForTag: @"ios"];
    [nnCommunicator connection: nil didReceiveResponse: (NSURLResponse *)twoHundredResponse];
    XCTAssertFalse([manager topicFailureErrorCode] == 200, @"No need for error on 200 response");
}

- (void)testConnectionFailingPassesErrorToDelegate
{
    [nnCommunicator searchForQuestionsForTag: @"ios"];
    NSError *error = [NSError errorWithDomain: @"Fake domain" code: 12345 userInfo: nil];
    [nnCommunicator connection: nil didFailWithError: error];
    XCTAssertEqual([manager topicFailureErrorCode], 12345, @"Failure to connect should get passed to the delegate");
}

- (void)testSuccessfulQuestionSearchPassesDataToDelegate
{
    [nnCommunicator searchForQuestionsForTag: @"ios"];
    [nnCommunicator setReceivedData: receivedData];
    [nnCommunicator connectionDidFinishLoading: nil];
    XCTAssertEqualObjects([manager topicSearchString], @"Result", @"The delegate should have received data on success");
}

- (void)testAdditionalDataAppendedToDownload
{
    [nnCommunicator setReceivedData: receivedData];
    NSData *extraData = [@" appended" dataUsingEncoding: NSUTF8StringEncoding];
    [nnCommunicator connection: nil didReceiveData: extraData];
    NSString *combinedString = [[NSString alloc] initWithData: [nnCommunicator receivedData] encoding: NSUTF8StringEncoding];
    XCTAssertEqualObjects(combinedString, @"Result appended", @"Received data should be appended to the downloaded data");
}

@end
