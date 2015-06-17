//
//  Site.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Realm/Realm.h>

@interface Site : RLMObject




@end

// This protocol enables typed collections. i.e.:
// RLMArray<Site>
RLM_ARRAY_TYPE(Site)
