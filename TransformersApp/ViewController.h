//
//  ViewController.h
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 24/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransformerCollectionViewCell.h"
#import "TransformerNetworkAPI.h"
#import "TransformerDataModel.h"
#import "BattlefieldTransformerViewController.h"
#import "TransformerConstants.h"

@interface ViewController : UIViewController <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *autobotCollectionView;

@property (strong, nonatomic) NSMutableArray <TransformerDataModel *> *transformerDataModelArray;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (nonatomic) BOOL isCellEditing;


@end

