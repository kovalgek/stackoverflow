//
//  FakeQuestionBuilder.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "QuestionBuilder.h"

@interface FakeQuestionBuilder : QuestionBuilder
@property (copy, nonatomic) NSString *JSON;
@property (copy, nonatomic) NSArray *arrayToReturn;
@property (copy, nonatomic) NSError *errorToSet;
@property (strong, nonatomic) Question *questionToFill;
@end
