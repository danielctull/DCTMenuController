//
//  UIMenuController+DCTMenuControllerDelegate.m
//  DCTMenuController
//
//  Created by Daniel Tull on 06.05.2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import "UIMenuController+DCTMenuControllerDelegate.h"

NSString *const DCTMenuHandlerSelectorPrefix = @"menuItem";

@interface DCTMenuHandler : UIView
@property (nonatomic, weak) id<DCTMenuControllerDelegate> delegate;
@property (nonatomic, weak) UIMenuController *menuController;
@end


@implementation UIMenuController (DCTMenuControllerDelegate)

- (void)dct_displayMenuWithDelegate:(id <DCTMenuControllerDelegate>)delegate {
	[self dct_displayMenuWithDelegate:delegate animated:NO];
}

- (void)dct_displayMenuWithDelegate:(id <DCTMenuControllerDelegate>)delegate animated:(BOOL)animated {
	
	UIWindow *window = [[UIApplication sharedApplication] keyWindow];
	DCTMenuHandler *handler = [[DCTMenuHandler alloc] initWithFrame:CGRectZero];
	handler.delegate = delegate;
	handler.menuController = self;
	[window addSubview:handler];
	[handler becomeFirstResponder];
	
	[self.menuItems enumerateObjectsUsingBlock:^(UIMenuItem *item, NSUInteger i, BOOL *stop) {
		NSString *selectorString = [NSString stringWithFormat:@"%@%i:", DCTMenuHandlerSelectorPrefix, i];
		item.action = NSSelectorFromString(selectorString);
	}];
	
	[self setMenuVisible:YES animated:animated];
}

@end

@implementation DCTMenuHandler
@synthesize delegate = _delegate;
@synthesize menuController = _menuController;

- (void)forwardInvocation:(NSInvocation *)invocation {
	
	SEL selector = invocation.selector;
	NSString *selectorString = NSStringFromSelector(selector);
	
	if ([selectorString hasPrefix:DCTMenuHandlerSelectorPrefix]) {
		
		NSString *numberString = [selectorString stringByReplacingOccurrencesOfString:DCTMenuHandlerSelectorPrefix withString:@""];
		numberString = [numberString stringByReplacingOccurrencesOfString:@":" withString:@""];
		NSInteger i = [numberString integerValue];
		
		[self.delegate menuController:self.menuController didSelectItemAtIndex:i];
		[self removeFromSuperview];
		return;
    }
	
	[super forwardInvocation:invocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
	
	NSString *selectorString = NSStringFromSelector(selector);
	if ([selectorString hasPrefix:DCTMenuHandlerSelectorPrefix])
		return [[self class] instanceMethodSignatureForSelector:@selector(methodSignatureForSelector:)];
	
	return [super methodSignatureForSelector:selector];
}

- (BOOL)canPerformAction:(SEL)selector withSender:(id)sender {
	
	NSString *selectorString = NSStringFromSelector(selector);
	if ([selectorString hasPrefix:DCTMenuHandlerSelectorPrefix]) return YES;
	
    return [super canPerformAction:selector withSender:sender];
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

@end
