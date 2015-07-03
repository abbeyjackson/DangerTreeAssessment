//
//  Placeholder.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-19.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Placeholder : NSObject


// tree properties for LOD1 trees:
@property (strong, nonatomic) NSString* insecure;
@property (strong, nonatomic) NSString* unstable;
@property (strong, nonatomic) NSString* leaning;

// tree properties for LOD23 trees:
@property (strong, nonatomic) NSString* hazardousTop;
@property (strong, nonatomic) NSString* deadLimbs;
@property (strong, nonatomic) NSString* witchesBroom;
@property (strong, nonatomic) NSString* splitTrunk;
@property (strong, nonatomic) NSString* stemDamage;
@property (strong, nonatomic) NSString* sloughingBark;
@property (strong, nonatomic) NSString* cankers;
@property (strong, nonatomic) NSString* conksMushrooms;
@property (strong, nonatomic) NSString* treeLean;
@property (strong, nonatomic) NSString* rootInspection;

@property (assign, nonatomic) BOOL isDangerous;


@end
