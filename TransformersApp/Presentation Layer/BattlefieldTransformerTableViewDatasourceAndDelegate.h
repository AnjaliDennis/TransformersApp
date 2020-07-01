//
//  BattlefieldTransformerTableViewDatasourceAndDelegate.h
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 01/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TransformerDataModel.h"
#import "TransformerConstants.h"
#import "BattlefieldTransformerTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BattlefieldTransformerTableViewDatasourceAndDelegate : NSObject <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray <TransformerDataModel *> *transformerDataModelArray;
@property (strong, nonatomic) NSMutableArray <TransformerDataModel *> *sortedAutobotsDataModelArray;
@property (strong, nonatomic) NSMutableArray <TransformerDataModel *> *sortedDecepticonsDataModelArray;
@property (nonatomic) BOOL isBattleComplete;
@end

NS_ASSUME_NONNULL_END
