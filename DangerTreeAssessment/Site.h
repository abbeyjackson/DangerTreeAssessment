//
//  Site.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Realm/Realm.h>
#import "Tree.h"

typedef enum : NSUInteger {
    FuelTypeDiesel,
    FuelTypeGas,
    FuelTypeMethanol,
} FuelType;

typedef enum: NSUInteger {
    LOD1,
    LOD23,
    LOD4,
} LOD;

@interface Site : RLMObject
@property NSInteger* fireNumber;
@property NSString* dtaName;
@property NSString* dtaUnit;
@property FuelType fuel;
@property NSString* location;
@property NSString* bui; // not sure what BUI is
@property LOD lod;
@property NSString* activity;

@property RLMArray<Tree> *trees;



@end

// This protocol enables typed collections. i.e.:
// RLMArray<Site>
RLM_ARRAY_TYPE(Site)
