//
//  ViewController.m
//  DCTMenuController
//
//  Created by Daniel Tull on 06.05.2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import "ViewController.h"

@interface DCTMenuItem : UIMenuItem
@end

@implementation DCTMenuItem
@end

@implementation ViewController

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self.view];
	
	NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:3];
	for (NSInteger i = 0; i < 3; i++) {
		NSString *itemTitle = [NSString stringWithFormat:@"%i", i];
		UIMenuItem *item = [[DCTMenuItem alloc] initWithTitle:itemTitle action:nil];
		[array addObject:item];
	}
	
	UIMenuController *menuController = [UIMenuController sharedMenuController];
	[menuController setMenuItems:array];
	[menuController setTargetRect:CGRectMake(location.x, location.y, 0.0f, 0.0f) inView:self.view];
	menuController.arrowDirection = UIMenuControllerArrowUp;
	[menuController dct_displayMenuWithDelegate:self animated:YES];
	
	[super touchesEnded:touches withEvent:event];
}

- (void)menuController:(UIMenuController *)menuController didSelectItemAtIndex:(NSInteger)index {
	NSLog(@"%@:%@ %@", self, NSStringFromSelector(_cmd), [menuController.menuItems objectAtIndex:index]);	
}

@end
