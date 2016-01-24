//
//  InspectableStackOverflowCommunicator.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 09.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "InspectableStackOverflowCommunicator.h"

@implementation InspectableStackOverflowCommunicator

- (NSURL *)URLToFetch
{
    return fetchingURL;
}

- (NSURLConnection *)currentURLConnection
{
    return fetchingConnection;
}

@end
