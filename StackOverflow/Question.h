//
//  Question.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 15.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Answer, Person;

@interface Question : NSObject
@property (nonatomic) NSInteger questionID;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic) NSInteger score;
@property (nonatomic, readonly) NSArray *answers;
@property (nonatomic, strong) Person *asker;
- (void)addAnswer:(Answer *)answer;
@end
