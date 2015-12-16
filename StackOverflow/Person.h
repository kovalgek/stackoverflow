//
//  Person.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 16.12.15.
//  Copyright © 2015 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
- (instancetype) initWithName:(NSString *)name avatarLocation:(NSString *)avatarLocation;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *avatarURL;
@end
