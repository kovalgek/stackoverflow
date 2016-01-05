//
//  Answer.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 17.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import "Answer.h"

@implementation Answer

- (NSComparisonResult)compare:(Answer *)otherAnswer
{
    if(self.accepted && !otherAnswer.accepted)
    {
        return NSOrderedAscending;
    } else if(!self.accepted && otherAnswer.accepted)
    {
        return NSOrderedDescending;
    }
    if(self.score > otherAnswer.score)
    {
        return NSOrderedAscending;
    }
    else if(self.score < otherAnswer.score)
    {
        return NSOrderedDescending;
    }
    else
    {
        return NSOrderedSame;
    }
}

@end
