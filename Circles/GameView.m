//
//  AsteroidView.m
//  Asteroids
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import "GameView.h"
#import "Asteroid.h"

@interface GameView ()

@property (nonatomic, strong) NSMutableArray *asteroids;

@end

@implementation GameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.asteroids = [NSMutableArray new];
        
        for (int i=0; i<202; i++) {
            double xPos = ((double) arc4random() / UINT_MAX) * (frame.size.width);
            double yPos = ((double) arc4random() / UINT_MAX) * (frame.size.height);
            Asteroid *newAsteroid = [Asteroid drawAsteroidWithPosition:CGPointMake(xPos, yPos) withView:self];
            [self.asteroids addObject:newAsteroid];
        }
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (Asteroid* asteroid in self.asteroids){
        [asteroid move];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
