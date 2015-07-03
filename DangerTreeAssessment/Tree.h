//
//  Tree.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Realm/Realm.h>

@class Site;


@interface Tree : RLMObject


// internal properties
@property Site *site;
@property NSString *treeNumber;
@property NSString *treeID;
@property BOOL isComplete;

// tree properties for all trees:
@property NSString* lat;
@property NSString* lon;
@property NSString* species;
@property NSString* treeClass;
@property NSString* wildLifeValue;

// tree properties for LOD1 trees:
@property NSString* insecure;
@property NSString* unstable;
@property NSString* leaning;

// tree properties for LOD23 trees:
@property NSString* hazardousTop;
@property NSString* deadLimbs;
@property NSString* witchesBroom;
@property NSString* splitTrunk;
@property NSString* stemDamage;
@property NSString* sloughingBark;
@property NSString* cankers;
@property NSString* conksMushrooms;
@property NSString* treeLean;
@property NSString* rootInspection;

// tree properties for LOD4 trees:
@property NSString* rating;

// tree properties for management (all trees)
@property BOOL isDangerous;
@property NSString* management;
@property NSString *comments;


@end


RLM_ARRAY_TYPE(Tree)
