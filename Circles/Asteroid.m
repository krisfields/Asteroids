//
//  Asteroid.m
//  Asteroids
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import "Asteroid.h"
#import <QuartzCore/QuartzCore.h>

@interface Asteroid ()

@property int sideOfScreen;
@end
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
- (id)init{
    self=[super init];
    self.sideOfScreen = 4;
    return self;
}
+(Asteroid*)drawAsteroidWithPosition:(CGPoint)position withView:(UIView *)view{
    Asteroid *newAsteroid = [[Asteroid alloc]init];
    newAsteroid.layer = [CALayer new];
    newAsteroid.layer.bounds = CGRectMake(0.0, 0.0, 40.0, 42.0);
    newAsteroid.layer.position = position;
    newAsteroid.layer.delegate = newAsteroid;
    [newAsteroid.layer setNeedsDisplay];
    
    UIImage *layerImage = [UIImage imageNamed:@"asteroid.png"];
    CGImageRef image = [layerImage CGImage];
    [newAsteroid.layer setContents:(__bridge id)image];
    
    [view.layer addSublayer:newAsteroid.layer];
    
    [newAsteroid move];
    return newAsteroid;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
//    CGContextSetFillColorWithColor(ctx, [[self randomColor] CGColor]);

//    CGContextSetFillColorWithColor(ctx, [[UIColor grayColor] CGColor]);
//    CGContextFillEllipseInRect(ctx, layer.bounds);
}
-(void)move
{
    [CATransaction begin];

    [CATransaction setCompletionBlock:^{
        [self move];
    }];
    [CATransaction setAnimationDuration:5.0];
    int sideOfScreen = arc4random() % 4;
    while (sideOfScreen == self.sideOfScreen) {
        sideOfScreen = arc4random() % 4;
    }
    double xPos;
    double yPos;
    if (sideOfScreen == 0){
        xPos = ((double) arc4random() / UINT_MAX) * (self.layer.superlayer.bounds.size.width);
        yPos = 0.0;
        self.sideOfScreen = 0;
    }else if (sideOfScreen == 1){
        xPos = self.layer.superlayer.bounds.size.width;
        yPos = ((double) arc4random() / UINT_MAX) * (self.layer.superlayer.bounds.size.height);
        self.sideOfScreen = 1;
    }else if (sideOfScreen == 2){
        xPos = ((double) arc4random() / UINT_MAX) * (self.layer.superlayer.bounds.size.width);
        yPos = self.layer.superlayer.bounds.size.height;
        self.sideOfScreen = 2;
    }else if (sideOfScreen == 3){
        xPos = 0.0;
        yPos = ((double) arc4random() / UINT_MAX) * (self.layer.superlayer.bounds.size.height);
        self.sideOfScreen = 3;
    }


//        double xPos = ((double) arc4random() / UINT_MAX) * (self.layer.superlayer.bounds.size.width);
//        double yPos = ((double) arc4random() / UINT_MAX) * (self.layer.superlayer.bounds.size.height);
        [self.layer setPosition:CGPointMake(xPos, yPos)];

    [CATransaction commit];
//    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    [spin setDelegate:self];
//    [spin setToValue:[NSNumber numberWithFloat:M_PI*2]];
//    [spin setDuration:1.3];
//    
//    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [spin setTimingFunction:tf];
//    
//    [self.layer addAnimation:spin forKey:@"spinAnimation"];
}

@end
