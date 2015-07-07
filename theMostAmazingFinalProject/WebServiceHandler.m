//
//  WebServiceHandler.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/28/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WebServiceHandler.h"

@implementation WebServiceHandler

#pragma mark
#pragma mark  Initialization Methods

-(id)initWithDelegate:(id <WebServiceHandlerDelegate>)del
{
    self = [super init];
    if(self)
    {
        delegate = del;
    }
    return self;
}

#pragma mark
#pragma mark  Public Methods

-(void)doRequest:(NSString *)urlSite withParameters:(NSDictionary *)parameters andHeaders:(NSDictionary *)headers andHTTPMethod:(NSString *)method
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlSite]];
    if (parameters)
    {
        NSError *parameterParsingError;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&parameterParsingError];
        [request setHTTPBody:jsonData];
        NSString *json = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        NSLog(@"%@",json);
    }
    if (headers)
    {
        [self setHeaders:headers forRequest:request];
    }
    request.timeoutInterval = 12;
    [request setHTTPMethod:method];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         NSLog(@"HTTP Response code: %ld", [httpResponse statusCode]);
         if ((error==nil) && (data) && ([httpResponse statusCode]==200 || [httpResponse statusCode]==201))
         {
             [delegate webServiceCallFinished:data];
         }
         else
         {
             if (data) {
                 NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 NSLog(@"%@",json);
             }
             [delegate webServiceCallError:error];
         }
     }];
}

-(void)setHeaders:(NSDictionary *)headers forRequest:(NSMutableURLRequest *)resquest
{
    for (NSString *key in headers.allKeys)
    {
        [resquest setValue:[headers objectForKey:key] forHTTPHeaderField:key];
    }
}

@end