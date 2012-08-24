//
//  AsteroidView.m
//  Asteroids
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import "GameView.h"
#import "Asteroid.h"
#import "Ship.h"
#import <QuartzCore/QuartzCore.h>

@interface GameView () <UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *asteroids;
@property (nonatomic, strong) Ship* ship;
@property (nonatomic, strong) NSTimer *collisionTimer;


@end

@implementation GameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.ship = [Ship drawShipWithPosition:CGPointMake(160, 240) withView:self];

        [self setupGame];

    }
    return self;
}
-(void)setupGame
{
    for (Asteroid* asteroid in self.asteroids){
        [asteroid.layer removeFromSuperlayer];
        
    }
    self.asteroids = [NSMutableArray new];
    self.addAnotherAsteroid = NO;
//    [self.delegate gameOver];
    for (int i=0; i<1; i++) {
        Asteroid *newAsteroid = [Asteroid drawAsteroidWithPosition:CGPointMake(0.0, 0.0) withView:self];
        [self.asteroids addObject:newAsteroid];
        
    }
    self.collisionTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(collision:) userInfo:nil repeats:YES];

    
}
-(void)collision:(NSDictionary *)notUsed
{
    for (Asteroid* asteroid in self.asteroids) {
        CALayer *asteroidPresentationLayer = [asteroid.layer presentationLayer];
        if (CGRectIntersectsRect(asteroidPresentationLayer.frame, self.ship.layer.frame)) {
            [self.collisionTimer invalidate];
            [self.delegate gameOver];
            break;

        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    for (Asteroid* asteroid in self.asteroids) {
        CALayer *asteroidPresentationLayer = [asteroid.layer presentationLayer];
        if (CGRectContainsPoint(asteroidPresentationLayer.frame, touchPoint)) {

//            [self increaseScore];
            [asteroid.layer removeFromSuperlayer];
            [self.asteroids removeObject:asteroid];
            [self replaceAsteroids];
            [self.delegate asteroidDestroyed];
            break;
        }
    }
}
-(void)replaceAsteroids
{
    int numberOfReplacementAsteroids = 1;
    if (self.addAnotherAsteroid)
    {
        numberOfReplacementAsteroids +=1;
        self.addAnotherAsteroid = NO;
    }
    for (int i=0; i< numberOfReplacementAsteroids; i++) {
        Asteroid *newAsteroid = [Asteroid drawAsteroidWithPosition:CGPointMake(0.0, 0.0) withView:self];
        [self.asteroids addObject:newAsteroid];
        
    }
}
//-(void)increaseScore
//{
//    self.score += 100;
//    if (self.score % 1000 == 0){
//        self.addAnotherAsteroid = YES;
//    }
//        
//}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    for (Asteroid* asteroid in self.asteroids){
//        [asteroid move];
//    }
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
