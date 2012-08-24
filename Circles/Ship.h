//
//  Ship.h
//  Asteroids
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ship : NSObject

@property (strong) CALayer* layer;

+(Ship*)drawShipWithPosition:(CGPoint)position withView:(UIView *)view;

@end
