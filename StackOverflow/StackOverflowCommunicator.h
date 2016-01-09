//
//  StackOverflowCommunicator.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowCommunicator : NSObject

- (void)searchForQuestionsForTag:(NSString *)tag;
- (void)downloadInformationForQuestionWithID:(NSInteger)identifier;

@end
