//
//  NavigationPinchTableViewController.m
//  NavigationPinch
//
//  Created by Nate West on 1/9/13.
//  Copyright (c) 2013 Nate West. All rights reserved.
//

#import "NavigationPinchTableViewController.h"
#import "NavigationPinchTableViewCell.h"

@interface NavigationPinchTableViewController ()

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@property (nonatomic) UIColor *randColor;

@end

@implementation NavigationPinchTableViewController {
    NSArray *_colors;
    BOOL _tabBarIsHidden;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        if (!_colors) {
            _colors = @[
                [UIColor colorWithHue:0.500 saturation:1.000 brightness:0.502 alpha:1.000], //teal
                [UIColor colorWithHue:0.250 saturation:1.000 brightness:0.502 alpha:1.000], //fern
                [UIColor colorWithHue:1.000 saturation:0.600 brightness:1.000 alpha:1.000]  //salmon
            ];
        }
    }
    
    _tabBarIsHidden = NO;
    return self;
}

- (UIColor *)randColor
{
    _randColor = [UIColor clearColor];
    if (_colors) _randColor = [_colors objectAtIndex:(arc4random() % [_colors count])];
    return _randColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                                     initWithTarget:self
                                             action:@selector(pinch:)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = self.randColor;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[NavigationPinchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"Cell"];
    }
    
    return cell;
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

#pragma mark - UINavigtionBar and UITabBar handling

- (void)hideBarsAnimated:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self hideTabBar];
}

- (void)showBarsAnimated:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self showTabBar];
}

- (void)hideTabBar
{
    if (_tabBarIsHidden == NO) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
        
        self.parentViewController.tabBarController.tabBar.hidden = YES;
        
        // reset frame
        
        [UIView commitAnimations];
        _tabBarIsHidden = YES;
    }
    
}

- (void)showTabBar
{
    if (_tabBarIsHidden) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
        
        self.parentViewController.tabBarController.tabBar.hidden = NO;
        
        // reset frame
        
        [UIView commitAnimations];
        _tabBarIsHidden = NO;
    }
}

@end
