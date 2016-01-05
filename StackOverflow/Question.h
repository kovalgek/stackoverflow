//
//  Question.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 15.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Answer;

@interface Question : NSObject
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *title;
@property (nonatomic) int score;
@property (nonatomic, readonly) NSArray *answers;
- (void)addAnswer:(Answer *)answer;
@end
