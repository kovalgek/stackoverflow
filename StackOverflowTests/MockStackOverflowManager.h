//
//  MockStackOverflowManager.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 12.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

@interface MockStackOverflowManager : NSObject <StackOverflowCommunicatorDelegate>
{
    NSInteger topicFailureErrorCode;
    NSString *topicSearchString;
}

- (NSInteger)topicFailureErrorCode;
- (NSString *)topicSearchString;

@property (strong) id delegate;

@end
