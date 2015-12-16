//
//  TopicTests.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 15.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Topic.h"
#import "Question.h"

@interface TopicTests : XCTestCase
{
    Topic *topic;
}
@end

@implementation TopicTests

- (void)setUp
{
    [super setUp];
    topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
}

- (void)tearDown
{
    topic = nil;
    [super tearDown];
}

- (void)testThatTopicExists
{
    XCTAssertNotNil(topic,@"Should be able to create topc instance");
}

- (void) testThatTopicCanBeNamed
{
    XCTAssertEqualObjects(topic.name, @"iPhone",@"The Topic should have the name I gave it");
}

- (void) testThatTopicHasATag
{
    XCTAssertEqualObjects(topic.tag, @"iphone",@"Topic needs to have a tag");
}

- (void) testForAListOfQuestions
{
    XCTAssertTrue([[topic recentQuestions] isKindOfClass:[NSArray class]], @"Topics should provide a list of recent questions");
}

- (void) testForInititallyEmptyQuestionList
{
    XCTAssertEqual([[topic recentQuestions] count], (NSUInteger)0, @"No questions added yet, count should be zero");
}

- (void) testAddingAQuestionToTheList
{
    Question *question = [[Question alloc] init];
    [topic addQuestion:question];
    XCTAssertEqual([[topic recentQuestions] count], (NSUInteger)1, @"Add a question, and the count of questions should go up");
}

- (void) testQuestionAreListedChronologically
{
    Question *q1 = [[Question alloc] init];
    q1.date = [NSDate distantPast];
    
    Question *q2 = [[Question alloc] init];
    q2.date = [NSDate distantFuture];
    
    [topic addQuestion:q1];
    [topic addQuestion:q2];
    
    NSArray *questions = [topic recentQuestions];
    Question *listedFirst  = questions[0];
    Question *listedSecond = questions[1];
    
    XCTAssertEqualObjects([listedFirst.date laterDate:listedSecond.date], listedFirst.date, @"The later question should appear first in the list");
}

- (void)testLimitOfTwentyQuestions
{
    Question *q1 = [[Question alloc] init];
    for(NSInteger i = 0; i < 25; ++i)
    {
        [topic addQuestion:q1];
    }
    XCTAssertTrue([[topic recentQuestions] count] < 21, @"There should never be more than twenty questions");
}

@end
