//
//  ViewController.m
//  GestureDemoExample
//
//  Created by TheAppGuruz-New-6 on 27/03/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize blueBox;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapper=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressed:)];
    longPress.minimumPressDuration=3;
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinching:)];
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiping:)];
    UIRotationGestureRecognizer *rotate=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    
    
    [blueBox addGestureRecognizer:tapper];
    [blueBox addGestureRecognizer:longPress];
    [blueBox addGestureRecognizer:pinch];
    [blueBox addGestureRecognizer:swipe];
    [blueBox addGestureRecognizer:rotate];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    
    //[blueBox addGestureRecognizer:panGesture];
    panGesture = nil;
}

-(void) tapped:(UIGestureRecognizer *) sender
{
    CGFloat r=(CGFloat) random()/(CGFloat) RAND_MAX;
    CGFloat g=(CGFloat) random()/(CGFloat) RAND_MAX;
    CGFloat b=(CGFloat) random()/(CGFloat) RAND_MAX;
    blueBox.backgroundColor=[UIColor colorWithRed:r green:g blue:b alpha:1];
}

-(void)handlePanGesture:(id)sender
{
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        firstX = [[sender view] center].x;
        firstY = [[sender view] center].y;
    }
    translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY+translatedPoint.y);
    [[sender view] setCenter:translatedPoint];
}

-(void) rotation:(UIRotationGestureRecognizer *) sender
{
    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged) {
        [sender view].transform = CGAffineTransformRotate([[sender view] transform], [(UIRotationGestureRecognizer *)sender rotation]);
        [(UIRotationGestureRecognizer *)sender setRotation:0];}
}

-(void) pinching:(UIPinchGestureRecognizer *) sender
{
    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged)
    {
        [sender view].transform = CGAffineTransformScale([[sender view] transform], [sender scale], [sender scale]);
        [sender setScale:1];    }
}

-(void) swiping:(UISwipeGestureRecognizer *) sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stop:)];
    blueBox.backgroundColor=[UIColor whiteColor];
    [UIView commitAnimations];
}


-(void) longPressed:(UIGestureRecognizer *) sender
{
    CGFloat r=(CGFloat) random()/(CGFloat) RAND_MAX;
    CGFloat g=(CGFloat) random()/(CGFloat) RAND_MAX;
    CGFloat b=(CGFloat) random()/(CGFloat) RAND_MAX;
    blueBox.backgroundColor=[UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void) stop: sender
{
    blueBox.backgroundColor=[UIColor blueColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
