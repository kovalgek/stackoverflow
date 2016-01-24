//
//  NonNetworkedStackOverflowCommunicator.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 12.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface NonNetworkedStackOverflowCommunicator : StackOverflowCommunicator

- (void)launchConnectionForRequest: (NSURLRequest *)request;
@property (nonatomic, copy) NSData *receivedData;

@end
