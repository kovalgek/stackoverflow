//
//  PersonTests.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 16.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTests : XCTestCase
{
    Person *person;
}
@end

@implementation PersonTests

- (void)setUp
{
    [super setUp];
    person = [[Person alloc] initWithName:@"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
}

- (void)tearDown
{
    person = nil;
    [super tearDown];
}

- (void) testThatPersonHasTheRightName
{
    XCTAssertEqualObjects(person.name, @"Graham Lee", @"Person should know its name");
}

- (void) testThatPersonHasAnAvatarUrl
{
    NSURL *url = person.avatarURL;
    XCTAssertEqualObjects([url absoluteString], @"http://example.com/avatar.png", @"The Person's avatar should be represented by its url");
}


@end
