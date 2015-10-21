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
UIDynamicAnimator* _animator;
UIGravityBehavior* _gravity;
UICollisionBehavior *_collision;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 100.0f, 300.0f, 200.0f)];
    [square setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:square];

    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         [square setFrame:CGRectMake(0.0f, 100.0f, 300.0f, 200.0f)];
                     }
                     completion:nil];

    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];

    [_animator addBehavior:_gravity];
    

    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    [_collision setTranslatesReferenceBoundsIntoBoundary:YES];

    [_animator addBehavior:_collision];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end