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
    NSLog(@"viewwillappear");
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
        cell.autobotNameLabel.text = @"Unavailable";
        cell.autobotRatingLabel.text = @"Rating: Unavailable";
        cell.autobotStatsLabel.text = @"Stats: Unavailable";
        cell.autobotRankLabel.text = @"Rank: Unavailable";
        cell.autobotResultLabel.text = self.isBattleComplete ? @"Battle Missed" : @"Commence Battle";
    }
    else  {
        TransformerDataModel *autobotDataModel = [self.sortedAutobotsDataModelArray objectAtIndex:indexPath.row];
        cell.autobotNameLabel.text = autobotDataModel.name;
        NSURL *imageUrlAutobot = [NSURL URLWithString:autobotDataModel.team_icon];
        NSData *imageDataAutobot = [NSData dataWithContentsOfURL:imageUrlAutobot];
        cell.autobotTeamIcon.image = [UIImage imageWithData: imageDataAutobot];
        cell.autobotRatingLabel.text = [@"Rating: " stringByAppendingString:autobotDataModel.rating];//[cell.autobotRatingLabel.text stringByAppendingString:autobotDataModel.rating];
        NSString *statsString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@",autobotDataModel.strength,autobotDataModel.intelligence,autobotDataModel.speed,autobotDataModel.endurance,autobotDataModel.rank,autobotDataModel.courage,autobotDataModel.firepower,autobotDataModel.skill];
        cell.autobotStatsLabel.text = [@"Stats: " stringByAppendingString:statsString];
        cell.autobotRankLabel.text = [@"Rank: " stringByAppendingString:autobotDataModel.rank];
        if (self.isBattleComplete) {
            if (autobotDataModel.battleOutcome != nil) {
                cell.autobotResultLabel.text = autobotDataModel.battleOutcome;
            }
            else {
                cell.autobotResultLabel.text = @"Survivor";
            }
        }
        else {
            cell.autobotResultLabel.text = @"Commence Battle";
        }
        
    }
    
    if (self.sortedDecepticonsDataModelArray.count <= indexPath.row) {
        cell.decepticonNameLabel.text = @"Unavailable";
        cell.decepticonRatingLabel.text = @"Rating: Unavailable";
        cell.decepticonStatsLabel.text = @"Stats: Unavailable";
        cell.decepticonRankLabel.text = @"Rank: Unavailable";
        cell.decepticonResultLabel.text = self.isBattleComplete ? @"Battle Missed" : @"Commence Battle";
    }
    else {
        TransformerDataModel *decepticonDataModel = [self.sortedDecepticonsDataModelArray objectAtIndex:indexPath.row];
        cell.decepticonNameLabel.text = decepticonDataModel.name;
        NSURL *imageUrlDecepticon = [NSURL URLWithString:decepticonDataModel.team_icon];
        NSData *imageDataDecepticon = [NSData dataWithContentsOfURL:imageUrlDecepticon];
        cell.decepticonTeamIcon.image = [UIImage imageWithData: imageDataDecepticon];
        cell.decepticonRatingLabel.text = [@"Rating: " stringByAppendingString:decepticonDataModel.rating]; //[cell.autobotRatingLabel.text stringByAppendingString:decepticonDataModel.rating];
        NSString *statsString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@",decepticonDataModel.strength,decepticonDataModel.intelligence,decepticonDataModel.speed,decepticonDataModel.endurance,decepticonDataModel.rank,decepticonDataModel.courage,decepticonDataModel.firepower,decepticonDataModel.skill];
        cell.decepticonStatsLabel.text = [@"Stats: " stringByAppendingString:statsString];
        cell.decepticonRankLabel.text = [@"Rank: " stringByAppendingString:decepticonDataModel.rank];
        if (self.isBattleComplete) {
            if (decepticonDataModel.battleOutcome != nil) {
                cell.decepticonResultLabel.text = decepticonDataModel.battleOutcome;
            }
            else {
                cell.decepticonResultLabel.text = @"Survivor";
            }
        }
        else {
            cell.decepticonResultLabel.text = @"Commence Battle";
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
                   if ([[transformer1 valueForKey:@"rank"] integerValue] > [[transformer2 valueForKey:@"rank"] integerValue]) {
                       return (NSComparisonResult)NSOrderedDescending;
                   }
                   if ([[transformer1 valueForKey:@"rank"] integerValue] < [[transformer2 valueForKey:@"rank"] integerValue]) {
                       return (NSComparisonResult)NSOrderedAscending;
                   }
                   return (NSComparisonResult)NSOrderedSame;
               }];
        
        for (TransformerDataModel *transformerDataModelItem in sortedMainArray) {
            ([transformerDataModelItem.team isEqualToString:@"Autobot"]) ?  [self.sortedAutobotsDataModelArray addObject:transformerDataModelItem] : [self.sortedDecepticonsDataModelArray addObject:transformerDataModelItem];
        }
        for (TransformerDataModel *transformerDataModelItem in sortedMainArray) {
            NSLog(@"Sorted rank %@", transformerDataModelItem.rank);
        }
    }
    self.isSorted = YES;
    [self.transformerBattleTableView reloadData];
}

