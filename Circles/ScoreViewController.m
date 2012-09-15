//
//  ScoreViewController.m
//  Asteroids
//
//  Created by Kris Fields on 8/23/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import "ScoreViewController.h"
#import "GameView.h"
#import <QuartzCore/QuartzCore.h>

@interface ScoreViewController ()
@property (strong, nonatomic) GameView *gv;
@property int score;
@property int highScore;
@end

@implementation ScoreViewController
@synthesize scoreOutlet;
@synthesize AsteroidsDestroyedOutlet;
@synthesize levelOutlet;
@synthesize highScoreOutlet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)gameOver
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: [NSString stringWithFormat:@"You scored %d points and blew up %d asteroids!  But I bet you can do better.", self.score, self.score / 100]
                          message: @"Go again?"
                          delegate: self
                          cancelButtonTitle:@"YES!"
                          otherButtonTitles:nil];
    
    
    [alert show];

    
    
}
-(void)gameWin
{
    [self.gv.collisionTimer invalidate];
    self.highScore = self.score;
    self.highScoreOutlet.text = [NSString stringWithFormat:@"High Score: %d",self.highScore];
    UIImage *layerImage = [UIImage imageNamed:@"donut.gif"];
    CGImageRef image = [layerImage CGImage];
    [self.gv.ship.layer setContents:(__bridge id)image];
    self.levelOutlet.text = @"Holy Fuck. You won!!";
    [self changeOpacityLevel];
    [self bounceLevel];
    self.levelOutlet.alpha = 1.0;
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: [NSString stringWithFormat:@"You killed all %d asteroids", self.score /100]
                          message: @"Just close the app and go get a donut.  You deserve it."
                          delegate: self
                          cancelButtonTitle:@"Fuck that.  I'm playing again!"
                          otherButtonTitles:nil];
    alert.transform = CGAffineTransformTranslate( alert.transform, 0.0, -100.0 );
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.score = 0;
    self.gv.addAnotherAsteroid = NO;
    levelOutlet.text = @"Level 1";
    levelOutlet.hidden = NO;
    [self changeOpacityLevel];
    [self bounceLevel];
    scoreOutlet.text = [NSString stringWithFormat:@"Score: %d",self.score];
    AsteroidsDestroyedOutlet.text = [NSString stringWithFormat:@"Asteroids Destroyed: %d", self.score/100];
    [self.gv setupGame];
}
-(void)asteroidDestroyed
{

        self.score += 100;
    if (self.score > self.highScore) {
        self.highScore = self.score;
        self.highScoreOutlet.text = [NSString stringWithFormat:@"High Score: %d",self.highScore];
    }
        if (self.score % 1000 == 0){
            self.gv.addAnotherAsteroid = YES;
            levelOutlet.text = [NSString stringWithFormat:@"Level %d of 10", self.score / 1000 +1];
            [self changeOpacityLevel];
            [self bounceLevel];
        }
    scoreOutlet.text = [NSString stringWithFormat:@"Score: %d",self.score];
    AsteroidsDestroyedOutlet.text = [NSString stringWithFormat:@"Asteroids Destroyed: %d", self.score/100];
    if (self.score >=10000){
        [self gameWin];
    }
        
   
}
-(void)changeOpacityLevel{
    [CATransaction begin];
    CAKeyframeAnimation *changeOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    [changeOpacity setDuration:4];
    [changeOpacity setValues:@[@0.0, @1.0, @0.0]];
    [[levelOutlet layer] addAnimation:changeOpacity forKey:@"changeOpacity"];
    [CATransaction commit];
    levelOutlet.alpha = 0.0;
    
    
    
}
-(void)bounceLevel
{
    CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    // Create the values it will pass through
    CATransform3D forward = CATransform3DMakeScale(1.3, 1.3, 1);
    CATransform3D back = CATransform3DMakeScale(0.2, 0.2, 1);
//    CATransform3D forward2 = CATransform3DMakeScale(1.2, 1.2, 1);
//    CATransform3D back2 = CATransform3DMakeScale(0.9, 0.9, 1);
    [bounce setValues:@[                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    [NSValue valueWithCATransform3D:back],                                                                                                                                                                                                                                                                       [NSValue valueWithCATransform3D:forward],                                                                                                                                                                                                                                                                       [NSValue valueWithCATransform3D:back]]
     ];
    // Set the duration
    [bounce setDuration:4];
    // Animate the layer
    [[levelOutlet layer] addAnimation:bounce forKey:@"bounceAnimation"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.score = 0;
    self.highScore = 0;
    levelOutlet.alpha = 0.0;
    self.gv = [[GameView alloc]initWithFrame:self.view.bounds];
    NSLog(@"%f, %f", self.view.bounds.size.width, self.view.bounds.size.height);
    UIImage *layerImage = [UIImage imageNamed:@"mwa320x480stars4.gif"];
    CGImageRef image = [layerImage CGImage];
    [self.gv.layer setContents:(__bridge id)image];
    self.gv.delegate = self;
    [self.view insertSubview:self.gv atIndex:0];
    [self changeOpacityLevel];
    [self bounceLevel];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setScoreOutlet:nil];
    [self setAsteroidsDestroyedOutlet:nil];
    [self setLevelOutlet:nil];
    [self setHighScoreOutlet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
