//
//  TreeSpecies.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeSpecies : NSObject

@property (nonatomic, strong) NSString *abbreviation;
@property (nonatomic, strong) NSString *name;

-(instancetype)initWithAbbreviation:(NSString*)abbreviation andName:(NSString*)name;


@end
