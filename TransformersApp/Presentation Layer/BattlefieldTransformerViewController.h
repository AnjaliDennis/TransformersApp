//
//  BattlefieldTransformerViewController.h
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 28/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransformerDataModel.h"
#import "TransformerConstants.h"
#import "BattlefieldTransformerTableViewDatasourceAndDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BattlefieldTransformerViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIButton *startBattleButton;
@property (weak, nonatomic) IBOutlet UILabel *battlefieldBannerLabel;

@property (strong, nonatomic) NSMutableArray <TransformerDataModel *> *transformerDataModelArray;
@property (nonatomic) BOOL isSorted;
@property (nonatomic) BOOL isBattleComplete;
@property (nonatomic) BOOL isGameOVerByAnnihilation;
@property (weak, nonatomic) IBOutlet UITableView *transformerBattleTableView;
@property (strong, nonatomic) BattlefieldTransformerTableViewDatasourceAndDelegate *dataSource;
-(void) sortTransformers;

@end

NS_ASSUME_NONNULL_END
