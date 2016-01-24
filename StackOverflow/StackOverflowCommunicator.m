//
//  StackOverflowCommunicator.m
//  StackOverflow
//
//  Created by Anton Kovalchuk on 05.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "StackOverflowCommunicator.h"

NSString *StackOverflowCommunicatorErrorDomain = @"StackOverflowCommunicatorErrorDomain";

@implementation StackOverflowCommunicator

@synthesize delegate;

- (void)fetchContentAtURL:(NSURL *)url
             errorHandler:(void (^)(NSError *))errorBlock
           successHandler:(void (^)(NSString *))successBlock
{
    fetchingURL = url;
    errorHandler = [errorBlock copy];
    successHandler = [successBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL: fetchingURL];
    
    [self launchConnectionForRequest: request];
}

- (void)launchConnectionForRequest: (NSURLRequest *)request
{
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest: request delegate: self];
}

- (void)searchForQuestionsForTag:(NSString *)tag
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?pagesize=20&order=desc&sort=activity&tagged=%@&site=stackoverflow",tag]]
               errorHandler: ^(NSError *error) {
                   [delegate searchingForQuestionsFailedWithError: error];
               }
             successHandler: ^(NSString *objectNotation) {
                 [delegate receivedQuestionsJSON: objectNotation];
             }];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions/%ld?site=stackapps&filter=withbody",(long)identifier]]
               errorHandler: ^(NSError *error) {
        //[delegate searchingForQuestionsFailedWithError: error];
    }
             successHandler: ^(NSString *objectNotation) {
                 //       [delegate receivedQuestionsJSON: objectNotation];
             }];
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions/%ld/answers?order=desc&sort=activity&site=stackoverflow",(long)identifier]]errorHandler: ^(NSError *error) {
        //[delegate searchingForQuestionsFailedWithError: error];
    }
             successHandler: ^(NSString *objectNotation) {
                 //       [delegate receivedQuestionsJSON: objectNotation];
             }];
}

- (void)cancelAndDiscardURLConnection
{
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ([httpResponse statusCode] != 200)
    {
        NSError *error = [NSError errorWithDomain: StackOverflowCommunicatorErrorDomain
                                             code: [httpResponse statusCode]
                                         userInfo: nil];
        errorHandler(error);
        [self cancelAndDiscardURLConnection];
    }
    else
    {
        receivedData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    receivedData = nil;
    fetchingConnection = nil;
    fetchingURL = nil;
    errorHandler(error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    fetchingConnection = nil;
    fetchingURL = nil;
    NSString *receivedText = [[NSString alloc] initWithData: receivedData
                                                   encoding: NSUTF8StringEncoding];
    receivedData = nil;
    successHandler(receivedText);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData: data];
}

@end
