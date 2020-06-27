//
//  TransformerCollectionViewCell.h
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 25/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransformerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamIconImagView;

@end

NS_ASSUME_NONNULL_END
