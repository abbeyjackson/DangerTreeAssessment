//
//  TreeClassCollectionViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeClass.h"

@protocol ClassDelegate <NSObject>

-(void)selectClass:(TreeClass*)class;

@end

@interface TreeClassCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<ClassDelegate> delegate;

@end
