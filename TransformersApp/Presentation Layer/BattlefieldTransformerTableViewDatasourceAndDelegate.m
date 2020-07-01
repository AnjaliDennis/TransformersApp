//
//  BattlefieldTransformerTableViewDatasourceAndDelegate.m
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 01/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import "BattlefieldTransformerTableViewDatasourceAndDelegate.h"

@implementation BattlefieldTransformerTableViewDatasourceAndDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BattlefieldTransformerTableViewCellReuseIdentifier";
    BattlefieldTransformerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSURL *imageUrlDecepticon = [NSURL URLWithString:CONSTANT_URL_DECEPTICON_TEAMICON];
    NSData *imageDataDecepticon = [NSData dataWithContentsOfURL:imageUrlDecepticon];
    UIImage *placeholerImageDecepticon = [UIImage imageWithData: imageDataDecepticon];
    NSURL *imageUrlAutobot = [NSURL URLWithString:CONSTANT_URL_AUTOBOT_TEAMICON];
    NSData *imageDataAutobot = [NSData dataWithContentsOfURL:imageUrlAutobot];
    UIImage *placeholerImageAutobot = [UIImage imageWithData: imageDataAutobot];

    if (self.sortedAutobotsDataModelArray.count <= indexPath.row) {
        cell.autobotNameLabel.text = CONSTANT_UNAVAILABLE_STRING;
        cell.autobotRatingLabel.text = CONSTANT_RATING_UNAVAILABLE_STRING;
        cell.autobotStatsLabel.text = CONSTANT_STATS_UNAVAILABLE_STRING;
        cell.autobotRankLabel.text = CONSTANT_RANK_UNAVAILABLE_STRING;
        cell.autobotResultLabel.text = self.isBattleComplete ? CONSTANT_BATTLE_MISSED_STRING : CONSTANT_COMMENCE_BATTLE_STRING;
        cell.autobotTeamIcon.image = placeholerImageAutobot;
    }
    else  {
        TransformerDataModel *autobotDataModel = [self.sortedAutobotsDataModelArray objectAtIndex:indexPath.row];
        cell.autobotNameLabel.text = autobotDataModel.name;
        NSURL *imageUrlAutobot = [NSURL URLWithString:autobotDataModel.team_icon];
        NSData *imageDataAutobot = [NSData dataWithContentsOfURL:imageUrlAutobot];
        cell.autobotTeamIcon.image = [UIImage imageWithData: imageDataAutobot];
        cell.autobotRatingLabel.text = [CONSTANT_RATING_STRING stringByAppendingString:autobotDataModel.rating];
        NSString *statsString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@",autobotDataModel.strength,autobotDataModel.intelligence,autobotDataModel.speed,autobotDataModel.endurance,autobotDataModel.rank,autobotDataModel.courage,autobotDataModel.firepower,autobotDataModel.skill];
        cell.autobotStatsLabel.text = [CONSTANT_STATS_STRING stringByAppendingString:statsString];
        cell.autobotRankLabel.text = [CONSTANT_RANK_STRING stringByAppendingString:autobotDataModel.rank];
        if (self.isBattleComplete) {
            if (autobotDataModel.battleOutcome != nil) {
                cell.autobotResultLabel.text = autobotDataModel.battleOutcome;
            }
            else {
                cell.autobotResultLabel.text = CONSTANT_SURVIVOR_STRING;
            }
        }
        else {
            cell.autobotResultLabel.text = CONSTANT_COMMENCE_BATTLE_STRING;
        }
        
    }
    
    if (self.sortedDecepticonsDataModelArray.count <= indexPath.row) {
        cell.decepticonNameLabel.text = CONSTANT_UNAVAILABLE_STRING;
        cell.decepticonRatingLabel.text = CONSTANT_RATING_UNAVAILABLE_STRING;
        cell.decepticonStatsLabel.text = CONSTANT_STATS_UNAVAILABLE_STRING;
        cell.decepticonRankLabel.text = CONSTANT_RANK_UNAVAILABLE_STRING;
        cell.decepticonResultLabel.text = self.isBattleComplete ? CONSTANT_BATTLE_MISSED_STRING : CONSTANT_COMMENCE_BATTLE_STRING;
        cell.decepticonTeamIcon.image = placeholerImageDecepticon;
    }
    else {
        TransformerDataModel *decepticonDataModel = [self.sortedDecepticonsDataModelArray objectAtIndex:indexPath.row];
        cell.decepticonNameLabel.text = decepticonDataModel.name;
        NSURL *imageUrlDecepticon = [NSURL URLWithString:decepticonDataModel.team_icon];
        NSData *imageDataDecepticon = [NSData dataWithContentsOfURL:imageUrlDecepticon];
        cell.decepticonTeamIcon.image = [UIImage imageWithData: imageDataDecepticon];
        cell.decepticonRatingLabel.text = [CONSTANT_RATING_STRING stringByAppendingString:decepticonDataModel.rating];
        NSString *statsString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@",decepticonDataModel.strength,decepticonDataModel.intelligence,decepticonDataModel.speed,decepticonDataModel.endurance,decepticonDataModel.rank,decepticonDataModel.courage,decepticonDataModel.firepower,decepticonDataModel.skill];
        cell.decepticonStatsLabel.text = [CONSTANT_STATS_STRING stringByAppendingString:statsString];
        cell.decepticonRankLabel.text = [CONSTANT_RANK_STRING stringByAppendingString:decepticonDataModel.rank];
        if (self.isBattleComplete) {
            if (decepticonDataModel.battleOutcome != nil) {
                cell.decepticonResultLabel.text = decepticonDataModel.battleOutcome;
            }
            else {
                cell.decepticonResultLabel.text = CONSTANT_SURVIVOR_STRING;
            }
        }
        else {
            cell.decepticonResultLabel.text = CONSTANT_COMMENCE_BATTLE_STRING;
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sortedAutobotsDataModelArray.count > self.sortedDecepticonsDataModelArray.count) {
        return self.sortedAutobotsDataModelArray.count;
    }
    else {
        return self.sortedDecepticonsDataModelArray.count;
    }
    return 0;

}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 275;
}

@end
