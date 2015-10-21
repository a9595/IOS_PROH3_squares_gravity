//
//  ViewController.m
//  PROH3_squares
//
//  Created by Admin on 10/21/15.
//  Copyright (c) 2015 tieorange. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
UIDynamicAnimator *_animator;
UIGravityBehavior *_gravity;
UICollisionBehavior *_collision;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(100,100,100,100)];
    [square setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:square];

    UIView *barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
    [barrier setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:barrier];

    CGPoint rightEdge = CGPointMake(
            barrier.frame.origin.x + barrier.frame.size.width,
            barrier.frame.origin.y
    );
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];


    [_animator addBehavior:_gravity];


    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    [_collision setTranslatesReferenceBoundsIntoBoundary:YES];
    [_collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrier.frame.origin toPoint:rightEdge];


    [_animator addBehavior:_collision];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end