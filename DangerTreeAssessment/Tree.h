//
//  Tree.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Realm/Realm.h>
@class Site;


// wildlife tree value
extern NSString* const kL;
extern NSString* const kM;
extern NSString* const kH;

// rating
extern NSString* const kDangerous;
extern NSString* const kClass1;
extern NSString* const kClass2NoDefects;
extern NSString* const kClass2LowFailure;
extern NSString* const kClass3NoDefects;

// management
extern NSString* const kNoAction;
extern NSString* const kFallTree;
extern NSString* const kInstallNWZ;
extern NSString* const kOther;


@interface Tree : RLMObject

// internal properties
@property Site *site;
@property NSString *treeNumber;
@property NSString *treeID;


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

// This protocol enables typed collections. i.e.:
// RLMArray<Tree>
RLM_ARRAY_TYPE(Tree)
