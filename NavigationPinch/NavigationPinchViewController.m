//
//  NavigationPinchViewController.m
//  NavigationPinch
//
//  Created by Nate West on 1/11/13.
//  Copyright (c) 2013 Nate West. All rights reserved.
//

#import "NavigationPinchViewController.h"

@interface NavigationPinchViewController ()

@end

@implementation NavigationPinchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(pinch:)]];
    
    [self.view addGestureRecognizer:[[UISwipeGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(swipe:)]];
}

#pragma mark - Gesture recognizer handling

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (gesture.scale > 1) {
            [self hideBarsAnimated:YES];
        } else if (gesture.scale < 1) {
            [self showBarsAnimated:YES];
        }
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture
{
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UINavigtionBar hide n' seek

- (void)hideBarsAnimated:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController setToolbarHidden:YES animated:animated];
}

- (void)showBarsAnimated:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController setToolbarHidden:NO animated:animated];
}

@end
