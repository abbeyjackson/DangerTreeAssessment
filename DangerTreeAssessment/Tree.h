//
//  Tree.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Realm/Realm.h>
@class Site;

// tree species values
//extern NSString* const kFd;
//extern NSString* const kLw;
//extern NSString* const kPl;
//extern NSString* const kPy;
//extern NSString* const kPw;
//extern NSString* const kSw;
//extern NSString* const kSe;
//extern NSString* const kSs;
//extern NSString* const kBl;
//extern NSString* const kBa;
//extern NSString* const kBg;
//extern NSString* const kHw;
//extern NSString* const kCw;
//extern NSString* const kCy;
//extern NSString* const kAc;
//extern NSString* const kAt;
//extern NSString* const kEp;
//extern NSString* const kDr;
//extern NSString* const kMb;

// tree class values
//extern NSString* const kc1;
//extern NSString* const kc2;
//extern NSString* const kc3;
//extern NSString* const kc4;
//extern NSString* const kc5;
//extern NSString* const kc6;
//extern NSString* const kc7;
//extern NSString* const kc8;
//extern NSString* const kc9;
//extern NSString* const kh1;
//extern NSString* const kh2;
//extern NSString* const kh3;
//extern NSString* const kh4;
//extern NSString* const kh5;
//extern NSString* const kh6;

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

@property Site *site;

// tree properties for all trees:
@property double lat;
@property double lon;
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
