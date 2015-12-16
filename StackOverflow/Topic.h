//
//  Topic.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 15.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface Topic : NSObject
@property (readonly) NSString *name;
@property (readonly) NSString *tag;
- (instancetype)initWithName:(NSString *)name tag:(NSString *)tag;
- (void)addQuestion:(Question *)question;
- (NSArray *)recentQuestions;
@end
