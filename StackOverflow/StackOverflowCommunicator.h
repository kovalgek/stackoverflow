//
//  StackOverflowCommunicator.h
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

@interface StackOverflowCommunicator : NSObject <NSURLConnectionDataDelegate>
{
@protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
    NSMutableData *receivedData;
@private
    id <StackOverflowCommunicatorDelegate> __weak delegate;
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
}

@property (nonatomic, weak) id<StackOverflowCommunicatorDelegate> delegate;

- (void)searchForQuestionsForTag:(NSString *)tag;
- (void)downloadInformationForQuestionWithID:(NSInteger)identifier;
- (void)downloadAnswersToQuestionWithID: (NSInteger)identifier;
- (void)cancelAndDiscardURLConnection;

@end
