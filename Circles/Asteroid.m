//
//  Asteroid.m
//  Asteroids
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import "Asteroid.h"
#import <QuartzCore/QuartzCore.h>

@implementation Asteroid

-(double)randomNumber{
    return (((double) arc4random() / UINT_MAX) * 30)+10;
}
-(double)randomIntensity{
    return (double) arc4random() / UINT_MAX;
}
-(UIColor *)randomColor{
    return [UIColor colorWithRed:[self randomIntensity] green:[self randomIntensity] blue:[self randomIntensity] alpha:[self randomIntensity]];
}
+(Asteroid*)drawAsteroidWithPosition:(CGPoint)position withView:(UIView *)view{
    Asteroid *newAsteroid = [[Asteroid alloc]init];
    newAsteroid.layer = [CALayer new];
    newAsteroid.layer.bounds = CGRectMake(0.0, 0.0, [newAsteroid randomNumber], [newAsteroid randomNumber]);
    newAsteroid.layer.position = position;
    newAsteroid.layer.delegate = newAsteroid;
    [newAsteroid.layer setNeedsDisplay];
    [view.layer addSublayer:newAsteroid.layer];
    
    return newAsteroid;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSetFillColorWithColor(ctx, [[self randomColor] CGColor]);
    CGContextFillEllipseInRect(ctx, layer.bounds);
}
-(void)move
{
    double xPos = ((double) arc4random() / UINT_MAX) * (self.layer.superlayer.bounds.size.width);
    double yPos = ((double) arc4random() / UINT_MAX) * (self.layer.superlayer.bounds.size.height);
    [self.layer setPosition:CGPointMake(xPos, yPos)];
    
}

@end
