//
//  BattlefieldTransformerViewController.m
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 28/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import "BattlefieldTransformerViewController.h"

@interface BattlefieldTransformerViewController ()

@end

@implementation BattlefieldTransformerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //cache image for autobot & decepticon team icon and populate
    //have placeholdeer image if one of the teams is missing
//    NSURL *imageUrl = [NSURL URLWithString:transformerDataModel.team_icon];
//    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
//    cell.teamIconImagView.image = [UIImage imageWithData: imageData];
    self.startBattleButton.hidden = self.isBattleComplete;
    [self sortTransformers];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(!self.isSorted) {
        [self sortTransformers];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BattlefieldTransformerTableViewCellReuseIdentifier";
    BattlefieldTransformerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    if (self.sortedAutobotsDataModelArray.count <= indexPath.row) {
        cell.autobotNameLabel.text = CONSTANT_UNAVAILABLE_STRING;
        cell.autobotRatingLabel.text = CONSTANT_RATING_UNAVAILABLE_STRING;
        cell.autobotStatsLabel.text = CONSTANT_STATS_UNAVAILABLE_STRING;
        cell.autobotRankLabel.text = CONSTANT_RANK_UNAVAILABLE_STRING;
        cell.autobotResultLabel.text = self.isBattleComplete ? CONSTANT_BATTLE_MISSED_STRING : CONSTANT_COMMENCE_BATTLE_STRING;
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

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 275;
}

-(void) sortTransformers {
    self.sortedAutobotsDataModelArray = [[NSMutableArray alloc] init];
    self.sortedDecepticonsDataModelArray = [[NSMutableArray alloc] init];
    if (self.transformerDataModelArray.count != 0) {
        NSArray *sortedMainArray = [self.transformerDataModelArray sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *transformer1, NSDictionary *transformer2) {
                   if ([[transformer1 valueForKey:CONSTANT_RANK_KEY_STRING] integerValue] > [[transformer2 valueForKey:CONSTANT_RANK_KEY_STRING] integerValue]) {
                       return (NSComparisonResult)NSOrderedAscending;
                   }
                   if ([[transformer1 valueForKey:CONSTANT_RANK_KEY_STRING] integerValue] < [[transformer2 valueForKey:CONSTANT_RANK_KEY_STRING] integerValue]) {
                       return (NSComparisonResult)NSOrderedDescending;
                   }
                   return (NSComparisonResult)NSOrderedSame;
               }];
        
        for (TransformerDataModel *transformerDataModelItem in sortedMainArray) {
            ([transformerDataModelItem.team isEqualToString:CONSTANT_AUTOBOT_STRING]) ?  [self.sortedAutobotsDataModelArray addObject:transformerDataModelItem] : [self.sortedDecepticonsDataModelArray addObject:transformerDataModelItem];
        }
//        for (TransformerDataModel *transformerDataModelItem in sortedMainArray) {
//            NSLog(@"Sorted rank %@", transformerDataModelItem.rank);
//        }
    }
    self.isSorted = YES;
    [self.transformerBattleTableView reloadData];
}

