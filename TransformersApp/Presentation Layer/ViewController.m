//
//  ViewController.m
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 24/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transformerDataModelArray = [[NSMutableArray alloc] init];
    self.currentIndexPath = [[NSIndexPath alloc] init];
    TransformerNetworkAPI *transformerNetworkAPI = [[TransformerNetworkAPI alloc] init];
    [transformerNetworkAPI getTokenWithCompletionHandler:^(NSError * _Nonnull error) {
        if (!error) {
            __typeof(self) __weak weakSelf = self;
            [weakSelf refreshTransformerList:nil];
        }
    }];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([[NSUserDefaults standardUserDefaults] boolForKey:CONSTANT_REFRESH]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:CONSTANT_REFRESH];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self refreshTransformerList:nil];
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    static NSString *cellIdentifier = @"TransformerCollectionViewCellReuseIdentifier";
    TransformerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    TransformerDataModel *transformerDataModel = [[TransformerDataModel alloc] init];
    transformerDataModel = [self.transformerDataModelArray objectAtIndex:indexPath.row];
    cell.nameTextField.text = transformerDataModel.name;
    cell.teamValueSegmentedControl.selectedSegmentIndex = ([transformerDataModel.team isEqualToString:CONSTANT_AUTOBOT_STRING]) ? 0 : 1;
    
    
    cell.strengthSlider.value = transformerDataModel.strength.intValue;
    cell.strengthLabel.text = [CONSTANT_STRENGTH_STRING stringByAppendingString:transformerDataModel.strength];
    cell.intelligenceSlider.value = transformerDataModel.intelligence.intValue;
    cell.intelligenceLabel.text = [CONSTANT_INTELLIGENCE_STRING stringByAppendingString:transformerDataModel.intelligence];
    cell.speedSlider.value = transformerDataModel.speed.intValue;
    cell.speedLabel.text = [CONSTANT_SPEED_STRING stringByAppendingString:transformerDataModel.speed];
    cell.enduranceSlider.value = transformerDataModel.endurance.intValue;
    cell.enduranceLabel.text = [CONSTANT_ENDURANCE_STRING stringByAppendingString:transformerDataModel.endurance];
    cell.rankSlider.value = transformerDataModel.rank.intValue;
    cell.rankLabel.text = [CONSTANT_RANK_STRING stringByAppendingString:transformerDataModel.rank];
    cell.courageSlider.value = transformerDataModel.courage.intValue;
    cell.courageLabel.text = [CONSTANT_COURAGE_STRING stringByAppendingString:transformerDataModel.courage];
    cell.firepowerSlider.value = transformerDataModel.firepower.intValue;
    cell.firepowerLabel.text = [CONSTANT_FIREPOWER_STRING stringByAppendingString:transformerDataModel.firepower];
    cell.skillSlider.value = transformerDataModel.skill.intValue;
    cell.skillLabel.text = [CONSTANT_SKILL_STRING stringByAppendingString:transformerDataModel.skill];
    
    cell.ratingValueLabel.text = transformerDataModel.rating;
    NSURL *imageUrl = [NSURL URLWithString:transformerDataModel.team_icon];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    cell.teamIconImagView.image = [UIImage imageWithData: imageData];
    cell.backgroundColor = ([transformerDataModel.team isEqualToString:CONSTANT_AUTOBOT_STRING]) ? [UIColor colorNamed:@"AutobotColor"] : [UIColor colorNamed:@"DecepticonColor"];
    cell.deleteTransformerButton.tag = indexPath.row;
    [cell.deleteTransformerButton addTarget:self action:@selector(collectionViewCellDeleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    cell.editTransformerButton.tag = indexPath.row;
    [cell.editTransformerButton addTarget:self action:@selector(collectionViewCellEditButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.currentIndexPath = indexPath;
    
    [cell.strengthSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventTouchUpInside];
    [cell.intelligenceSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventTouchUpInside];
    [cell.speedSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventTouchUpInside];
    [cell.enduranceSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rankSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventTouchUpInside];
    [cell.courageSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventTouchUpInside];
    [cell.firepowerSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventTouchUpInside];
    [cell.skillSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.nameTextField.userInteractionEnabled = NO;
    cell.teamValueSegmentedControl.userInteractionEnabled = NO;
    cell.strengthSlider.userInteractionEnabled = NO;
    cell.intelligenceSlider.userInteractionEnabled = NO;
    cell.speedSlider.userInteractionEnabled = NO;
    cell.enduranceSlider.userInteractionEnabled = NO;
    cell.rankSlider.userInteractionEnabled = NO;
    cell.courageSlider.userInteractionEnabled = NO;
    cell.firepowerSlider.userInteractionEnabled = NO;
    cell.skillSlider.userInteractionEnabled = NO;
    
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { 
    return self.transformerDataModelArray.count;
}

- (IBAction)refreshTransformerList:(id)sender {
    TransformerNetworkAPI *transformerNetworkAPI = [[TransformerNetworkAPI alloc] init];
    [transformerNetworkAPI getTransformerListWithCompletionHandler:^(NSDictionary * _Nonnull dataDictionary, NSError * _Nonnull error) {
        __typeof(self) __weak weakSelf = self;
        if (!error) {
            if ([[dataDictionary objectForKey:CONSTANT_TRANSFORMERS_KEY_STRING] count] != 0){
                [weakSelf parseData:dataDictionary];
            }
        }
    }];
}
- (IBAction)createButtonSelected:(id)sender {
    [self performSegueWithIdentifier:@"segueToCreateTransformerScreen" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueToBattlefieldScreen"]) {
        BattlefieldTransformerViewController *destVC = [segue destinationViewController];
        destVC.transformerDataModelArray = self.transformerDataModelArray;
    }
}

-(void) parseData: (NSDictionary *) dataDictionary {
    NSArray *responseDataArray = [dataDictionary objectForKey:CONSTANT_TRANSFORMERS_KEY_STRING];
    [self.transformerDataModelArray removeAllObjects];
    for (NSDictionary *itemDictionary in responseDataArray) {
        TransformerDataModel *transformerDataModel = [[TransformerDataModel alloc] init];
        transformerDataModel.transformerId = [itemDictionary valueForKey:CONSTANT_ID_KEY_STRING];
        transformerDataModel.name = [itemDictionary valueForKey:CONSTANT_NAME_KEY_STRING];
        transformerDataModel.strength = [itemDictionary valueForKey:CONSTANT_STRENGTH_KEY_STRING];
        transformerDataModel.intelligence = [itemDictionary valueForKey:CONSTANT_INTELLIGENCE_KEY_STRING];
        transformerDataModel.speed = [itemDictionary valueForKey:CONSTANT_SPEED_KEY_STRING];
        transformerDataModel.endurance = [itemDictionary valueForKey:CONSTANT_ENDURANCE_KEY_STRING];
        transformerDataModel.rank = [itemDictionary valueForKey:CONSTANT_RANK_KEY_STRING];
        transformerDataModel.courage = [itemDictionary valueForKey:CONSTANT_COURAGE_KEY_STRING];
        transformerDataModel.firepower = [itemDictionary valueForKey:CONSTANT_FIREPOWER_KEY_STRING];
        transformerDataModel.skill = [itemDictionary valueForKey:CONSTANT_SKILL_KEY_STRING];
        transformerDataModel.team = ([[itemDictionary valueForKey:CONSTANT_TEAM_KEY_STRING] isEqualToString:CONSTANT_TEAM_AUTOBOT_STRING]) ? CONSTANT_AUTOBOT_STRING : CONSTANT_DECEPTICON_STRING;
        transformerDataModel.team_icon = [itemDictionary valueForKey:CONSTANT_TEAM_ICON_KEY_STRING];
        //calculate overall rating->(Strength + Intelligence + Speed + Endurance + Firepower).
        int overallRating = transformerDataModel.strength.intValue + transformerDataModel.intelligence.intValue + transformerDataModel.speed.intValue + transformerDataModel.endurance.intValue + transformerDataModel.firepower.intValue;
        transformerDataModel.rating =  [NSString stringWithFormat:@"%d", overallRating];
        [self.transformerDataModelArray addObject:transformerDataModel];
    }
    [self.autobotCollectionView reloadData];
}

-(TransformerDataModel *) parseUpdatedData:(NSDictionary *) dataDictionary {
    TransformerDataModel *transformerDataModel = [[TransformerDataModel alloc] init];
    transformerDataModel.transformerId = [dataDictionary valueForKey:CONSTANT_ID_KEY_STRING];
    transformerDataModel.name = [dataDictionary valueForKey:CONSTANT_NAME_KEY_STRING];
    transformerDataModel.strength = [dataDictionary valueForKey:CONSTANT_STRENGTH_KEY_STRING];
    transformerDataModel.intelligence = [dataDictionary valueForKey:CONSTANT_INTELLIGENCE_KEY_STRING];
    transformerDataModel.speed = [dataDictionary valueForKey:CONSTANT_SPEED_KEY_STRING];
    transformerDataModel.endurance = [dataDictionary valueForKey:CONSTANT_ENDURANCE_KEY_STRING];
    transformerDataModel.rank = [dataDictionary valueForKey:CONSTANT_RANK_KEY_STRING];
    transformerDataModel.courage = [dataDictionary valueForKey:CONSTANT_COURAGE_KEY_STRING];
    transformerDataModel.firepower = [dataDictionary valueForKey:CONSTANT_FIREPOWER_KEY_STRING];
    transformerDataModel.skill = [dataDictionary valueForKey:CONSTANT_SKILL_KEY_STRING];
    transformerDataModel.team = ([[dataDictionary valueForKey:CONSTANT_TEAM_KEY_STRING] isEqualToString:CONSTANT_TEAM_AUTOBOT_STRING]) ? CONSTANT_AUTOBOT_STRING : CONSTANT_DECEPTICON_STRING;
    transformerDataModel.team_icon = [dataDictionary valueForKey:CONSTANT_TEAM_ICON_KEY_STRING];
    //calculate overall rating->(Strength + intelligence + Speed + Endurance + Firepower).
    int overallRating = transformerDataModel.strength.intValue + transformerDataModel.intelligence.intValue + transformerDataModel.speed.intValue + transformerDataModel.endurance.intValue + transformerDataModel.firepower.intValue;
    transformerDataModel.rating =  [NSString stringWithFormat:@"%d", overallRating];
    return transformerDataModel;
}

- (IBAction)collectionViewCellDeleteButtonPressed:(UIButton *)button{
    NSString *transformerId = [self.transformerDataModelArray objectAtIndex:button.tag].transformerId;
    TransformerNetworkAPI *transformerNetworkApi = [[TransformerNetworkAPI alloc] init];
    [transformerNetworkApi deleteTransformer:transformerId :^(BOOL status) {
        if (status) {
            [self.transformerDataModelArray removeObjectAtIndex:button.tag];
            [self.autobotCollectionView reloadData];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:CONSTANT_ALERT_SUCCESS_TITLE_STRING message:CONSTANT_ALERT_DELETE_SUCCESS_MESSAGE_STRING preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:CONSTANT_ALERT_BUTTON_OK style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:CONSTANT_ALERT_FAILURE_TITLE_STRING message:CONSTANT_ALERT_DELETE_FAILURE_MESSAGE_STRING  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:CONSTANT_ALERT_BUTTON_OK style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
}

- (IBAction)sliderValueChange:(UISlider *)sender {
    TransformerCollectionViewCell *selectedCell = (TransformerCollectionViewCell *)[self.autobotCollectionView cellForItemAtIndexPath:self.currentIndexPath];
    
    switch (sender.tag) {
        case 0:
            selectedCell.strengthLabel.text = [CONSTANT_STRENGTH_STRING stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 1:
            selectedCell.intelligenceLabel.text = [CONSTANT_INTELLIGENCE_STRING stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 2:
            selectedCell.speedLabel.text = [CONSTANT_SPEED_STRING stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 3:
            selectedCell.enduranceLabel.text = [CONSTANT_ENDURANCE_STRING stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 4:
            selectedCell.rankLabel.text = [CONSTANT_RANK_STRING stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 5:
            selectedCell.courageLabel.text = [CONSTANT_COURAGE_STRING stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 6:
            selectedCell.firepowerLabel.text = [CONSTANT_FIREPOWER_STRING stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 7:
            selectedCell.skillLabel.text = [CONSTANT_SKILL_STRING stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)collectionViewCellEditButtonPressed:(UIButton *)button{
    self.currentIndexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    TransformerCollectionViewCell *selectedCell = (TransformerCollectionViewCell *)[self.autobotCollectionView cellForItemAtIndexPath:self.currentIndexPath];
    
    self.isCellEditing = !self.isCellEditing;
    
    selectedCell.nameTextField.userInteractionEnabled = self.isCellEditing;
    selectedCell.teamValueSegmentedControl.userInteractionEnabled = self.isCellEditing;
    selectedCell.strengthSlider.userInteractionEnabled = self.isCellEditing;
    selectedCell.intelligenceSlider.userInteractionEnabled = self.isCellEditing;
    selectedCell.speedSlider.userInteractionEnabled = self.isCellEditing;
    selectedCell.enduranceSlider.userInteractionEnabled = self.isCellEditing;
    selectedCell.rankSlider.userInteractionEnabled = self.isCellEditing;
    selectedCell.courageSlider.userInteractionEnabled = self.isCellEditing;
    selectedCell.firepowerSlider.userInteractionEnabled = self.isCellEditing;
    selectedCell.skillSlider.userInteractionEnabled = self.isCellEditing;
    
    [selectedCell.editTransformerButton setTitle:((self.isCellEditing) ? CONSTANT_SAVE_BUTTON : CONSTANT_EDIT_BUTTON_OK) forState:UIControlStateNormal];
    self.autobotCollectionView.scrollEnabled = !self.isCellEditing;
    
    if(!self.isCellEditing) {
        //changes are to be saved/updated
        TransformerDataModel *uneditedTransformerDataModel = [[TransformerDataModel alloc] init];
        TransformerDataModel *updatedTransformerDataModel = [[TransformerDataModel alloc] init];
        uneditedTransformerDataModel = [self.transformerDataModelArray objectAtIndex:self.currentIndexPath.row];
        
        updatedTransformerDataModel.transformerId = uneditedTransformerDataModel.transformerId;
        updatedTransformerDataModel.name = selectedCell.nameTextField.text;
        
        updatedTransformerDataModel.strength = [NSString stringWithFormat:@"%d",(int)selectedCell.strengthSlider.value];
        updatedTransformerDataModel.intelligence = [NSString stringWithFormat:@"%d",(int)selectedCell.intelligenceSlider.value];
        updatedTransformerDataModel.speed = [NSString stringWithFormat:@"%d",(int)selectedCell.speedSlider.value];
        updatedTransformerDataModel.endurance = [NSString stringWithFormat:@"%d",(int)selectedCell.enduranceSlider.value];
        updatedTransformerDataModel.rank = [NSString stringWithFormat:@"%d",(int)selectedCell.rankSlider.value];
        updatedTransformerDataModel.courage = [NSString stringWithFormat:@"%d",(int)selectedCell.courageSlider.value];
        updatedTransformerDataModel.firepower = [NSString stringWithFormat:@"%d",(int)selectedCell.firepowerSlider.value];
        updatedTransformerDataModel.skill = [NSString stringWithFormat:@"%d",(int)selectedCell.skillSlider.value];
        updatedTransformerDataModel.team = (selectedCell.teamValueSegmentedControl.selectedSegmentIndex == 0) ? CONSTANT_TEAM_AUTOBOT_STRING : CONSTANT_TEAM_DECEPTICON_STRING;
        updatedTransformerDataModel.team_icon = @"";
        int overallRating = updatedTransformerDataModel.strength.intValue + updatedTransformerDataModel.intelligence.intValue + updatedTransformerDataModel.speed.intValue + updatedTransformerDataModel.endurance.intValue + updatedTransformerDataModel.firepower.intValue;
        selectedCell.ratingValueLabel.text = [NSString stringWithFormat:@"%d",overallRating];
        updatedTransformerDataModel.rating = @"";
        
        TransformerNetworkAPI *transformerNetworkApi = [[TransformerNetworkAPI alloc] init];
        [transformerNetworkApi updateTransformer:updatedTransformerDataModel :^(NSDictionary * _Nonnull dataDictionary, NSError * _Nonnull error) {
            if (!error) {
                if ([dataDictionary count] != 0){
                    TransformerDataModel *updatedResponseDataModel = [self parseUpdatedData:dataDictionary];
                    [self.transformerDataModelArray replaceObjectAtIndex:self.currentIndexPath.row withObject:updatedResponseDataModel];
                    [self.autobotCollectionView reloadData];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:CONSTANT_ALERT_SUCCESS_TITLE_STRING message:CONSTANT_ALERT_UPDATE_SUCCESS_MESSAGE_STRING preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:CONSTANT_ALERT_BUTTON_OK style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                else {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:CONSTANT_ALERT_FAILURE_TITLE_STRING message:CONSTANT_ALERT_UPDATE_FAILURE_MESSAGE_STRING  preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:CONSTANT_ALERT_BUTTON_OK style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }
        }];
    }
}


@end
