//
//  ZTriViewController.h
//
//  Created by Ayal Spitz on 12/22/13.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TriViewPosition){
    TriViewLeftPosition,
    TriViewPrimaryPosition,
    TriViewRightPosition
};

@interface ZTriViewController : UIViewController
- (void)setViewController:(UIViewController *)viewController forPosition:(TriViewPosition)position;
- (UIViewController *)viewControllerForPosition:(TriViewPosition)position;
@end
