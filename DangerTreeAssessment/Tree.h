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

@interface Tree : RLMObject

@property Site *site;

@property double lat;
@property double lon;
@property NSString* species;
@property NSString* treeClass;
@property WildLifeValue wildLifeValue;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<Tree>
RLM_ARRAY_TYPE(Tree)
