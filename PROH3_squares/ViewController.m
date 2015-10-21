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

int count;

- (void)viewDidLoad {
    [super viewDidLoad];

    count = 0;
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
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
    [_collision setCollisionDelegate:self];

//    [_collision setAction:^{
//        NSLog(
//                @"%@, %@",
//                NSStringFromCGAffineTransform(square.transform),
//                NSStringFromCGPoint(square.center)
//        );
//    }];


    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]
            initWithItems:@[square]];
    [itemBehavior setElasticity:1.0];

    [_animator addBehavior:_collision];
    [_animator addBehavior:itemBehavior];

}

- (void)collisionBehavior:(UICollisionBehavior *)behavior
      beganContactForItem:(id <UIDynamicItem>)item
   withBoundaryIdentifier:(id <NSCopying>)identifier
                  atPoint:(CGPoint)p {
    NSLog(@"Method is invoked - %@", identifier);


    UIView *sq = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 15, 15)];
    [sq setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:sq];

    UIDynamicItemBehavior *ib = [[UIDynamicItemBehavior alloc] initWithItems:@[sq]];
    [ib setElasticity:1.1];

    UIView *rect = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 10, 10)];
    [rect setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:rect];



    UIView *view = (UIView *) item;

    UIColor *tmp = [view backgroundColor];

    [view setBackgroundColor:[UIColor yellowColor]];
    [UIView animateWithDuration:0.3 animations:^{
        [view setBackgroundColor:tmp];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TODO make a ping pong with elasticity 1.1

@end