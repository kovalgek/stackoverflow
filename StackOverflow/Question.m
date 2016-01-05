//
//  Question.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 15.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import "Question.h"

@implementation Question
{
    NSMutableSet *answerSet;
}

- (instancetype)init
{
    if(self = [super init])
    {
        answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer
{
    [answerSet addObject:answer];
}

- (NSArray *)answers
{
    return [[answerSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

@end
