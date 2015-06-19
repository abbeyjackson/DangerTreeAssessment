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
    OtherRemoveHazard
} ActionRequired;

typedef enum : int{
    Fd,
    Lw,
    Pl,
    Py,
    Pw,
    Sw,
    Se,
    Ss,
    Bl,
    Ba,
    Bg,
    Hw,
    Cw,
    Cy,
    Ac,
    At,
    Ep,
    Dr,
    Mb,
}TreeSpecies;

typedef enum : int{
    c1,
    c2,
    c3,
    c4,
    c5,
    c6,
    c7,
    c8,
    c9,
    h1,
    h2,
    h3,
    h4,
    h5,
    h6,
}TreeClass;


@interface Tree : RLMObject

@property Site *site;

// tree properties for all trees:
@property double lat;
@property double lon;
@property TreeSpecies species;
@property TreeClass treeClass;
@property WildLifeValue wildLifeValue;

// tree properties for LOD1 trees:
@property BOOL lod1Insecure;
@property BOOL lod1Unstable;
@property BOOL lod1Leaning;

// tree properties for LOD23 trees:
@property BOOL lod23HazardousTop;
@property BOOL lod23DeadLimbs;
@property BOOL lod23WitchesBroom;
@property BOOL lod23SplitTrunk;
@property BOOL lod23StemDamage;
@property BOOL lod23SloughingBark;
@property BOOL lod23Cankers;
@property BOOL lod23ConksMushrooms;
@property BOOL lod23TreenLean;
@property BOOL lod23RootInspection;

// tree properties for LOD4 trees:
@property Rating lod4Rating;

// tree properties for management (all trees)
@property BOOL isDangerous;
@property ActionRequired action;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<Tree>
RLM_ARRAY_TYPE(Tree)
