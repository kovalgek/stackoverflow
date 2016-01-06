//
//  MockStackOverflowManagerDelegate.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"

@interface MockStackOverflowManagerDelegate : NSObject <StackOverflowManagerDelegate>
@property (strong, nonatomic) NSError *fetchError;
@property (strong, nonatomic) NSArray *receivedQuestions;
@end
