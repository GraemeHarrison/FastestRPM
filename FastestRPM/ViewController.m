//
//  ViewController.m
//  FastestRPM
//
//  Created by Graeme Harrison on 2016-01-21.
//  Copyright © 2016 Graeme Harrison. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *needle;
@property (strong, nonatomic) IBOutlet UIImageView *speedometer;
@property (assign, nonatomic) CGFloat startAngle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.speedometer.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    self.speedometer.center = self.view.center;
    //set point of rotation
//    self.needle.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    self.needle.center = self.view.center;
    //rotate rect
    self.startAngle = -3.8; // -220 * (M_PI/180);
    self.needle.transform = CGAffineTransformMakeRotation(self.startAngle); //rotation in radians
}

- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {
    
    CGFloat velocityX = [sender velocityInView:self.view].x;
    CGFloat velocityY = [sender velocityInView:self.view].y;
    CGFloat magnitude = sqrtf((velocityX * velocityX) + (velocityY * velocityY));
    CGFloat speed = 0.4 * (magnitude / 200.0);

    CGFloat angle = self.startAngle / speed;

    CGFloat minAngle = self.startAngle;
    CGFloat maxAngle = (5.4);
    CGFloat newAngle;
    
    if (magnitude <= 0 ) {
        newAngle = minAngle;
    } else if (magnitude > 10000) {
        newAngle = maxAngle;
    } else {
//        newAngle = M_PI * (angle - minAngle) / (maxAngle - minAngle);
        newAngle = angle;

    }

    CGAffineTransform rotation = CGAffineTransformMakeRotation(newAngle);
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.needle.transform = rotation;
                     }
                     completion:^(BOOL finished) {
//                         NSLog(@"%@", NSStringFromCGAffineTransform(self.needle.transform));
                     }];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGAffineTransform backToStart = CGAffineTransformMakeRotation(self.startAngle);
        [UIView animateWithDuration:0.5
                         animations: ^{self.needle.transform = backToStart;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
