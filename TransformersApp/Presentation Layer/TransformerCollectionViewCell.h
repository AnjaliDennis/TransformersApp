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
@property (weak, nonatomic) IBOutlet UILabel *ratingValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamIconImagView;
@property (weak, nonatomic) IBOutlet UIButton *deleteTransformerButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *teamValueSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *strengthLabel;
@property (weak, nonatomic) IBOutlet UISlider *strengthSlider;
@property (weak, nonatomic) IBOutlet UISlider *intelligenceSlider;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISlider *enduranceSlider;
@property (weak, nonatomic) IBOutlet UISlider *rankSlider;
@property (weak, nonatomic) IBOutlet UISlider *courageSlider;
@property (weak, nonatomic) IBOutlet UISlider *firepowerSlider;
@property (weak, nonatomic) IBOutlet UISlider *skillSlider;
@property (weak, nonatomic) IBOutlet UIButton *editTransformerButton;
@property (weak, nonatomic) IBOutlet UILabel *intelligenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *enduranceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *courageLabel;
@property (weak, nonatomic) IBOutlet UILabel *firepowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *skillLabel;


@end

NS_ASSUME_NONNULL_END
