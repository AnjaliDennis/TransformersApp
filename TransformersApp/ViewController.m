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
    TransformerNetworkAPI *transformerNetworkAPI = [TransformerNetworkAPI alloc];
    [transformerNetworkAPI getTokenWithCompletionHandler:^(NSError * _Nonnull error) {
        if (!error) {
            __typeof(self) __weak weakSelf = self;
            [weakSelf refreshTransformerList:nil];
        }
        else {
            NSLog(@"Error in retreiveing jwt");
            //show alert
        }
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    static NSString *cellIdentifier = @"TransformerCollectionViewCellReuseIdentifier";
    TransformerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    TransformerDataModel *transformerDataModel = [[TransformerDataModel alloc] init];
    transformerDataModel = [self.transformerDataModelArray objectAtIndex:indexPath.row];
    cell.nameTextField.text = transformerDataModel.name;
    cell.teamValueSegmentedControl.selectedSegmentIndex = ([transformerDataModel.team isEqualToString:@"Autobot"]) ? 0 : 1;
    
    cell.ratingValueLabel.text = transformerDataModel.rating;
    NSURL *imageUrl = [NSURL URLWithString:transformerDataModel.team_icon];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    cell.teamIconImagView.image = [UIImage imageWithData: imageData];
    cell.backgroundColor = ([transformerDataModel.team isEqualToString:@"Autobot"]) ? [UIColor colorNamed:@"AutobotColor"] : [UIColor colorNamed:@"DecepticonColor"];
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
    return self.transformerDataModelArray.count; //[self.nameArray count];
}

- (IBAction)refreshTransformerList:(id)sender {
    TransformerNetworkAPI *transformerNetworkAPI = [TransformerNetworkAPI alloc];
    [transformerNetworkAPI getTransformerListWithCompletionHandler:^(NSDictionary * _Nonnull dataDictionary, NSError * _Nonnull error) {
        __typeof(self) __weak weakSelf = self;
        if (!error) {
            NSLog(@"DataDict:%@", dataDictionary);
            if ([[dataDictionary objectForKey:@"transformers"] count] != 0){
            [weakSelf parseData:dataDictionary];
            }
        }
    }];
}

-(void) parseData : (NSDictionary *) dataDictionary {
    NSArray *responseDataArray = [dataDictionary objectForKey:@"transformers"];
    [self.transformerDataModelArray removeAllObjects];
    for (NSDictionary *itemDictionary in responseDataArray) {
        TransformerDataModel *transformerDataModel = [[TransformerDataModel alloc] init];
        transformerDataModel.transformerId = [itemDictionary valueForKey:@"id"];
        transformerDataModel.name = [itemDictionary valueForKey:@"name"];
        transformerDataModel.strength = [itemDictionary valueForKey:@"strength"];
        transformerDataModel.intelligence = [itemDictionary valueForKey:@"intelligence"];
        transformerDataModel.speed = [itemDictionary valueForKey:@"speed"];
        transformerDataModel.endurance = [itemDictionary valueForKey:@"endurance"];
        transformerDataModel.rank = [itemDictionary valueForKey:@"rank"];
        transformerDataModel.courage = [itemDictionary valueForKey:@"courage"];
        transformerDataModel.firepower = [itemDictionary valueForKey:@"firepower"];
        transformerDataModel.skill = [itemDictionary valueForKey:@"skill"];
        transformerDataModel.team = ([[itemDictionary valueForKey:@"team"] isEqualToString:@"A"]) ? @"Autobot" : @"Decepticon";
        transformerDataModel.team_icon = [itemDictionary valueForKey:@"team_icon"];
        //calculate overall rating->(Strength + Intelligence + Speed + Endurance + Firepower).
        int overallRating = transformerDataModel.strength.intValue + transformerDataModel.intelligence.intValue + transformerDataModel.speed.intValue + transformerDataModel.endurance.intValue + transformerDataModel.firepower.intValue;
        transformerDataModel.rating =  [NSString stringWithFormat:@"%d", overallRating];
        [self.transformerDataModelArray addObject:transformerDataModel];
    }
    [self.autobotCollectionView reloadData];
}

- (IBAction)collectionViewCellDeleteButtonPressed:(UIButton *)button{
    NSLog(@"button tag: %d", (int)button.tag);
    NSString *transformerId = [self.transformerDataModelArray objectAtIndex:button.tag].transformerId;
    TransformerNetworkAPI *transformerNetworkApi = [TransformerNetworkAPI alloc];
    [transformerNetworkApi deleteTransformer:transformerId :^(BOOL status) {
         if (status) {
             [self.transformerDataModelArray removeObjectAtIndex:button.tag];
             [self.autobotCollectionView reloadData];
             
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Transformer has been deleted successfully" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
             [alert addAction:defaultAction];
             [self presentViewController:alert animated:YES completion:nil];
         }
         else {
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failure" message:@"Failed to delete Transformer. Please Try Again"  preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
             [alert addAction:defaultAction];
             [self presentViewController:alert animated:YES completion:nil];
         }
    }];

}

- (IBAction)sliderValueChange:(UISlider *)sender {
    //CollectionCell *selectedCell =(CollectionCell*)[collectionView cellForItemAtIndexPath:indexPath];
   // TransformerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
   // self.currentIndexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    TransformerCollectionViewCell *selectedCell = (TransformerCollectionViewCell *)[self.autobotCollectionView cellForItemAtIndexPath:self.currentIndexPath];
    
    switch (sender.tag) {
        case 0:
            selectedCell.strengthLabel.text = [@"Strength: " stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 1:
            selectedCell.intelligenceLabel.text = [@"Intelligence: " stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 2:
            selectedCell.speedLabel.text = [@"Speed: " stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 3:
            selectedCell.enduranceLabel.text = [@"Endurance: " stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 4:
            selectedCell.rankLabel.text = [@"Rank: " stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 5:
            selectedCell.courageLabel.text = [@"Courage: " stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 6:
            selectedCell.firepowerLabel.text = [@"Firepower: " stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        case 7:
            selectedCell.skillLabel.text = [@"Skill: " stringByAppendingString:[NSString stringWithFormat:@"%d", (int)sender.value]];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)collectionViewCellEditButtonPressed:(UIButton *)button{
    self.currentIndexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    TransformerCollectionViewCell *selectedCell = (TransformerCollectionViewCell *)[self.autobotCollectionView cellForItemAtIndexPath:self.currentIndexPath];
    self.isCellEditing = !self.isCellEditing;
    //if (self.isCellEditing) {
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
    
    //selectedCell.editTransformerButton.titleLabel.text = @"Save";
    [selectedCell.editTransformerButton setTitle:((self.isCellEditing) ? @"Save" : @"Edit") forState:UIControlStateNormal];
    self.autobotCollectionView.scrollEnabled = !self.isCellEditing;
    //}
}

-(void) toggleUserInteraction {
    
}



/*
- (void)encodeWithCoder:(nonnull NSCoder *)coder { 
    <#code#>
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection { 
    <#code#>
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
    <#code#>
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize { 
    <#code#>
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
    <#code#>
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
    <#code#>
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator { 
    <#code#>
}

- (void)setNeedsFocusUpdate { 
    <#code#>
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context { 
    <#code#>
}

- (void)updateFocusIfNeeded { 
    <#code#>
}
*/
@end
