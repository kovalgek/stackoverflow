//
//  QuestionTests.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 15.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "Answer.h"

@interface QuestionTests : XCTestCase
{
    Question *question;
    Answer *accepted;
    Answer *highScore;
    Answer *lowScore;
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
    
    accepted = [[Answer alloc] init];
    accepted.accepted = YES;
    accepted.score = 1;
    [question addAnswer:accepted];
    
    highScore = [[Answer alloc] init];
    highScore.score = 4;
    [question addAnswer:highScore];
    
    
    lowScore = [[Answer alloc] init];
    lowScore.score = 1;
    [question addAnswer:lowScore];
    
}

- (void)tearDown
{
    question = nil;
    accepted = nil;
    highScore = nil;
    lowScore = nil;
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

- (void) testQuestionCanHaveAnswersAdded
{
    Answer *answer = [[Answer alloc] init];
    XCTAssertNoThrow([question addAnswer:answer], @"Must be able to add answer");
}

- (void) testAcceptedAnswerIsFirst
{
    XCTAssertTrue([[question.answers objectAtIndex:0] isAccepted], @"Accepted answer comes first");
}

- (void) testHightScoreAnswerBeforeLow
{
    NSArray *answers = question.answers;
    NSInteger highIndex = [answers indexOfObject:highScore];
    NSInteger lowIndex = [answers indexOfObject:lowScore];
    XCTAssertTrue(highIndex < lowIndex, @"Hight score answer comes first");
}

@end
