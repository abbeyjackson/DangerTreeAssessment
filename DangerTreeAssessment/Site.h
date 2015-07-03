//
//  Site.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Realm/Realm.h>

#import "Tree.h"


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
@property NSString* commencementLat;
@property NSString* commencementLon;
@property NSString* terminationLat;
@property NSString* terminationLon;


@end


RLM_ARRAY_TYPE(Site)
