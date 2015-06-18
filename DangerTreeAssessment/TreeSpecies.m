//
//  TreeSpecies.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeSpecies.h"

@implementation TreeSpecies


-(instancetype)initWithAbbreviation:(NSString*)abbreviation andName:(NSString*)name{
    self = [super init];
    if (self) {
        _abbreviation = abbreviation;
        _name = name;
    }
    return self;
}

@end