- (IBAction)startTransformerBattle:(id)sender {
    int totalBattles ;
    NSString *annhilatorAutobotName = CONSTANT_AUTOBOT_ANNHILATOR_NAME_STRING;
    NSString *annhilatorDecepticonName = CONSTANT_DECEPTICON_ANNHILATOR_NAME_STRING;
    if (self.sortedAutobotsDataModelArray.count >= self.sortedDecepticonsDataModelArray.count) {
        totalBattles = (int)self.sortedDecepticonsDataModelArray.count;
    }
    else {
        totalBattles = (int)self.sortedAutobotsDataModelArray.count;
    }
    int battlesWonByAutobots = 0;
    int battleWonByDecepticons = 0;
    for (int i=0; i<totalBattles;i++) {
        TransformerDataModel *autobotTransformerDataModel = [[TransformerDataModel alloc] init];
        TransformerDataModel *decepticonTransformerDataModel = [[TransformerDataModel alloc] init];
        autobotTransformerDataModel = [self.sortedAutobotsDataModelArray objectAtIndex:i];
        decepticonTransformerDataModel = [self.sortedDecepticonsDataModelArray objectAtIndex:i];
        //rules of battle
        BOOL isAutobotAnnhilator = ([[autobotTransformerDataModel.name lowercaseString] isEqualToString:annhilatorAutobotName] || [[autobotTransformerDataModel.name lowercaseString] isEqualToString:annhilatorDecepticonName]);
        BOOL isDecepticonAnnhilator = ([[decepticonTransformerDataModel.name lowercaseString] isEqualToString:annhilatorAutobotName] || [[decepticonTransformerDataModel.name lowercaseString] isEqualToString:annhilatorDecepticonName]);
        
        if (isAutobotAnnhilator && isDecepticonAnnhilator) {
            //opponents are a combination of optimus prime and predaking-> results in annhilation
            [self setDataForGameOVerByAnnhilation:totalBattles];
            break;
        }
        else if (isDecepticonAnnhilator) {
            //decepticon victor
            autobotTransformerDataModel.battleOutcome = CONSTANT_LOSER_STRING;
            decepticonTransformerDataModel.battleOutcome = CONSTANT_WINNER_STRING;
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battleWonByDecepticons += 1;
            continue;
        }
        else if (isAutobotAnnhilator) {
            //autobot victor
            autobotTransformerDataModel.battleOutcome = CONSTANT_WINNER_STRING;
            decepticonTransformerDataModel.battleOutcome = CONSTANT_LOSER_STRING;
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battlesWonByAutobots += 1;
            continue;
        }
        
        
        if (autobotTransformerDataModel.courage.intValue > decepticonTransformerDataModel.courage.intValue && autobotTransformerDataModel.strength.intValue > decepticonTransformerDataModel.strength.intValue) {
            if((autobotTransformerDataModel.courage.intValue - decepticonTransformerDataModel.courage.intValue >= 4) && (autobotTransformerDataModel.strength.intValue - decepticonTransformerDataModel.strength.intValue >= 3)) {
                autobotTransformerDataModel.battleOutcome = CONSTANT_WINNER_STRING;
                decepticonTransformerDataModel.battleOutcome = CONSTANT_LOSER_STRING;
                [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
                [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
                battlesWonByAutobots += 1;
                continue;
            }
        }
        else if (decepticonTransformerDataModel.courage.intValue > autobotTransformerDataModel.courage.intValue && decepticonTransformerDataModel.strength.intValue > autobotTransformerDataModel.strength.intValue) {
            if((decepticonTransformerDataModel.courage.intValue - autobotTransformerDataModel.courage.intValue >= 4) && (decepticonTransformerDataModel.strength.intValue - autobotTransformerDataModel.strength.intValue >= 3)) {
                autobotTransformerDataModel.battleOutcome = CONSTANT_LOSER_STRING;
                decepticonTransformerDataModel.battleOutcome = CONSTANT_WINNER_STRING;
                [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
                [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
                battleWonByDecepticons += 1;
                continue;
            }
        }
        
        if ((autobotTransformerDataModel.skill.intValue > decepticonTransformerDataModel.skill.intValue) && (autobotTransformerDataModel.skill.intValue - decepticonTransformerDataModel.skill.intValue >= 3)) {
            autobotTransformerDataModel.battleOutcome = CONSTANT_WINNER_STRING;
            decepticonTransformerDataModel.battleOutcome = CONSTANT_LOSER_STRING;
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battlesWonByAutobots += 1;
            continue;
        }
        else if ((decepticonTransformerDataModel.skill.intValue > autobotTransformerDataModel.skill.intValue) && (decepticonTransformerDataModel.skill.intValue - autobotTransformerDataModel.skill.intValue >= 3)) {
            autobotTransformerDataModel.battleOutcome = CONSTANT_LOSER_STRING;
            decepticonTransformerDataModel.battleOutcome = CONSTANT_WINNER_STRING;
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battleWonByDecepticons += 1;
            continue;
        }
        
        if(autobotTransformerDataModel.rating.intValue > decepticonTransformerDataModel.rating.intValue) {
            autobotTransformerDataModel.battleOutcome = CONSTANT_WINNER_STRING;
            decepticonTransformerDataModel.battleOutcome = CONSTANT_LOSER_STRING;
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battlesWonByAutobots += 1;
            continue;
        }
        else if(decepticonTransformerDataModel.rating.intValue > autobotTransformerDataModel.rating.intValue) {
            autobotTransformerDataModel.battleOutcome = CONSTANT_LOSER_STRING;
            decepticonTransformerDataModel.battleOutcome = CONSTANT_WINNER_STRING;
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battleWonByDecepticons += 1;
            continue;
        }
        
        if (autobotTransformerDataModel.rating.intValue == decepticonTransformerDataModel.rating.intValue) {
            autobotTransformerDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
            decepticonTransformerDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            continue;
        }
    }
    self.isBattleComplete = YES;
    self.startBattleButton.hidden = self.isBattleComplete;
    NSLog(@"a: %d b: %d", battlesWonByAutobots, battleWonByDecepticons);
    if (self.isGameOVerByAnnhilation) {
        self.battlefieldBannerLabel.text = CONSTANT_GAMEOVER_STRING;
    }
    else {
        if (battlesWonByAutobots == battleWonByDecepticons) {
            self.battlefieldBannerLabel.text = CONSTANT_BATTLE_TIE_STRING;
        }
        else {
            if (battlesWonByAutobots > battleWonByDecepticons) {
                self.battlefieldBannerLabel.text = CONSTANT_BATTLE_AUTOBOTS_STRING;
            }
            else {
                self.battlefieldBannerLabel.text = CONSTANT_BATTLE_DECEPTICONS_STRING;
            }
        }
    }
    [self.transformerBattleTableView reloadData];
}

-(void) setDataForGameOVerByAnnhilation: (int)battleCount {
    self.isGameOVerByAnnhilation = YES;
    for (int i=0;i<battleCount;i++) {
        TransformerDataModel *updatedAutobotDataModel = [[TransformerDataModel alloc] init];
        updatedAutobotDataModel = [self.sortedAutobotsDataModelArray objectAtIndex:i];
        updatedAutobotDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
        [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:updatedAutobotDataModel];
        
        TransformerDataModel *updatedDecepticonDataModel = [[TransformerDataModel alloc] init];
        updatedDecepticonDataModel = [self.sortedDecepticonsDataModelArray objectAtIndex:i];
        updatedDecepticonDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
        [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:updatedDecepticonDataModel];
    }
}



@end
