//
//  StackOverflowManagerDelegate.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;

@protocol StackOverflowManagerDelegate <NSObject>
- (void)fetchingQuestionsOnTopic:(Topic *)topic
                 failedWithError:(NSError *)error;
- (void)didReceiveQuestions: (NSArray *)questions;
@end
