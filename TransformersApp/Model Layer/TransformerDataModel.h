//
//  TransformerDataModel.h
//  TransformersApp
//
//  Created by Anjali Pragati Dennis on 26/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransformerDataModel : NSObject

@property (strong, nonatomic) NSString *transformerId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *strength;
@property (strong, nonatomic) NSString *intelligence;
@property (strong, nonatomic) NSString *speed;
@property (strong, nonatomic) NSString *endurance;
@property (strong, nonatomic) NSString *rank;
@property (strong, nonatomic) NSString *courage;
@property (strong, nonatomic) NSString *firepower;
@property (strong, nonatomic) NSString *skill;
@property (strong, nonatomic) NSString *team;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *battleOutcome;

@property (strong,   nonatomic) NSString *team_icon;

- (instancetype) initWithTransformerId: (NSString *)transformerId name:(NSString *)name strength:(NSString *)strength intelligence:(NSString *)intelligence speed:(NSString *)speed endurance:(NSString *)endurance rank:(NSString *)rank courage:(NSString *)courage firepower:(NSString *)firepower skill:(NSString *)skill team:(NSString *)team teamIcon:(NSString *)teamIcon;


@end

NS_ASSUME_NONNULL_END
