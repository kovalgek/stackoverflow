//
//  QuestionBuilderTests.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 06.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

static NSString *stringIsNotJSON = @"Not JSON";
static NSString *noQuestionsJSONString = @"{ \"noitems\": true }";
static NSString *emptyQuestionsArray = @"{ \"items\": [] }";

@interface QuestionBuilderTests : XCTestCase
{
    QuestionBuilder *questionBuilder;
    Question *question;
    NSString *questionJSON;
}
@end

@implementation QuestionBuilderTests

- (void)setUp
{
    [super setUp];
    questionBuilder = [[QuestionBuilder alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"questionJSON" ofType:@"json"];
    questionJSON = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    question = [[questionBuilder questionsFromJSON:questionJSON error:NULL] objectAtIndex:0];
}

- (void)tearDown
{
    questionBuilder = nil;
    question = nil;
    questionJSON = nil;
    [super tearDown];
}

- (void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([questionBuilder questionsFromJSON: nil error: NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON
{
    XCTAssertNil([questionBuilder questionsFromJSON: @"Not JSON" error: NULL], @"This parameter should not be parsable");
}

- (void)testErrorSetWhenStringIsNotJSON
{
    NSError *error = nil;
    [questionBuilder questionsFromJSON:@"Not JSON" error: &error];
    XCTAssertNotNil(error, @"An error occurred, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash
{
    XCTAssertNoThrow([questionBuilder questionsFromJSON: @"Not JSON"
                                                  error: NULL],
                     @"Using a NULL error parameter should not be a problem");
}

- (void) testRealJSONWithoutItemsArrayIsError
{
    NSString *jsonString = @"{\"noitems\" : true}";
    NSError *error = nil;
    [questionBuilder questionsFromJSON:jsonString error:&error];
    XCTAssertEqual([error code], QuestionBuilderMissingDataError, @"This case shouldn't be an invalid JSON error");
}

- (void) testJSONWithOneQuestionReturnsOneQuestionObject
{
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON:questionJSON error:&error];
    XCTAssertEqual([questions count], (NSUInteger)1, @"The builder should have created a question");
}

- (void) testQuestionCreatedFromJSONHasPropertiesPresentedInJSON
{
    XCTAssertEqual(question.questionID, 34638696, @"The question ID should match the data we sent");
    XCTAssertEqual([question.date timeIntervalSince1970], (NSTimeInterval)1452100069, @"The date of the question should match the data");
    XCTAssertEqualObjects(question.title, @"Excel trying to use an equation to call value from different column", @"Title should match the provided data");
    XCTAssertEqual(question.score, 0, @"Score should match the data");
    
    Person *asker = question.asker;
    XCTAssertEqualObjects(asker.name, @"k. smith", @"Looks like I should have asked this question");
    XCTAssertEqualObjects([asker.avatarURL absoluteString], @"https://www.gravatar.com/avatar/a3aa7d8a2a3e2a9a54ee5a5f0a6cc8e4?s=128&d=identicon&r=PG&f=1", @"The avatar URL should be based on the supplied email hash");
}

- (void)testQuestionCreatedFromEmptyObjectIsStillValidObject
{
    NSString *emptyQuestion = @"{ \"items\": [ {} ] }";
    NSArray *questions = [questionBuilder questionsFromJSON: emptyQuestion error: NULL];
    XCTAssertEqual([questions count], (NSUInteger)1, @"QuestionBuilder must handle partial input");
}

- (void)testBuildingQuestionBodyWithNoDataCannotBeTried
{
    XCTAssertThrows([questionBuilder fillInDetailsForQuestion: question fromJSON: nil], @"Not receiving data should have been handled earlier");
}

- (void)testBuildingQuestionBodyWithNoQuestionCannotBeTried
{
    XCTAssertThrows([questionBuilder fillInDetailsForQuestion: nil fromJSON: questionJSON], @"No reason to expect that a nil question is passed");
}

- (void)testNonJSONDataDoesNotCauseABodyToBeAddedToAQuestion
{
    [questionBuilder fillInDetailsForQuestion: question fromJSON: stringIsNotJSON];
    XCTAssertNil(question.body, @"Body should not have been added");
}

- (void)testJSONWhichDoesNotContainABodyDoesNotCauseBodyToBeAdded
{
    [questionBuilder fillInDetailsForQuestion: question fromJSON: noQuestionsJSONString];
    XCTAssertNil(question.body, @"There was no body to add");
}

- (void)testBodyContainedInJSONIsAddedToQuestion
{
    [questionBuilder fillInDetailsForQuestion: question fromJSON:questionJSON];
    XCTAssertEqualObjects(question.body, @"<p>I've been trying to use persistent keychain references.</p>", @"The correct question body is added");
}

- (void)testEmptyQuestionsArrayDoesNotCrash
{
    XCTAssertNoThrow([questionBuilder fillInDetailsForQuestion: question fromJSON: emptyQuestionsArray], @"Don't throw if no questions are found");
}

@end
