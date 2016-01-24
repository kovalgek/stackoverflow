//
//  InspectableStackOverflowCommunicator.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 09.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface InspectableStackOverflowCommunicator : StackOverflowCommunicator
- (NSURL *)URLToFetch;
- (NSURLConnection *)currentURLConnection;
@end
