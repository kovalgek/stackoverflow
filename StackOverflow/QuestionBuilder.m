//
//  QuestionBuilder.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

@implementation QuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation
                         error:(NSError **)error
{
    NSParameterAssert(objectNotation != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    NSDictionary *parsedObject = (id)jsonObject;
    if(parsedObject == nil)
    {
        if (error != NULL)
        {
            *error = [NSError errorWithDomain: QuestionBuilderErrorDomain
                                         code: QuestionBuilderInvalidJSONError
                                     userInfo: nil];
        }
        return nil;
    }
    NSArray *questions = [parsedObject objectForKey:@"items"];
    if(questions == nil)
    {
        if (error != NULL)
        {
            *error = [NSError errorWithDomain: QuestionBuilderErrorDomain
                                         code: QuestionBuilderMissingDataError
                                     userInfo: nil];
        }
        return nil;
    }
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity: [questions count]];
    for (NSDictionary *parsedQuestion in questions)
    {
        Question *thisQuestion = [[Question alloc] init];
        thisQuestion.questionID = [[parsedQuestion objectForKey: @"question_id"] integerValue];
        thisQuestion.date = [NSDate dateWithTimeIntervalSince1970: [[parsedQuestion objectForKey: @"creation_date"] doubleValue]];
        thisQuestion.title = [parsedQuestion objectForKey: @"title"];
        thisQuestion.score = [[parsedQuestion objectForKey: @"score"] integerValue];
        
        NSDictionary *ownerValues = [parsedQuestion objectForKey: @"owner"];
        thisQuestion.asker = [[Person alloc] initWithName:[ownerValues objectForKey:@"display_name"] avatarLocation:[ownerValues objectForKey:@"profile_image"]];
        [results addObject: thisQuestion];
    }
    return [results copy];
}

- (void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation
{
    NSParameterAssert(question != nil);
    NSParameterAssert(objectNotation != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData: unicodeNotation options: 0 error: NULL];
    if (![parsedObject isKindOfClass: [NSDictionary class]]) {
        return;
    }
    NSString *questionBody = [[[parsedObject objectForKey: @"items"] lastObject] objectForKey: @"body"];
    if (questionBody)
    {
        question.body = questionBody;
    }
}

@end

NSString *QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";