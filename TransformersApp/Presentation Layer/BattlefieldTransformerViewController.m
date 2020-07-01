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
    self.dataSource = [[BattlefieldTransformerTableViewDatasourceAndDelegate alloc] init];
    self.transformerBattleTableView.dataSource = self.dataSource;
    self.transformerBattleTableView.delegate = self.dataSource;
    
    self.dataSource.isBattleComplete = self.isBattleComplete;
    self.dataSource.transformerDataModelArray = self.transformerDataModelArray;
    if (self.transformerDataModelArray.count == 0) {
        self.startBattleButton.userInteractionEnabled = NO;
    }
    else {
        self.startBattleButton.hidden = self.isBattleComplete;
        self.startBattleButton.userInteractionEnabled = YES;
    }
    [self sortTransformers];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(!self.isSorted) {
        [self sortTransformers];
    }
}

-(void) sortTransformers {
    self.dataSource.sortedAutobotsDataModelArray = [[NSMutableArray alloc] init];
    self.dataSource.sortedDecepticonsDataModelArray = [[NSMutableArray alloc] init];
    if (self.dataSource.transformerDataModelArray.count != 0) {
        NSArray *sortedMainArray = [self.dataSource.transformerDataModelArray sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *transformer1, NSDictionary *transformer2) {
                   if ([[transformer1 valueForKey:CONSTANT_RANK_KEY_STRING] integerValue] > [[transformer2 valueForKey:CONSTANT_RANK_KEY_STRING] integerValue]) {
                       return (NSComparisonResult)NSOrderedAscending;
                   }
                   if ([[transformer1 valueForKey:CONSTANT_RANK_KEY_STRING] integerValue] < [[transformer2 valueForKey:CONSTANT_RANK_KEY_STRING] integerValue]) {
                       return (NSComparisonResult)NSOrderedDescending;
                   }
                   return (NSComparisonResult)NSOrderedSame;
               }];
        
        for (TransformerDataModel *transformerDataModelItem in sortedMainArray) {
            ([transformerDataModelItem.team isEqualToString:CONSTANT_AUTOBOT_STRING]) ?  [self.dataSource.sortedAutobotsDataModelArray addObject:transformerDataModelItem] : [self.dataSource.sortedDecepticonsDataModelArray addObject:transformerDataModelItem];
        }
    }
    self.isSorted = YES;
    [self.transformerBattleTableView reloadData];
}

