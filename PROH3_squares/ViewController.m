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

    UIView *_ball;
    int _barrierWidth;
    int _barrierHeight;
    UIView *_barrier;
    CGPoint _rightEdge;
    UIView *_barrierOpponent;
    CGPoint _rightEdgeOpponent;
    UITapGestureRecognizer *_tapGR;
}
UIDynamicAnimator *_animator;
UIGravityBehavior *_gravity;
UICollisionBehavior *_collision;
UIDynamicItemBehavior *_ballBehavior;

//int count;

- (void)viewDidLoad {
    [super viewDidLoad];
    //count = 0;
    _barrierWidth = 130;
    _barrierHeight = 20;

    //init ball
    _ball = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 40, 40)];
    [_ball setBackgroundColor:[UIColor redColor]];
    _ball.layer.cornerRadius = 32.0;
    _ball.layer.borderColor = [UIColor blackColor].CGColor;
    _ball.layer.borderWidth = 2.0;
    _ball.layer.shadowOffset = CGSizeMake(5, 8);
    _ball.layer.shadowOpacity = 0.5;

    [self.view addSubview:_ball];
    
    //PUSHER

    //self.pusher = [[UIPushBehavior alloc] initWithItems:@[_ball]];
    //self.pusher.push
// Start ball off with a push
//er    self.pusher = [[UIPushBehavior alloc] initWithItems:@[self.ballView]
//                                                   mode:UIPushBehaviorModeInstantaneous];
//    self.pusher.pushDirection = CGVectorMake(0.5, 1.0);
//    self.pusher.active = YES; // Because push is instantaneous, it will only happen once
//    [self.animator addBehavior:self.pusher];    
//    



    //init barrier
    _barrier = [[UIView alloc] initWithFrame:CGRectMake(100, 100, _barrierWidth, _barrierHeight)];
    [_barrier setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_barrier];
    _rightEdge = CGPointMake(_barrier.frame.origin.x + _barrier.frame.size.width, _barrier.frame.origin.y); //set barrier egde


    //init opponent's barrier
    _barrierOpponent = [[UIView alloc] initWithFrame:CGRectMake(100, 500, _barrierWidth, _barrierHeight)];
    [_barrierOpponent setBackgroundColor:[UIColor grayColor]];
    _barrierOpponent.layer.cornerRadius = 8.0;
    _barrierOpponent.layer.borderWidth = 2.0;
    _barrierOpponent.layer.borderColor = [UIColor blackColor].CGColor;
    _barrierOpponent.layer.shadowOffset = CGSizeMake(5, 8);
    _barrierOpponent.layer.shadowOpacity = 0.5;
    [self.view addSubview:_barrierOpponent];
    //init opponents barrier

    _rightEdgeOpponent = CGPointMake(_barrierOpponent.frame.origin.x + _barrierOpponent.frame.size.width, _barrierOpponent.frame.origin.y); //set opponents barrier edge





    //Move barrier
    self.attacher = [[UIAttachmentBehavior alloc]
            initWithItem:_barrierOpponent
        attachedToAnchor:CGPointMake(CGRectGetMidX(_barrierOpponent.frame),
                CGRectGetMidY(_barrierOpponent.frame))];

    _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:_tapGR];


    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[_ball]];
    [_animator addBehavior:_gravity];




    //set collision
    _collision = [[UICollisionBehavior alloc] initWithItems:@[_ball, _barrier, _barrierOpponent]];
    [_collision setTranslatesReferenceBoundsIntoBoundary:YES];
    _collision.collisionDelegate = self;
    _collision.collisionMode = UICollisionBehaviorModeEverything;
    _collision.translatesReferenceBoundsIntoBoundary = YES;



    _ballBehavior = [[UIDynamicItemBehavior alloc]
            initWithItems:@[_ball]];
    _ballBehavior.allowsRotation = NO;
    [_ballBehavior setElasticity:1.05];
    [_ballBehavior setFriction:0];
    [_ballBehavior setResistance:0];


    // Heavy barrier
    self.barrierDynamicProperties = [[UIDynamicItemBehavior alloc] initWithItems:@[_barrier, _barrierOpponent]];
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