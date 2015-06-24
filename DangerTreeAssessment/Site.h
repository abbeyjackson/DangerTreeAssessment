//
//  Site.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Realm/Realm.h>
#import "Tree.h"

// fuel types
extern NSString* const kC1;
extern NSString* const kC2;
extern NSString* const kC3;
extern NSString* const kC4;
extern NSString* const kC5;
extern NSString* const kC6;
extern NSString* const kC7;
extern NSString* const kD1;
extern NSString* const kM1;
extern NSString* const kM2;
extern NSString* const kM3;
extern NSString* const kM4;
extern NSString* const kS1;
extern NSString* const kS2;
extern NSString* const kS3;
extern NSString* const kO1a;
extern NSString* const kO1b;

// lod types
extern NSString* const kLODType1;
extern NSString* const kLODType23;
extern NSString* const kLODType4;

@interface Site : RLMObject

// internal properties
@property BOOL isReportComplete;
@property RLMArray<Tree> *trees;
@property NSString *siteID;
@property NSString *formattedDtaID;
@property NSString *reportDate;
@property int numberForArray;


// Site properties
@property NSString* fireNumber;
@property NSString* dtaName;
@property NSString* dtaUnit;
@property NSString* fuel;
@property NSString* location;
@property NSString* bui; 
@property NSString* lod;
@property NSString* activity;




@end

// This protocol enables typed collections. i.e.:
// RLMArray<Site>
RLM_ARRAY_TYPE(Site)
