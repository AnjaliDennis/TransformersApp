//
//  TransformerNetworkAPI.m
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 25/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import "TransformerNetworkAPI.h"

@implementation TransformerNetworkAPI

-(void) getToken {
NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://transformers-api.firebaseapp.com/allspark"]];

//create the Method "GET"
[urlRequest setHTTPMethod:@"GET"];

NSURLSession *session = [NSURLSession sharedSession];

NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
{
  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
  if(httpResponse.statusCode == 200)
  {
    NSError *parseError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    NSLog(@"The response is - %@",responseDictionary);
  }
  else
  {
    NSLog(@"Error");
  }
}];
[dataTask resume];
}

@end
