//
//  Fuel.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Fuel : NSObject


@property (strong, nonatomic)  NSString *abbreviation;
@property (strong, nonatomic)  NSString *name;


-(instancetype)initWithAbbreviation:(NSString*)abbreviation andName:(NSString*)name;


@end
