//
//  QuestionTests.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 15.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"

@interface QuestionTests : XCTestCase
{
    Question *question;
}
@end

@implementation QuestionTests

- (void)setUp
{
    [super setUp];
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"test title";
    question.score = 42;
}

- (void)tearDown
{
    question = nil;
    [super tearDown];
}

- (void) testQuestionHasADate
{
    NSDate *distantPast = [NSDate distantPast];
    question.date = distantPast;
    XCTAssertEqualObjects(question.date, distantPast, @"Question needs to provide its date");
}

- (void) testQuestionHasATitle
{
    XCTAssertEqualObjects(question.title, @"test title", @"Question should know its title");
}

- (void) testQuestionsKeepScore
{
    XCTAssertEqual(question.score, 42, @"Questions need a numeric score");
}

@end
