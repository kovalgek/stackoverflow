//
//  MockStackOverflowCommunicator.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator : StackOverflowCommunicator
- (BOOL) wasAskedToFetchQuestions;
@end
