//
//  ZAViewController.m
//  SlideCollection
//
//  Created by Ayal Spitz on 12/21/13.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import "AViewController.h"

@implementation AViewController

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"[%@] viewDidAppear", self.title);
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"[%@] viewDidDisappear", self.title);
}
@end
