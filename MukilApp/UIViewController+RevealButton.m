//
//  UINavigationController+RevealButton.m
//  PinkyApp
//
//  Created by Arsalan on 3/16/15.
//  Copyright (c) 2015 Arsalan. All rights reserved.
//

#import "UIViewController+RevealButton.h"
#import "SWRevealViewController.h"

@implementation UIViewController (RevealButton)

-(void)addRevealButton{
 
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];    
    [self.view addGestureRecognizer:tap];

}

@end