- (IBAction)startTransformerBattle:(id)sender {
    int totalBattles = 0;
    NSString *annihilatorAutobotName = CONSTANT_AUTOBOT_ANNIHILATOR_NAME_STRING;
    NSString *annihilatorDecepticonName = CONSTANT_DECEPTICON_ANNIHILATOR_NAME_STRING;
    if (self.dataSource.sortedAutobotsDataModelArray.count >= self.dataSource.sortedDecepticonsDataModelArray.count) {
        totalBattles = (int)self.dataSource.sortedDecepticonsDataModelArray.count;
    }
    else {
        totalBattles = (int)self.dataSource.sortedAutobotsDataModelArray.count;
    }
    int battlesWonByAutobots = 0;
    int battleWonByDecepticons = 0;
    for (int i=0; i<totalBattles;i++) {
        TransformerDataModel *autobotTransformerDataModel = [[TransformerDataModel alloc] init];
        TransformerDataModel *decepticonTransformerDataModel = [[TransformerDataModel alloc] init];
        autobotTransformerDataModel = [self.dataSource.sortedAutobotsDataModelArray objectAtIndex:i];
        decepticonTransformerDataModel = [self.dataSource.sortedDecepticonsDataModelArray objectAtIndex:i];
        //rules of battle
        BOOL isAutobotAnnihilator = ([[autobotTransformerDataModel.name lowercaseString] isEqualToString:annihilatorAutobotName] || [[autobotTransformerDataModel.name lowercaseString] isEqualToString:annihilatorDecepticonName]);
        BOOL isDecepticonAnnihilator = ([[decepticonTransformerDataModel.name lowercaseString] isEqualToString:annihilatorAutobotName] || [[decepticonTransformerDataModel.name lowercaseString] isEqualToString:annihilatorDecepticonName]);
        
        if (isAutobotAnnihilator && isDecepticonAnnihilator) {
            //opponents are a combination of optimus prime and predaking-> results in annihilation
            [self setDataForGameOverByAnnihilation:totalBattles];
            break;
        }
        else if (isDecepticonAnnihilator) {
            //decepticon victor
            [self updateBattleResult:autobotTransformerDataModel :decepticonTransformerDataModel :CONSTANT_TEAM_DECEPTICON_STRING :i];
            battleWonByDecepticons += 1;
            continue;
        }
        else if (isAutobotAnnihilator) {
            //autobot victor
            [self updateBattleResult:autobotTransformerDataModel :decepticonTransformerDataModel :CONSTANT_TEAM_AUTOBOT_STRING :i];
            battlesWonByAutobots += 1;
            continue;
        }
        
        if (autobotTransformerDataModel.courage.intValue > decepticonTransformerDataModel.courage.intValue && autobotTransformerDataModel.strength.intValue > decepticonTransformerDataModel.strength.intValue) {
            if((autobotTransformerDataModel.courage.intValue - decepticonTransformerDataModel.courage.intValue >= 4) && (autobotTransformerDataModel.strength.intValue - decepticonTransformerDataModel.strength.intValue >= 3)) {
                [self updateBattleResult:autobotTransformerDataModel :decepticonTransformerDataModel :CONSTANT_TEAM_AUTOBOT_STRING :i];
                battlesWonByAutobots += 1;
                continue;
            }
        }
        else if (decepticonTransformerDataModel.courage.intValue > autobotTransformerDataModel.courage.intValue && decepticonTransformerDataModel.strength.intValue > autobotTransformerDataModel.strength.intValue) {
            if((decepticonTransformerDataModel.courage.intValue - autobotTransformerDataModel.courage.intValue >= 4) && (decepticonTransformerDataModel.strength.intValue - autobotTransformerDataModel.strength.intValue >= 3)) {
                [self updateBattleResult:autobotTransformerDataModel :decepticonTransformerDataModel :CONSTANT_TEAM_DECEPTICON_STRING :i];
                battleWonByDecepticons += 1;
                continue;
            }
        }
        
        if ((autobotTransformerDataModel.skill.intValue > decepticonTransformerDataModel.skill.intValue) && (autobotTransformerDataModel.skill.intValue - decepticonTransformerDataModel.skill.intValue >= 3)) {
            [self updateBattleResult:autobotTransformerDataModel :decepticonTransformerDataModel :CONSTANT_TEAM_AUTOBOT_STRING :i];
            battlesWonByAutobots += 1;
            continue;
        }
        else if ((decepticonTransformerDataModel.skill.intValue > autobotTransformerDataModel.skill.intValue) && (decepticonTransformerDataModel.skill.intValue - autobotTransformerDataModel.skill.intValue >= 3)) {
            [self updateBattleResult:autobotTransformerDataModel :decepticonTransformerDataModel :CONSTANT_TEAM_DECEPTICON_STRING :i];
            battleWonByDecepticons += 1;
            continue;
        }
        
        if(autobotTransformerDataModel.rating.intValue > decepticonTransformerDataModel.rating.intValue) {
            [self updateBattleResult:autobotTransformerDataModel :decepticonTransformerDataModel :CONSTANT_TEAM_AUTOBOT_STRING :i];
            battlesWonByAutobots += 1;
            continue;
        }
        else if(decepticonTransformerDataModel.rating.intValue > autobotTransformerDataModel.rating.intValue) {
            [self updateBattleResult:autobotTransformerDataModel :decepticonTransformerDataModel :CONSTANT_TEAM_DECEPTICON_STRING :i];
            battleWonByDecepticons += 1;
            continue;
        }
        
        if (autobotTransformerDataModel.rating.intValue == decepticonTransformerDataModel.rating.intValue) {
            autobotTransformerDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
            decepticonTransformerDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
            [self.dataSource.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:autobotTransformerDataModel];
            [self.dataSource.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:decepticonTransformerDataModel];
            continue;
        }
    }
    self.isBattleComplete = YES;
    self.dataSource.isBattleComplete = YES;
    self.startBattleButton.hidden = self.isBattleComplete;
    NSLog(@"a: %d b: %d", battlesWonByAutobots, battleWonByDecepticons);
    if (totalBattles == 0) {
        self.battlefieldBannerLabel.text = CONSTANT_BATTLE_INSUFFICIENT_STRING;
    }
    else {
        if (self.isGameOVerByAnnihilation) {
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
    }
    [self.transformerBattleTableView reloadData];
}

-(void) updateBattleResult : (TransformerDataModel *) autobotTransformerModel :(TransformerDataModel *) decepticonTransformerModel :(NSString *) winnerSpecifier :(int) index {
    int differentiator = ([winnerSpecifier isEqualToString:CONSTANT_TEAM_AUTOBOT_STRING]) ? 0 : 1;
    switch (differentiator) {
        case 0:
            //autobot->won decepticon->lost
            autobotTransformerModel.battleOutcome = CONSTANT_WINNER_STRING;
            decepticonTransformerModel.battleOutcome = CONSTANT_LOSER_STRING;
            [self.dataSource.sortedAutobotsDataModelArray replaceObjectAtIndex:index withObject:autobotTransformerModel];
            [self.dataSource.sortedDecepticonsDataModelArray replaceObjectAtIndex:index withObject:decepticonTransformerModel];
            break;
            
        case 1:
            //autobot->lost decepticon->won
            autobotTransformerModel.battleOutcome = CONSTANT_LOSER_STRING;
            decepticonTransformerModel.battleOutcome = CONSTANT_WINNER_STRING;
            [self.dataSource.sortedAutobotsDataModelArray replaceObjectAtIndex:index withObject:autobotTransformerModel];
            [self.dataSource.sortedDecepticonsDataModelArray replaceObjectAtIndex:index withObject:decepticonTransformerModel];
        break;
            
        default:
            break;
    }
}

-(void) setDataForGameOverByAnnihilation: (int)battleCount {
    self.isGameOVerByAnnihilation = YES;
    for (int i=0;i<battleCount;i++) {
        TransformerDataModel *updatedAutobotDataModel = [[TransformerDataModel alloc] init];
        updatedAutobotDataModel = [self.dataSource.sortedAutobotsDataModelArray objectAtIndex:i];
        updatedAutobotDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
        [self.dataSource.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:updatedAutobotDataModel];
        
        TransformerDataModel *updatedDecepticonDataModel = [[TransformerDataModel alloc] init];
        updatedDecepticonDataModel = [self.dataSource.sortedDecepticonsDataModelArray objectAtIndex:i];
        updatedDecepticonDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
        [self.dataSource.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:updatedDecepticonDataModel];
    }
    if (self.dataSource.sortedAutobotsDataModelArray.count == battleCount && self.dataSource.sortedDecepticonsDataModelArray.count>battleCount) {
        for (int i=battleCount;i<self.dataSource.sortedDecepticonsDataModelArray.count;i++) {
            TransformerDataModel *updatedDecepticonDataModel = [[TransformerDataModel alloc] init];
            updatedDecepticonDataModel = [self.dataSource.sortedDecepticonsDataModelArray objectAtIndex:i];
            updatedDecepticonDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
            [self.dataSource.sortedDecepticonsDataModelArray replaceObjectAtIndex:i withObject:updatedDecepticonDataModel];
        }
    }
    else if (self.dataSource.sortedDecepticonsDataModelArray.count == battleCount && self.dataSource.sortedAutobotsDataModelArray.count>battleCount){
        for (int i=battleCount;i<self.dataSource.sortedAutobotsDataModelArray.count;i++) {
                   TransformerDataModel *updatedAutobotDataModel = [[TransformerDataModel alloc] init];
                   updatedAutobotDataModel = [self.dataSource.sortedAutobotsDataModelArray objectAtIndex:i];
                   updatedAutobotDataModel.battleOutcome = CONSTANT_DESTROYED_STRING;
                   [self.dataSource.sortedAutobotsDataModelArray replaceObjectAtIndex:i withObject:updatedAutobotDataModel];
               }
    }
}

@end
