//
//  BattlefieldTransformerViewController.h
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 28/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BattlefieldTransformerTableViewCell.h"
#import "TransformerDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BattlefieldTransformerViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startBattleButton;
@property (weak, nonatomic) IBOutlet UILabel *battlefieldBannerLabel;

@property (strong, nonatomic) NSMutableArray <TransformerDataModel *> *transformerDataModelArray;
@property (strong, nonatomic) NSMutableArray <TransformerDataModel *> *sortedAutobotsDataModelArray;
@property (strong, nonatomic) NSMutableArray <TransformerDataModel *> *sortedDecepticonsDataModelArray;
@property (nonatomic) BOOL isSorted;
@property (nonatomic) BOOL isBattleComplete;
@property (nonatomic) BOOL isGameOVerByAnnhilation;
@property (weak, nonatomic) IBOutlet UITableView *transformerBattleTableView;

@end

NS_ASSUME_NONNULL_END
