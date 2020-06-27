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
    cell.nameLabel.text = transformerDataModel.name;
    cell.teamValueLabel.text = transformerDataModel.team;
    cell.ratingValueLabel.text = transformerDataModel.rating;
    NSURL *imageUrl = [NSURL URLWithString:transformerDataModel.team_icon];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    cell.teamIconImagView.image = [UIImage imageWithData: imageData];
    cell.backgroundColor = ([transformerDataModel.team isEqualToString:@"Autobot"]) ? [UIColor colorNamed:@"AutobotColor"] : [UIColor colorNamed:@"DecepticonColor"];
    cell.userInteractionEnabled = NO;
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { 
    return self.transformerDataModelArray.count; //[self.nameArray count];
}

- (IBAction)refreshTransformerList:(id)sender {
    TransformerNetworkAPI *transformerNetworkAPI = [TransformerNetworkAPI alloc];
    [transformerNetworkAPI getTransformerListWithCompletionHandler:^(NSDictionary * _Nonnull dataDictionary, NSError * _Nonnull error) {
       // __block typeof(self) *safeSelf = &self;
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
