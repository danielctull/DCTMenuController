//
//  UIMenuController+DCTMenuControllerDelegate.h
//  DCTMenuController
//
//  Created by Daniel Tull on 06.05.2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCTMenuControllerDelegate;

@interface UIMenuController (DCTMenuControllerDelegate)
- (void)dct_displayMenuWithDelegate:(id <DCTMenuControllerDelegate>)delegate;
- (void)dct_displayMenuWithDelegate:(id <DCTMenuControllerDelegate>)delegate animated:(BOOL)animated;
@end

@protocol DCTMenuControllerDelegate <NSObject>
- (void)menuController:(UIMenuController *)menuController didSelectItemAtIndex:(NSInteger)index;
@end
