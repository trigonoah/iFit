//
//  WebServiceHandler.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 5/28/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceHandlerDelegate <NSURLConnectionDelegate>

-(void)webServiceCallFinished:(id)data;
-(void)webServiceCallError:(NSError *)error;

@end

@interface WebServiceHandler : NSObject
{
    
    id<WebServiceHandlerDelegate> delegate;
}

-(id)initWithDelegate:(id <WebServiceHandlerDelegate>)del;

-(void)doRequest:(NSString *)urlSite withParameters:(NSDictionary *)parameters andHeaders:(NSDictionary *)headers andHTTPMethod:(NSString *)method;

@end
