//
//  NonNetworkedStackOverflowCommunicator.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 12.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "NonNetworkedStackOverflowCommunicator.h"

@implementation NonNetworkedStackOverflowCommunicator

- (void)launchConnectionForRequest: (NSURLRequest *)request
{
    
}

- (void)setReceivedData:(NSData *)data
{
    receivedData = [data mutableCopy];
}

- (NSData *)receivedData
{
    return [receivedData copy];
}


@end
