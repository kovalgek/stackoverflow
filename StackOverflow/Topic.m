//
//  Topic.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 15.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

@interface Topic()
{
    NSArray *questions;
}
@end

@implementation Topic

- (instancetype)initWithName:(NSString *)name
                         tag:(NSString *)tag
{
    if(self = [super init])
    {
        _name = [name copy];
        _tag  = [tag copy];
        questions = [[NSArray alloc] init];
    }
    return self;
}

- (void)addQuestion:(Question *)question
{
    NSArray *newQuestions = [questions arrayByAddingObject:question];
    if(newQuestions.count > 20)
    {
        newQuestions = [self sorterQuestionLatestFirst:newQuestions];
        newQuestions = [newQuestions subarrayWithRange:NSMakeRange(0, 20)];
    }
    questions = newQuestions;
}

- (NSArray *)recentQuestions
{
    return [self sorterQuestionLatestFirst:questions];
}

- (NSArray *)sorterQuestionLatestFirst:(NSArray *)questionList
{
    return [questions sortedArrayUsingComparator:^(id obj1, id obj2){
        Question *q1 = (Question *)obj1;
        Question *q2 = (Question *)obj2;
        return [q2.date compare:q1.date];
    }];
}

@end
