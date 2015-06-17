//
//  SitePractice.m
//  DangerTreeAssessment
//
//  Created by Alain  on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "SitePractice.h"

@implementation SitePractice

-(instancetype)initWithLocation:(NSString*)location{
    self = [super init];
    if (self) {
        _location = location;
    }
    return self;
}

@end
