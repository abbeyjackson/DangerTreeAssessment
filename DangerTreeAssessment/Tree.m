//
//  Tree.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "Tree.h"


// wildlife tree value
NSString* const kL = @"LOW";
NSString* const kM = @"MEDIUM";
NSString* const kH = @"HIGH";

// rating
NSString* const kDangerous = @"Dangerous";
NSString* const kClass1 = @"Class 1 = S";
NSString* const kClass2NoDefects = @"Class 2, No Defects = S";
NSString* const kClass2LowFailure = @"Class 2, Low Failure = S";
NSString* const kClass3NoDefects = @"Class 3, No Defects = S";

// management
NSString* const kNoAction = @"Safe - No Action";
NSString* const kFallTree = @"Dangerous - Fall Tree";
NSString* const kInstallNWZ = @"Dangerous - Install NWZ";
NSString* const kOther = @"Other, Remove Hazard";

@implementation Tree


// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"insecure" : @"", @"unstable": @"", @"leaning" : @"", @"hazardousTop" : @"", @"deadLimbs" : @"", @"witchesBroom" : @"", @"splitTrunk" : @"", @"stemDamage" : @"", @"sloughingBark" : @"", @"cankers" : @"", @"conksMushrooms" : @"", @"treeLean" : @"", @"rootInspection" : @"", @"rating" : @"", @"isDangerous" : @"NO", @"management" : @"", @"comments" : @"", @"isReportComplete" : @"NO"};
}

//+ (NSString *)primaryKey {
//    return @"id";
//}

@end
