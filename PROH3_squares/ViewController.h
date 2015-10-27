//
//  ViewController.h
//  PROH3_squares
//
//  Created by Admin on 10/21/15.
//  Copyright (c) 2015 tieorange. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UICollisionBehaviorDelegate>


@property(nonatomic, strong) UIAttachmentBehavior *attacher;
@property(nonatomic, strong) UIDynamicItemBehavior *barrierDynamicProperties;
@end
