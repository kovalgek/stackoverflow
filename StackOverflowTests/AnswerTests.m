//
//  AnswerTests.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 17.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"
#import "Answer.h"

@interface AnswerTests : XCTestCase
{
    Answer *answer;
    Answer *otherAnswer;
}
@end

@implementation AnswerTests

- (void)setUp
{
    [super setUp];
    answer = [[Answer alloc] init];
    answer.text = @"The answer is 42";
    answer.person = [[Person alloc] initWithName:@"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    answer.score = 42;
    
    otherAnswer = [[Answer alloc] init];
    otherAnswer.text = @"What are you doing?";
    otherAnswer.score = 42;
}

- (void)tearDown
{
    answer = nil;
    [super tearDown];
}

- (void) testAnswerHasSomeText
{
    XCTAssertEqualObjects(answer.text, @"The answer is 42", @"Answer need to contain some text");
}

- (void) testSomeoneProvidedTheAnswer
{
    XCTAssertTrue([answer.person isKindOfClass:[Person class]], @"A Person gave this answer");
}

- (void) testAnswerHasAScore
{
    XCTAssertTrue(answer.score == 42, @"Answer's score can be retrieved");
}

- (void) testAnswerNotAcceptedByDefault
{
    XCTAssertFalse(answer.accepted, @"Answer not accepted by default");
}

- (void) testAnswerCanBeAccepted
{
    XCTAssertNoThrow(answer.accepted = YES, @"It's possible to accept an answer");
}

- (void) testAcceptedAnswerComesBeforeUnaccepted
{
    otherAnswer.accepted = YES;
    otherAnswer.score = answer.score + 10;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending, @"Accepted answer should come first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending, @"Unaccepted answer should come last");
}

- (void) testAnswersWithEqualScoresCompareEqually
{
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedSame, @"Both answers are equal rank");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedSame, @"Both answers are equal rank");
}

- (void) testLoverScoringAnswerComesAfterHigher
{
    otherAnswer.score = answer.score + 10;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending, @"Higher score comes first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending, @"Lover score come last");

}

@end
