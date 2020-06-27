//
//  TransformerDataModel.m
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 26/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import "TransformerDataModel.h"

@implementation TransformerDataModel

- (instancetype) initWithTransformerId: (NSString *)transformerId name:(NSString *)name strength:(NSString *)strength intelligence:(NSString *)intelligence speed:(NSString *)speed endurance:(NSString *)endurance rank:(NSString *)rank courage:(NSString *)courage firepower:(NSString *)firepower skill:(NSString *)skill team:(NSString *)team teamIcon:(NSString *)teamIcon {
    
    self = [super init];

    if (self) {
        self.transformerId = transformerId;
        self.name = name;
        self.strength = strength;
        self.intelligence = intelligence;
        self.speed = speed;
        self.endurance = endurance;
        self.rank = rank;
        self.courage = courage;
        self.firepower = firepower;
        self.skill = skill;
        self.team = team;
        self.team_icon = teamIcon;
    }
    
    return self;
}

@end
