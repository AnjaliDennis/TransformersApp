//
//  TransformerNetworkAPI.m
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 25/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import "TransformerNetworkAPI.h"

@implementation TransformerNetworkAPI

-(id) init {
    NSURL *url = [NSURL URLWithString:CONSTANT_URL_TOKEN_OK];
    self.jwtProtectionSpace = [[NSURLProtectionSpace alloc] initWithHost:url.host port:[url.port integerValue] protocol:url.scheme realm:nil authenticationMethod:NSURLAuthenticationMethodHTTPDigest];
    return self;
}

-(void) getTokenWithCompletionHandler:(void (^) (NSError *error)) completionBlock  {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:CONSTANT_URL_TOKEN_OK]];
    [urlRequest setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSString *jwt = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSURLCredential *credential = [NSURLCredential credentialWithUser:@"" password:jwt persistence:NSURLCredentialPersistencePermanent];
            [[NSURLCredentialStorage sharedCredentialStorage] setCredential:credential forProtectionSpace:self.jwtProtectionSpace];
            completionBlock(nil);
        }
        else
        {
            completionBlock(error);
        }
    }];
    [dataTask resume];
}

- (void)createTransformer: (TransformerDataModel *) transformerDataModel :(void (^) (NSDictionary *dataDictionary, NSError *error)) completionBlock{
    NSString *jwt = [self retrieveJwt];
    NSString *urlString = CONSTANT_URL;
    NSString *jwtForHeader = [@"Bearer " stringByAppendingString:jwt];
    NSDictionary *jsonBodyDict = @{CONSTANT_NAME_KEY_STRING:transformerDataModel.name, CONSTANT_STRENGTH_KEY_STRING:transformerDataModel.strength, CONSTANT_INTELLIGENCE_KEY_STRING:transformerDataModel.intelligence, CONSTANT_SPEED_KEY_STRING:transformerDataModel.speed, CONSTANT_ENDURANCE_KEY_STRING:transformerDataModel.endurance, CONSTANT_RANK_KEY_STRING:transformerDataModel.rank, CONSTANT_COURAGE_KEY_STRING:transformerDataModel.courage, CONSTANT_FIREPOWER_KEY_STRING:transformerDataModel.firepower, CONSTANT_SKILL_KEY_STRING:transformerDataModel.skill, CONSTANT_TEAM_KEY_STRING:transformerDataModel.team};
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
            if (error == nil) {
                NSError *error = [NSError errorWithDomain:@"com.transformers.createtransformer" code:httpResponse.statusCode userInfo:@{@"Error reason": @"Unexpected error"}];
                completionBlock (nil, error);
            }
            else {
                 completionBlock (nil, error);
            }
        }
    }];
    [task resume];
}

-(void) getTransformerListWithCompletionHandler: (void (^) (NSDictionary *dataDictionary, NSError *error)) completionBlock  {
    NSString *jwt = [self retrieveJwt];
    NSString *urlString = CONSTANT_URL;
    NSString *jwtForHeader = [@"Bearer " stringByAppendingString:jwt];
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
    NSString *jwt = [self retrieveJwt];
    NSString *urlString = [CONSTANT_URL stringByAppendingFormat:@"/%@",transformerId];
    NSString *jwtForHeader = [@"Bearer " stringByAppendingString:jwt];
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
    NSString *jwt = [self retrieveJwt];
    NSString *urlString = CONSTANT_URL;
    NSString *jwtForHeader = [@"Bearer " stringByAppendingString:jwt];
    NSDictionary *jsonBodyDict = @{CONSTANT_ID_KEY_STRING:transformerDataModel.transformerId, CONSTANT_NAME_KEY_STRING:transformerDataModel.name, CONSTANT_STRENGTH_KEY_STRING:transformerDataModel.strength, CONSTANT_INTELLIGENCE_KEY_STRING:transformerDataModel.intelligence, CONSTANT_SPEED_KEY_STRING:transformerDataModel.speed, CONSTANT_ENDURANCE_KEY_STRING:transformerDataModel.endurance, CONSTANT_RANK_KEY_STRING:transformerDataModel.rank, CONSTANT_COURAGE_KEY_STRING:transformerDataModel.courage, CONSTANT_FIREPOWER_KEY_STRING:transformerDataModel.firepower, CONSTANT_SKILL_KEY_STRING:transformerDataModel.skill, CONSTANT_TEAM_KEY_STRING:transformerDataModel.team};
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

-(NSString *) retrieveJwt {
    NSDictionary *credentials = [[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:self.jwtProtectionSpace];
    NSURLCredential *credential = [credentials.objectEnumerator nextObject];
    return credential.password;
}

@end
