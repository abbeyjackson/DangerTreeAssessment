//
//  Tree.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Realm/Realm.h>
@class Site;

typedef enum : int {
    L,
    M,
    H,
} WildLifeValue;

typedef enum : int {
    Dangerous,
    Class1,
    Class2NoDefects,
    Class2LowFailure,
    Class3NoDefects,
} Rating;

typedef enum : int {
    NoAction,
    FallTree,
    InstallNWZ,
    RemoveHazard
} ActionRequired;

@interface Tree : RLMObject

@property Site *site;

// tree properties for all trees:
@property double lat;
@property double lon;
@property NSString* species;
@property NSString* treeClass;
@property WildLifeValue wildLifeValue;

// tree properties for LOD1 trees:
@property BOOL insecure;
@property BOOL unstable;
@property BOOL leaning;

// tree properties for LOD23 trees:
@property BOOL hazardousTop;
@property BOOL deadLimbs;
@property BOOL witchesBroom;
@property BOOL splitTrunk;
@property BOOL stemDamage;
@property BOOL sloughingBark;
@property BOOL cankers;
@property BOOL conksMushrooms;
@property BOOL treenLean;
@property BOOL rootInspection;

// tree properties for LOD4 trees:
@property Rating rating;

// tree properties for management (all trees)
@property BOOL safeOrDangerous;
@property ActionRequired action;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<Tree>
RLM_ARRAY_TYPE(Tree)
