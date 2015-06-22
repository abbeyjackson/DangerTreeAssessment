//
//  Site.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "Site.h"

NSString* const kLODType1 = @"LOD 1";
NSString* const kLODType23 = @"LOD 23";
NSString* const kLODType4 = @"LOD 4";

NSString* const kC1 = @"C1";
NSString* const kC2 = @"C2";
NSString* const kC3 = @"C3";
NSString* const kC4 = @"C4";
NSString* const kC5 = @"C5";
NSString* const kC6 = @"C6";
NSString* const kC7 = @"C7";
NSString* const kD1 = @"D1";
NSString* const kM1 = @"M1";
NSString* const kM2 = @"M2";
NSString* const kM3 = @"M3";
NSString* const kM4 = @"M4";
NSString* const kS1 = @"S1";
NSString* const kS2 = @"S2";
NSString* const kS3 = @"S3";
NSString* const kO1a = @"k01a";
NSString* const kO1b = @"k01b";

@implementation Site

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"isReportComplete" : @"NO"};
}

//+ (NSString *)primaryKey {
//    return @"id";
//}

@end
