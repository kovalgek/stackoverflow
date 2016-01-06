//
//  QuestionBuilder.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionBuilder : NSObject
- (NSArray *)questionsFromJSON: (NSString *)objectNotation
                         error: (NSError **)error;
@end
