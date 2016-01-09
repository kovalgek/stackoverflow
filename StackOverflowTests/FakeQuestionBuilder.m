//
//  FakeQuestionBuilder.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "FakeQuestionBuilder.h"

@implementation FakeQuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    self.JSON = objectNotation;
    if (error)
    {
        *error = _errorToSet;
    }
    return _arrayToReturn;
}

- (void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation
{
    self.questionToFill = question;
    self.JSON = objectNotation;
}

@end
