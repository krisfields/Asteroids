//
//  ScoreViewController.h
//  Asteroids
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameView.h"

@interface ScoreViewController : UIViewController <GameViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *scoreOutlet;
@property (weak, nonatomic) IBOutlet UILabel *AsteroidsDestroyedOutlet;
@property (weak, nonatomic) IBOutlet UILabel *levelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *highScoreOutlet;

@end
