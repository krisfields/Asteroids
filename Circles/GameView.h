//
//  CircleView.h
//  Circles
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ship.h"

@protocol GameViewDelegate <NSObject>

-(void)asteroidDestroyed;
-(void)gameOver;

@end
@interface GameView : UIView
@property BOOL addAnotherAsteroid;
@property id<GameViewDelegate> delegate;
@property (nonatomic, strong) Ship* ship;
@property (nonatomic, strong) NSTimer *collisionTimer;

-(void)setupGame;
@end
