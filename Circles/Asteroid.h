//
//  Asteroid.h
//  Asteroids
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Asteroid : NSObject

@property (strong) CALayer* layer;
+(Asteroid*)drawAsteroidWithPosition:(CGPoint)position withView:(UIView *)view;
-(void)move;
@end
