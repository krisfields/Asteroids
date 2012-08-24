//
//  Ship.m
//  Asteroids
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import "Ship.h"
#import <QuartzCore/QuartzCore.h>

@implementation Ship


+(Ship*)drawShipWithPosition:(CGPoint)position withView:(UIView *)view{
    Ship *newShip = [[Ship alloc]init];
    newShip.layer = [CALayer new];
    newShip.layer.bounds = CGRectMake(0.0, 0.0, 80, 77);
    newShip.layer.position = position;
    newShip.layer.delegate = newShip;
    [newShip.layer setNeedsDisplay];
    UIImage *layerImage = [UIImage imageNamed:@"rocketShip.jpeg"];
    CGImageRef image = [layerImage CGImage];
    [newShip.layer setContents:(__bridge id)image];
    [view.layer addSublayer:newShip.layer];
    

    return newShip;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{

//    [layer setBackgroundColor:[UIColor blueColor]  ];
    
    
//    [boxLayer setContentsRect:CGRectMake(-0.1, -0.1, 1.2, 1.2)];
//    CGContextSetFillColorWithColor(ctx, [[self randomColor] CGColor]);
//    CGContextFillEllipseInRect(ctx, layer.bounds);
}

@end
