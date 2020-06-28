//
//  TransformerNetworkAPI.m
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 25/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import "TransformerNetworkAPI.h"

@implementation TransformerNetworkAPI

-(void) getTokenWithCompletionHandler:(void (^) (NSError *error)) completionBlock  {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://transformers-api.firebaseapp.com/allspark"]];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSString *jwt = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            [[NSUserDefaults standardUserDefaults] setObject:jwt forKey:@"jwt"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            completionBlock(nil);
        }
        else
        {
            NSLog(@"Error");
            completionBlock(error);
        }
    }];
    [dataTask resume];
}

- (void)createTransformer: (TransformerDataModel *) transformerDataModel :(void (^) (NSDictionary *dataDictionary, NSError *error)) completionBlock{
    
    NSString *urlString = @"https://transformers-api.firebaseapp.com/transformers";
    NSString *jwtForHeader = [@"Bearer " stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"jwt"]];
    NSDictionary *jsonBodyDict = @{@"name":transformerDataModel.name, @"strength":transformerDataModel.strength, @"intelligence":transformerDataModel.intelligence, @"speed":transformerDataModel.speed, @"endurance":transformerDataModel.endurance, @"rank":transformerDataModel.rank, @"courage":transformerDataModel.courage, @"firepower":transformerDataModel.firepower, @"skill":transformerDataModel.skill, @"team":transformerDataModel.team};
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    
    [request setURL:[NSURL URLWithString:urlString]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:jwtForHeader forHTTPHeaderField:@"Authorization"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonBodyData];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if(httpResponse.statusCode == 201)
        {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            completionBlock (jsonDictionary, nil);
        }
        else {
            completionBlock (nil, error);
        }
    }];
    [task resume];
}

-(void) getTransformerListWithCompletionHandler: (void (^) (NSDictionary *dataDictionary, NSError *error)) completionBlock  {
    NSString *urlString = @"https://transformers-api.firebaseapp.com/transformers";
    NSString *jwtForHeader = [@"Bearer " stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"jwt"]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"GET";
    
    [request setURL:[NSURL URLWithString:urlString]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:jwtForHeader forHTTPHeaderField:@"Authorization"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if(httpResponse.statusCode == 200)
        {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            completionBlock (jsonDictionary, nil);
        }
        else {
            completionBlock (nil, error);
        }
    }];
    [task resume];
}

- (void)deleteTransformer: (NSString *) transformerId :(void (^) (BOOL status)) completionBlock{
    
    NSString *urlString = [@"https://transformers-api.firebaseapp.com/transformers/" stringByAppendingFormat:@"%@",transformerId];
    NSString *jwtForHeader = [@"Bearer " stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"jwt"]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"DELETE";
    
    [request setURL:[NSURL URLWithString:urlString]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:jwtForHeader forHTTPHeaderField:@"Authorization"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if(httpResponse.statusCode == 204)
        {
            completionBlock (YES);
        }
        else {
            completionBlock (NO);
        }
    }];
    [task resume];
}

- (void)updateTransformer: (TransformerDataModel *) transformerDataModel :(void (^) (NSDictionary *dataDictionary, NSError *error)) completionBlock{
    NSString *urlString = @"https://transformers-api.firebaseapp.com/transformers";
    NSString *jwtForHeader = [@"Bearer " stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"jwt"]];
    NSDictionary *jsonBodyDict = @{@"id":transformerDataModel.transformerId, @"name":transformerDataModel.name, @"strength":transformerDataModel.strength, @"intelligence":transformerDataModel.intelligence, @"speed":transformerDataModel.speed, @"endurance":transformerDataModel.endurance, @"rank":transformerDataModel.rank, @"courage":transformerDataModel.courage, @"firepower":transformerDataModel.firepower, @"skill":transformerDataModel.skill, @"team":transformerDataModel.team};
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"PUT";
    
    [request setURL:[NSURL URLWithString:urlString]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:jwtForHeader forHTTPHeaderField:@"Authorization"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonBodyData];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if(httpResponse.statusCode == 200)
        {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            completionBlock (jsonDictionary, nil);
        }
        else {
            completionBlock (nil, error);
        }
    }];
    [task resume];
}

@end
