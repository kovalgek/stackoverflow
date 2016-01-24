//
//  StackOverflowCommunicatorDelegate.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 12.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StackOverflowCommunicatorDelegate <NSObject>

- (void)searchingForQuestionsFailedWithError: (NSError *)error;
- (void)receivedQuestionsJSON: (NSString *)objectNotation;

@end
