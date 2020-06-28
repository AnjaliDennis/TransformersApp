//
//  TransformerNetworkAPI.h
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 25/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransformerDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransformerNetworkAPI : NSObject
-(void) getTokenWithCompletionHandler:(void (^) (NSError *error)) completionBlock;
- (void)createTransformer: (TransformerDataModel *) transformerDataModel :(void (^) (NSDictionary *dataDictionary, NSError *error)) completionBlock;
-(void) getTransformerListWithCompletionHandler: (void (^) (NSDictionary *dataDictionary, NSError *error)) completionBlock;
- (void)deleteTransformer: (NSString *) transformerId :(void (^) (BOOL status)) completionBlock;
- (void)updateTransformer: (TransformerDataModel *) transformerDataModel :(void (^) (NSDictionary *dataDictionary, NSError *error)) completionBlock;
@property (nonatomic, strong, readonly) TransformerDataModel *transformerDataModel;

@end

NS_ASSUME_NONNULL_END
