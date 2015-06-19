//
//  Site.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Realm/Realm.h>
#import "Tree.h"

typedef enum : int {
    C1,
    C2,
    C3,
    C4,
    C5,
    C6,
    C7,
    D1,
    M1,
    M2,
    M3,
    M4,
    S1,
    S2,
    S3,
    O1a,
    O1b,
} FuelType;


extern NSString* const kLODType1;
extern NSString* const kLODType23;
extern NSString* const kLODType4;

@interface Site : RLMObject
@property NSString* fireNumber;
@property NSString* dtaName;
@property NSString* dtaUnit;
@property FuelType fuel;
@property NSString* location;
@property NSString* bui; 
@property NSString* lod;
@property NSString* activity;

@property RLMArray<Tree> *trees;



@end

// This protocol enables typed collections. i.e.:
// RLMArray<Site>
RLM_ARRAY_TYPE(Site)
