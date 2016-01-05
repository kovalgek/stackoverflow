//
//  Answer.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 17.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface Answer : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) Person *person;
@property (nonatomic) int score;
@property (nonatomic, getter=isAccepted) BOOL accepted;
- (NSComparisonResult)compare:(Answer *)otherAnswer;
@end
