//
//  ZViewController.m
//
//  Created by Ayal Spitz on 1/7/14.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import "ZViewController.h"
#import "ZTriViewController.h"
#import "AViewController.h"
#import "UIView+Constraints.h"

@interface ZViewController ()
@property (nonatomic, strong) ZTriViewController *triViewController;
@end

@implementation ZViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.triViewController = [[ZTriViewController alloc]init];
    
    AViewController *viewController = nil;
    viewController = [[AViewController alloc]init];
    viewController.view.backgroundColor = [UIColor redColor];
    viewController.title = @"left";
    viewController.view.layer.borderColor = [[UIColor blackColor]CGColor];
    viewController.view.layer.borderWidth = 1.0;
    [self.triViewController setViewController:viewController forPosition:TriViewLeftPosition];
    
    viewController = [[AViewController alloc]init];
    viewController.view.backgroundColor = [UIColor yellowColor];
    viewController.title = @"center";
    viewController.view.layer.borderColor = [[UIColor redColor]CGColor];
    viewController.view.layer.borderWidth = 1.0;
    [self.triViewController setViewController:viewController forPosition:TriViewPrimaryPosition];
    
    viewController = [[AViewController alloc]init];
    viewController.view.backgroundColor = [UIColor greenColor];
    viewController.title = @"right";
    viewController.view.layer.borderColor = [[UIColor yellowColor]CGColor];
    viewController.view.layer.borderWidth = 1.0;
    [self.triViewController setViewController:viewController forPosition:TriViewRightPosition];
    
    [self addChildViewController:self.triViewController];
    [self.view addSubview:self.triViewController.view];
    [self.triViewController didMoveToParentViewController:self];
    
    [self.view addFullViewConstraints:self.triViewController.view];
    [self.view layoutIfNeeded];
}

@end
