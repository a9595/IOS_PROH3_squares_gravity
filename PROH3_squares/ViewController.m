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

@implementation ViewController {

}
UIDynamicAnimator *_animator;
UIGravityBehavior *_gravity;
UICollisionBehavior *_collision;
UIDynamicItemBehavior *_ballBehavior;

//int count;

- (void)viewDidLoad {
    [super viewDidLoad];
    //count = 0;
    const int barrierWidth = 130;
    int barrierHeight = 20;

    UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 40, 40)];
    [ball setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:ball];


    //init barrier
    UIView *barrier = [[UIView alloc] initWithFrame:CGRectMake(100, 100, barrierWidth, barrierHeight)];
    [barrier setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:barrier];
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x + barrier.frame.size.width, barrier.frame.origin.y); //set barrier egde


    UIView *barrierOpponent = [[UIView alloc] initWithFrame:CGRectMake(100, 500, barrierWidth, barrierHeight)];
    [barrierOpponent setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:barrierOpponent];
    //init opponents barrier

    CGPoint rightEdgeOpponent = CGPointMake(barrierOpponent.frame.origin.x + barrierOpponent.frame.size.width, barrierOpponent.frame.origin.y); //set opponents barrier egde



//    // Step 5: Move paddle
//    self.attacher =
//            [[UIAttachmentBehavior alloc]
//                    initWithItem:self.paddleView
//                attachedToAnchor:CGPointMake(CGRectGetMidX(self.paddleView.frame),
//                        CGRectGetMidY(self.paddleView.frame))];

    //Move paddle
    self.attacher = [[UIAttachmentBehavior alloc]
            initWithItem:barrierOpponent
        attachedToAnchor:CGPointMake(CGRectGetMidX(barrierOpponent.frame),
                CGRectGetMidY(barrierOpponent.frame))];


    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tapGR];


    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[ball]];
    [_animator addBehavior:_gravity];



    ////EXAMPLE FROM GITHUB:
//    // Step 1: Add collisions
//    self.collider = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.paddleView]];
//    self.collider.collisionDelegate = self;
//    self.collider.collisionMode = UICollisionBehaviorModeEverything;
//    self.collider.translatesReferenceBoundsIntoBoundary = YES;
//    [self.animator addBehavior:self.collider];

    //MY_NEW_CODE:
    _collision = [[UICollisionBehavior alloc] initWithItems:@[ball, barrier, barrierOpponent]];
    [_collision setTranslatesReferenceBoundsIntoBoundary:YES];
    _collision.collisionDelegate = self;
    _collision.collisionMode = UICollisionBehaviorModeEverything;
    _collision.translatesReferenceBoundsIntoBoundary = YES;



    //MY OLD CODE:
//    _collision = [[UICollisionBehavior alloc] initWithItems:@[ball]];
//    [_collision setTranslatesReferenceBoundsIntoBoundary:YES];
//    [_collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrier.frame.origin toPoint:rightEdge];
//    [_collision addBoundaryWithIdentifier:@"barrierOpponent" fromPoint:barrierOpponent.frame.origin toPoint:rightEdgeOpponent];
//    [_collision setCollisionDelegate:self];


    _ballBehavior = [[UIDynamicItemBehavior alloc]
            initWithItems:@[ball]];
    _ballBehavior.allowsRotation = NO;
    [_ballBehavior setElasticity:1.0];
    [_ballBehavior setFriction:0];
    [_ballBehavior setResistance:0];


    // Heavy paddle

    self.barrierDynamicProperties = [[UIDynamicItemBehavior alloc] initWithItems:@[barrier, barrierOpponent]];
    self.barrierDynamicProperties.allowsRotation = NO;
    _barrierDynamicProperties.density = 1000.0f;

    [_animator addBehavior:self.barrierDynamicProperties];
    [_animator addBehavior:_collision];
    [_animator addBehavior:_ballBehavior];
    [_animator addBehavior:_attacher];

}

- (void)tapped:(UIGestureRecognizer *)gr {
    self.attacher.anchorPoint = [gr locationInView:self.view];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior
      beganContactForItem:(id <UIDynamicItem>)item
   withBoundaryIdentifier:(id <NSCopying>)identifier
                  atPoint:(CGPoint)p {
    NSLog(@"Method is invoked - %@", identifier);


//    UIView *sq = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 15, 15)];
//    [sq setBackgroundColor:[UIColor grayColor]];
//    [self.view addSubview:sq];

    //UIDynamicItemBehavior *ib = [[UIDynamicItemBehavior alloc] initWithItems:@[sq]];
    //[ib setElasticity:1.1];

//    UIView *rect = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 10, 10)];
//    [rect setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:rect];


    UIView *view = (UIView *) item;

    UIColor *tmp = [view backgroundColor];

    [view setBackgroundColor:[UIColor yellowColor]];
    [UIView animateWithDuration:0.5 animations:^{
        [view setBackgroundColor:tmp];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TODO make a ping pong with elasticity 1.1

@end