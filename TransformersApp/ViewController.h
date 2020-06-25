//
//  ViewController.h
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 24/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransformerCollectionViewCell.h"

@interface ViewController : UIViewController <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *autobotCollectionView;
@property (strong, nonatomic) NSArray *nameArray;


@end

