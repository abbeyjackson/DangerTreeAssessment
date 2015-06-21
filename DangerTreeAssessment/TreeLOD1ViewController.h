//
//  TreeLOD1ViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tree;
@class Placeholder;
@class Site;

@interface TreeLOD1ViewController : UIViewController

@property (nonatomic,strong) Tree *tree;
@property (nonatomic, strong) Placeholder *placeholder;
@property (nonatomic, strong) Site *site;


@end