- (IBAction)startTransformerBattle:(id)sender {
    int totalBattles ;
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
        if (autobotTransformerDataModel.courage.intValue > decepticonTransformerDataModel.courage.intValue && autobotTransformerDataModel.strength.intValue > decepticonTransformerDataModel.strength.intValue) {
            if((autobotTransformerDataModel.courage.intValue - decepticonTransformerDataModel.courage.intValue >= 4) && (autobotTransformerDataModel.strength.intValue - decepticonTransformerDataModel.strength.intValue >= 3)) {
                autobotTransformerDataModel.battleOutcome = @"Winner";
                decepticonTransformerDataModel.battleOutcome = @"Loser";
                [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
                [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
                battlesWonByAutobots += 1;
                continue;
            }
        }
        else if (decepticonTransformerDataModel.courage.intValue > autobotTransformerDataModel.courage.intValue && decepticonTransformerDataModel.strength.intValue > autobotTransformerDataModel.strength.intValue) {
            if((decepticonTransformerDataModel.courage.intValue - autobotTransformerDataModel.courage.intValue >= 4) && (decepticonTransformerDataModel.strength.intValue - autobotTransformerDataModel.strength.intValue >= 3)) {
                autobotTransformerDataModel.battleOutcome = @"Loser";
                decepticonTransformerDataModel.battleOutcome = @"Winner";
                [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
                [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
                battleWonByDecepticons += 1;
                continue;
            }
        }
        
        if ((autobotTransformerDataModel.skill.intValue > decepticonTransformerDataModel.skill.intValue) && (autobotTransformerDataModel.skill.intValue - decepticonTransformerDataModel.skill.intValue >= 3)) {
            autobotTransformerDataModel.battleOutcome = @"Winner";
            decepticonTransformerDataModel.battleOutcome = @"Loser";
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battlesWonByAutobots += 1;
            continue;
        }
        else if ((decepticonTransformerDataModel.skill.intValue > autobotTransformerDataModel.skill.intValue) && (decepticonTransformerDataModel.skill.intValue - autobotTransformerDataModel.skill.intValue >= 3)) {
            autobotTransformerDataModel.battleOutcome = @"Loser";
            decepticonTransformerDataModel.battleOutcome = @"Winner";
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battleWonByDecepticons += 1;
            continue;
        }
        
        if(autobotTransformerDataModel.rating.intValue > decepticonTransformerDataModel.rating.intValue) {
            autobotTransformerDataModel.battleOutcome = @"Winner";
            decepticonTransformerDataModel.battleOutcome = @"Loser";
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battlesWonByAutobots += 1;
            continue;
        }
        else if(decepticonTransformerDataModel.rating.intValue > autobotTransformerDataModel.rating.intValue) {
            autobotTransformerDataModel.battleOutcome = @"Loser";
            decepticonTransformerDataModel.battleOutcome = @"Winner";
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            battleWonByDecepticons += 1;
            continue;
        }
        
        if (autobotTransformerDataModel.rating.intValue == decepticonTransformerDataModel.rating.intValue) {
            autobotTransformerDataModel.battleOutcome = @"Destroyed";
            decepticonTransformerDataModel.battleOutcome = @"Destroyed";
            [self.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            continue;
        }
    //winner, loser, destroyed, (forfeit)
    }
    self.isBattleComplete = YES;
    self.startBattleButton.hidden = self.isBattleComplete;
    if (battlesWonByAutobots > battleWonByDecepticons) {
        self.battlefieldBannerLabel.text = @"Battle is won by AUTOBOTS";
    }
    else {
         self.battlefieldBannerLabel.text = @"Battle is won by DECEPTICONS";
    }
    //self.battlefieldBannerLabel.text = ()
    [self.transformerBattleTableView reloadData];
}



@end
