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
    // Do any additional setup after loading the view.
}
- (IBAction)sliderValueChange:(UISlider *)sender {
    switch (sender.tag) {
        case 0:
            self.strengthLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];//sender.value;
            break;
            
        case 1:
            self.intelligenceLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];//sender.value;
            break;
            
        case 2:
            self.speedLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];//sender.value;
            break;
            
        case 3:
            self.enduranceLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];//sender.value;
            break;
            
        case 4:
            self.rankLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];//sender.value;
            break;
            
        case 5:
            self.courageLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];//sender.value;
            break;
            
        case 6:
            self.firepowerLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];//sender.value;
            break;
            
        case 7:
            self.skillLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];//sender.value;
            break;
            
        default:
            break;
    }
    
}

- (IBAction)createTransformer:(id)sender {
    if (self.transformerNameTextField.text.length != 0) {
        NSString *teamValue = (self.transformerTeamType.selectedSegmentIndex == 0) ? @"A" : @"D";
        self.requestBodyDataModel = [[TransformerDataModel alloc] initWithTransformerId:@"" name:self.transformerNameTextField.text strength:self.strengthLabel.text intelligence:self.intelligenceLabel.text speed:self.speedLabel.text endurance:self.enduranceLabel.text rank:self.rankLabel.text courage:self.courageLabel.text firepower:self.firepowerLabel.text skill:self.skillLabel.text team:teamValue teamIcon:@""];
        
        [self resetToDefaultUIValues];
        
        TransformerNetworkAPI *transformerNetworkAPI = [TransformerNetworkAPI alloc];
        //[transformerNetworkAPI createTransformer:self.dataModel];
        [transformerNetworkAPI createTransformer:self.requestBodyDataModel :^(NSDictionary * _Nonnull dataDictionary, NSError * _Nonnull error) {
            if (!error) {
                
                self.dataModel.transformerId = [dataDictionary valueForKey:@"id"];
                self.dataModel.name = [dataDictionary valueForKey:@"name"];
                self.dataModel.strength = [dataDictionary valueForKey:@"strength"];
                self.dataModel.intelligence = [dataDictionary valueForKey:@"intelligence"];
                self.dataModel.speed = [dataDictionary valueForKey:@"speed"];
                self.dataModel.endurance = [dataDictionary valueForKey:@"endurance"];
                self.dataModel.rank = [dataDictionary valueForKey:@"rank"];
                self.dataModel.courage = [dataDictionary valueForKey:@"courage"];
                self.dataModel.firepower = [dataDictionary valueForKey:@"firepower"];
                self.dataModel.skill = [dataDictionary valueForKey:@"skill"];
                self.dataModel.team = [dataDictionary valueForKey:@"team"];
                
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Transformer has been created successfully" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failure" message:@"Failed to create Transformer. Please Try Again"  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}

-(void) resetToDefaultUIValues {
    //    name:self.transformerNameTextField.text strength:self.strengthLabel.text intelligence:self.intelligenceLabel.text speed:self.speedLabel.text endurance:self.enduranceLabel.text rank:self.rankLabel.text courage:self.courageLabel.text firepower:self.firepowerLabel.text skill:self.skillLabel.text team:teamValue
    self.transformerNameTextField.text = @"";
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
