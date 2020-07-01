//
//  CreateTransformerViewController.m
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 25/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import "CreateTransformerViewController.h"

@interface CreateTransformerViewController ()

@end

@implementation CreateTransformerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transformerNameTextField.delegate = self;
    // Do any additional setup after loading the view.
}
- (IBAction)sliderValueChange:(UISlider *)sender {
    switch (sender.tag) {
        case 0:
            self.strengthLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
            break;
            
        case 1:
            self.intelligenceLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
            break;
            
        case 2:
            self.speedLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
            break;
            
        case 3:
            self.enduranceLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
            break;
            
        case 4:
            self.rankLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
            break;
            
        case 5:
            self.courageLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
            break;
            
        case 6:
            self.firepowerLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
            break;
            
        case 7:
            self.skillLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)createTransformer:(id)sender {
    if (self.transformerNameTextField.text.length != 0) {
        NSString *teamValue = (self.transformerTeamType.selectedSegmentIndex == 0) ? CONSTANT_TEAM_AUTOBOT_STRING : CONSTANT_TEAM_DECEPTICON_STRING;
        self.requestBodyDataModel = [[TransformerDataModel alloc] initWithTransformerId:@"" name:self.transformerNameTextField.text strength:self.strengthLabel.text intelligence:self.intelligenceLabel.text speed:self.speedLabel.text endurance:self.enduranceLabel.text rank:self.rankLabel.text courage:self.courageLabel.text firepower:self.firepowerLabel.text skill:self.skillLabel.text team:teamValue teamIcon:@""];
        
        TransformerNetworkAPI *transformerNetworkAPI = [[TransformerNetworkAPI alloc] init];
        [transformerNetworkAPI createTransformer:self.requestBodyDataModel :^(NSDictionary * _Nonnull dataDictionary, NSError * _Nonnull error) {
            if (!error) {
                self.createdTransformerDataModel = [[TransformerDataModel alloc] init];
                self.createdTransformerDataModel = [self parseAndStoreCreatedTransformer:dataDictionary];
                //[self parseAndStoreCreatedTransformer:dataDictionary];
                [self resetToDefaultUIValues];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:CONSTANT_REFRESH];
                [[NSUserDefaults standardUserDefaults] synchronize];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:CONSTANT_ALERT_SUCCESS_TITLE_STRING message:CONSTANT_ALERT_CREATE_SUCCESS_MESSAGE_STRING preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:CONSTANT_ALERT_BUTTON_OK style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:CONSTANT_ALERT_FAILURE_TITLE_STRING message:CONSTANT_ALERT_CREATE_FAILURE_MESSAGE_STRING  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:CONSTANT_ALERT_BUTTON_OK style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}

-(TransformerDataModel *) parseAndStoreCreatedTransformer: (NSDictionary *) dataDictionary {
    self.createdTransformerDataModel.transformerId = [dataDictionary valueForKey:CONSTANT_ID_KEY_STRING];
    self.createdTransformerDataModel.name = [dataDictionary valueForKey:CONSTANT_NAME_KEY_STRING];
    self.createdTransformerDataModel.strength = [dataDictionary valueForKey:CONSTANT_STRENGTH_KEY_STRING];
    self.createdTransformerDataModel.intelligence = [dataDictionary valueForKey:CONSTANT_INTELLIGENCE_KEY_STRING];
    self.createdTransformerDataModel.speed = [dataDictionary valueForKey:CONSTANT_SPEED_KEY_STRING];
    self.createdTransformerDataModel.endurance = [dataDictionary valueForKey:CONSTANT_ENDURANCE_KEY_STRING];
    self.createdTransformerDataModel.rank = [dataDictionary valueForKey:CONSTANT_RANK_KEY_STRING];
    self.createdTransformerDataModel.courage = [dataDictionary valueForKey:CONSTANT_COURAGE_KEY_STRING];
    self.createdTransformerDataModel.firepower = [dataDictionary valueForKey:CONSTANT_FIREPOWER_KEY_STRING];
    self.createdTransformerDataModel.skill = [dataDictionary valueForKey:CONSTANT_SKILL_KEY_STRING];
    self.createdTransformerDataModel.team = [dataDictionary valueForKey:CONSTANT_TEAM_KEY_STRING];
    self.createdTransformerDataModel.team_icon = [dataDictionary valueForKey:CONSTANT_TEAM_ICON_KEY_STRING];
    return self.createdTransformerDataModel;
}

-(void) resetToDefaultUIValues {
    self.transformerNameTextField.text = @"";
    int defaultSliderValue = 5;
    self.strengthSlider.value = defaultSliderValue;
    self.intelligenceSlider.value = defaultSliderValue;
    self.speedSlider.value = defaultSliderValue;
    self.enduranceSlider.value = defaultSliderValue;
    self.rankSlider.value = defaultSliderValue;
    self.courageSlider.value = defaultSliderValue;
    self.firepowerSlider.value = defaultSliderValue;
    self.skillSlider.value = defaultSliderValue;
    self.strengthLabel.text = [NSString stringWithFormat:@"%d", defaultSliderValue];
    self.intelligenceLabel.text = [NSString stringWithFormat:@"%d", defaultSliderValue];
    self.speedLabel.text = [NSString stringWithFormat:@"%d", defaultSliderValue];
    self.enduranceLabel.text = [NSString stringWithFormat:@"%d", defaultSliderValue];
    self.rankLabel.text = [NSString stringWithFormat:@"%d", defaultSliderValue];
    self.courageLabel.text = [NSString stringWithFormat:@"%d", defaultSliderValue];
    self.firepowerLabel.text = [NSString stringWithFormat:@"%d", defaultSliderValue];
    self.skillLabel.text = [NSString stringWithFormat:@"%d", defaultSliderValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.transformerNameTextField resignFirstResponder];
    return YES;
}


@end
