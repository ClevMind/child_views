//
//  ViewController.m
//  child_views
//
//  Created by ClevMind on 27.10.14.
//  Copyright (c) 2014 child. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  UIViewController *nextController = [self nextViewController];
   
    
    // Contain the view controller
   // [self addChildViewController:nextController];
   // [self.view addSubview:nextController.view];
    //[nextController didMoveToParentViewController:self];
    //self.currentChildController = nextController;

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*-(UIViewController*)nextViewController {
        UIViewController *controller = [UIViewController new];
    if(self.currentIndex > 0) {
        //  controller.view.frame = CGRectMake(0, 0, 320, 1000);
        [controller.view setBackgroundColor:[UIColor clearColor]];
    }
    else {
        //  controller.view.frame = CGRectMake(0, 0, 320, 1000);
        [controller.view setBackgroundColor:[UIColor redColor]];
    }
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveMe:)]];
    self.currentIndex++;
    return controller;
}*/


/*-(void)moveToNextController:(UIPanGestureRecognizer *)gesture {
    UIViewController *nextViewController = [self nextViewController];
    
    if(self.currentIndex > 0)
        nextViewController.view.frame = CGRectMake(-320, 0, 320, 1000);
    else
        nextViewController.view.frame = CGRectMake(0, 0, 320, 1000);
    // Containment
    [self addChildViewController:nextViewController];
    
    [self.currentChildController willMoveToParentViewController:nil];
    
 
    
    
    CGPoint translate = [gesture translationInView:gesture.view];
    translate.y = 0.0; // I'm just doing horizontal scrolling
    UIView *view = [self.view hitTest:[gesture locationInView:gesture.view] withEvent:nil];
    // if we're done with gesture, animate frames to new locations
    
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state)
    {
        // figure out if we've moved (or flicked) more than 50% the way across
        
        CGPoint velocity = [gesture velocityInView:gesture.view];
        
        NSLog(@"POS%f----%f", translate.x, self.centerX);
        if (translate.x >= 0 )
        {
            [UIView animateWithDuration:.3 animations:^{

                self.currentChildController.view.alpha = 0.5f;
                self.currentChildController.view.frame = CGRectMake(self.centerX + translate.x, 0, 320, 1000);
                nextViewController.view.frame = CGRectMake(self.centerX - translate.x, 0, 320, 1000);
                
                CGRect middleViewFrame = self.view.frame;
                 middleViewFrame.origin.x = 320;
                 self.view.frame = middleViewFrame;
                //  CGAffineTransform transform = CGAffineTransformMakeTranslation(-nextViewController.view.transform.tx * _velocity.value, -nextViewController.view.transform.ty * _velocity.value);
                //transform = CGAffineTransformRotate(transform, acosf(nextViewController.view.transform.a));
                //self.currentChilController.view.transform = CGAffineTransformScale(transform, _scale.value, _scale.value);
                
                //nextViewController.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if(translate.x > self.centerX) {
                    [nextViewController didMoveToParentViewController:self];
                    [self.currentChildController removeFromParentViewController];
                    self.currentChildController = nextViewController;
                } else {
                    NSLog(@"TEE");
                }
            }];

            
        } else {
            [UIView animateWithDuration:.3 animations:^{
                view.center = CGPointMake(0 + translate.x, view.center.y);
                //NSLog(@"YES$##!^");
            }];
        }
    } else {
        [UIView animateWithDuration:.3 animations:^{
            
            view.center = CGPointMake(0, view.center.y);
        }];
        
    }
    
    

    
    
   // nextViewController.view.transform = [self startingTransformForViewControllerTransition:self.transitionStyle.selectedSegmentIndex];
    
   }
*/
@end
