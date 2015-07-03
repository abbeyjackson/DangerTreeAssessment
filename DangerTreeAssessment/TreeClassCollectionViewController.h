//
//  TreeClassCollectionViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TreeClass;


@protocol ClassDelegate <NSObject>

-(void)selectClass:(TreeClass*)class;

@end


@interface TreeClassCollectionViewController : UICollectionViewController


@property (weak, nonatomic) id<ClassDelegate> delegate;


@end
