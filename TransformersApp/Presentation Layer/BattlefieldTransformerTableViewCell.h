//
//  BattlefieldTransformerTableViewCell.h
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 28/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BattlefieldTransformerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *autobotNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *decepticonNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *autobotTeamIcon;
@property (weak, nonatomic) IBOutlet UIImageView *decepticonTeamIcon;
@property (weak, nonatomic) IBOutlet UILabel *autobotRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *decepticonRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *autobotStatsLabel;
@property (weak, nonatomic) IBOutlet UILabel *decepticonStatsLabel;
@property (weak, nonatomic) IBOutlet UILabel *autobotResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *decepticonResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *autobotRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *decepticonRankLabel;

@end

NS_ASSUME_NONNULL_END
