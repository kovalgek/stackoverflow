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
#import "Person.h"

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
    question.questionID = 17;
    question.date = [NSDate distantPast];
    question.title = @"test title";
    question.body = @"test body";
    question.score = 42;
    question.asker = [[Person alloc] initWithName:@"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    
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

- (void) testQuestionHasABody
{
    XCTAssertEqualObjects(question.body, @"test body", @"Question should know its body");
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

- (void) testQuestionHasIdentity
{
    XCTAssertEqual(question.questionID, 17, @"Questions need a numeric identifier");
}

- (void) testQuestionHasAnAsker
{
    XCTAssertTrue([question.asker isKindOfClass:[Person class]], @"Question should have an asker");
}

@end
