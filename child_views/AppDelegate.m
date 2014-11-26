//
//  AppDelegate.m
//  child_views
//
//  Created by ; on 27.10.14.
//  Copyright (c) 2014 child. All rights reserved.
//

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize MAIN;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MAIN = (UIViewController*)  self.window.rootViewController;
    self.animSpeed = 1.6;
    
    [MAIN.view setBackgroundColor:[UIColor blackColor]];
    
    UIView *MainView;
    
    CGRect frame = CGRectMake(0, 0, 320, 1000);
    MainView = [[UIView alloc] initWithFrame:frame];
    
    [MainView setBackgroundColor:[UIColor redColor]];
    [MAIN.view addSubview:MainView];
    self.MainSubView = MainView;
    self.anim_block = false;
    self.lockX = false;
    self.animStop = false;
    self.dayLastPosX = 0;
    self.dayLastPosY = 150;
    
    [MAIN.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveMe:)]];
    
    self.TOWNS = [NSMutableDictionary dictionaryWithCapacity:5];
    self.saveCoords = [NSMutableDictionary dictionaryWithCapacity:6];
    self.currentViewIndex = 0;
    self.currentViewPos = 0;
    self.currentPosOffset = 160;
    self.currentTownIndex = 0;
  //  self.currentSubView = nil;
   // self.prevSubView = nil;
    self.leftSubView = nil;
   //[self nextView];
  //  [self nextView];
    
    NSMutableDictionary *town0 = [NSMutableDictionary new];
    [town0 setObject:@"Симферооль"  forKey:@"town_name"];
    [town0 setObject:Rgb2UIColor(26, 110, 89)        forKey:@"town_bg_color"];
    
    NSMutableDictionary *town1 = [NSMutableDictionary new];
    [town1 setObject:@"Ялта"        forKey:@"town_name"];
    [town1 setObject:color()        forKey:@"town_bg_color"];
    
    NSMutableDictionary *town2 = [NSMutableDictionary new];
    [town2 setObject:@"Керч"        forKey:@"town_name"];
    [town2 setObject:color()        forKey:@"town_bg_color"];
    
    NSMutableDictionary *town3 = [NSMutableDictionary new];
    [town3 setObject:@"Севастополь" forKey:@"town_name"];
    [town3 setObject:color()        forKey:@"town_bg_color"];
    
    NSMutableDictionary *town4 = [NSMutableDictionary new];
    [town4 setObject:@"Алушта"      forKey:@"town_name"];
    [town4 setObject:color()        forKey:@"town_bg_color"];
    
    [self.TOWNS setObject:town0         forKey:@"0"];
    [self.TOWNS setObject:town1         forKey:@"1"];
    [self.TOWNS setObject:town2         forKey:@"2"];
    [self.TOWNS setObject:town3         forKey:@"3"];
    [self.TOWNS setObject:town4         forKey:@"4"];
    //[self.TOWNS setObject:@"end"        forKey:@"end"];
    
    ///[self createTowns];
    [self initVIEWS];
    
    
   // = [self.centerSubView viewWithTag:77];
   

    
    for (UIView *subview in self.centerSubView.subviews) {
        NSLog(@"%@", subview);
        
        if(subview.tag == 77) {
             for (UILabel *label in subview.subviews) {
                 NSLog(@"FUCK%@", label.text);
             }
        }
      //   UILabel * town = [subview viewWithTag:77];
      //   NSLog(@"%@", town.text);
        
        if ([subview isKindOfClass:[UILabel class]]) {
            if(subview.tag == 43) {
            UILabel *my = subview;
            my.text = @"HERE WE ARE";
            //for (UILabel *label in subview.subviews) {
              //  NSLog(@"TTEEE%@", label);
                //if(label.tag == 55) {
               //label.text = @"HERE WE ARE";
                NSLog(@"YES%@", my.text);
            }
                //}
           // }
            
        }
        
        // List the subviews of subview
        // [self listSubviewsOfView:subview];
    }

    
    // Override point for customization after application launch.
    return YES;
}

- (void)moveMe:(UIPanGestureRecognizer *)gesture {
    // [self moveToNextController:gesture];
    [self moveToNextView:gesture];
    
}

- (BOOL)initVIEWS {
    
    UIView *centerView;
    CGRect frame_center = CGRectMake(0, 0, 320, 1000);
    centerView = [[UIView alloc] initWithFrame:frame_center];
    
    UIView *leftView;
    CGRect frame_left = CGRectMake(-320, 0, 320, 1000);
    leftView = [[UIView alloc] initWithFrame:frame_left];
    
    UIView *rightView;
    CGRect frame_right = CGRectMake(320, 0, 320, 1000);
    rightView = [[UIView alloc] initWithFrame:frame_right];
    
    unsigned long prevIndex = [self.TOWNS count] - 1;
    unsigned long nextIndex = self.currentTownIndex + 1;
    
    self.leftSubView = [self generateTown:prevIndex :leftView];
    self.centerSubView = [self generateTown:self.currentTownIndex :centerView];
    self.rightSubView = [self generateTown:nextIndex :rightView];
    
    
    [self.MainSubView addSubview:self.centerSubView];
    [self.MainSubView addSubview:self.leftSubView];
    [self.MainSubView addSubview:self.rightSubView];
    
    NSArray *subviews = [self.centerSubView subviews];
    
  //  [self.centerSubView viewWithTag:1]


    
    return true;
}


UIColor* color()
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


- (UIView*)generateTown:(unsigned short)index :(UIView*)VIEW {

    NSMutableDictionary *townConf = [NSMutableDictionary new];
   /* UILabel *label_center = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 20)];
     UILabel *label_center2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, 300, 20)];
     UILabel *label_center3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 450, 300, 20)];
     UILabel *label_center4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 650, 300, 20)];
     UILabel *label_center5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 850, 300, 20)];*/
    
    VIEW.tag = index;
    
  //  if(index == [self.TOWNS count] - 1)
   //     townConf = [self.TOWNS[self.TOWNS allKeys] objectAtIndex:4];
   // else
        townConf = [self.TOWNS objectForKey:[NSString stringWithFormat:@"%hu", index] ];
    
    NSLog(@"Town:%@withIndex:%hu", [townConf objectForKey:@"town_name"], index);
    
    [VIEW setBackgroundColor:[townConf objectForKey:@"town_bg_color"]];
    
    //[subView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveMe:)]];
    
    [self generateHeader:VIEW currIndex:index];
    [self generateDay:VIEW];
    
   /* [label_center setTextColor:[UIColor blackColor]];
    [label_center setBackgroundColor:[UIColor clearColor]];
    [label_center setFont:[UIFont fontWithName: @"Trebuchet MS" size: 20.0f]];
    label_center.text = [townConf objectForKey:@"town_name"];
    
    
    [label_center2 setTextColor:[UIColor blackColor]];
    [label_center2 setBackgroundColor:[UIColor clearColor]];
    [label_center2 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 20.0f]];
    label_center2.text = @"Вторник";
    
    [label_center3 setTextColor:[UIColor blackColor]];
    [label_center3 setBackgroundColor:[UIColor clearColor]];
    [label_center3 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 20.0f]];
    label_center3.text = @"Среда";
    
    [label_center4 setTextColor:[UIColor blackColor]];
    [label_center4 setBackgroundColor:[UIColor clearColor]];
    [label_center4 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 20.0f]];
    label_center4.text = @"Четверг";
    
    [label_center5 setTextColor:[UIColor blackColor]];
    [label_center5 setBackgroundColor:[UIColor clearColor]];
    [label_center5 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 20.0f]];
    label_center5.text = @"Пятница";

    
    [VIEW addSubview:label_center];
    [VIEW addSubview:label_center2];
    [VIEW addSubview:label_center3];
    [VIEW addSubview:label_center4];
    [VIEW addSubview:label_center5];*/

    return VIEW;
}

- (BOOL)updateTowns {
    
       [self.leftSubView removeFromSuperview];
        [self.centerSubView removeFromSuperview];
        [self.rightSubView removeFromSuperview];
    
        
        unsigned long prevIndex = (self.currentTownIndex) == 0 ? [self.TOWNS count] - 1 : self.currentTownIndex - 1;
        unsigned long nextIndex = (self.currentTownIndex) == [self.TOWNS count] - 1 ? 0 : self.currentTownIndex + 1;
        
        UIView *centerView;
        CGRect frame_center = CGRectMake([[self.saveCoords objectForKey:@"centerX"] floatValue], [[self.saveCoords objectForKey:@"centerY"] floatValue], 320, 1000);
        centerView = [[UIView alloc] initWithFrame:frame_center];
        
        UIView *leftView;
        CGRect frame_left = CGRectMake([[self.saveCoords objectForKey:@"leftX"] floatValue], [[self.saveCoords objectForKey:@"leftY"] floatValue], 320, 1000);
        leftView = [[UIView alloc] initWithFrame:frame_left];
        
        UIView *rightView;
        CGRect frame_right = CGRectMake([[self.saveCoords objectForKey:@"rightX"] floatValue], [[self.saveCoords objectForKey:@"rightY"] floatValue], 320, 1000);
        rightView = [[UIView alloc] initWithFrame:frame_right];
        
        
        self.leftSubView = [self generateTown:prevIndex :leftView];
        self.centerSubView = [self generateTown:self.currentTownIndex :centerView];
        self.rightSubView = [self generateTown:nextIndex :rightView];
    
    
        [self.MainSubView addSubview:self.centerSubView];
        [self.MainSubView addSubview:self.leftSubView];
        [self.MainSubView addSubview:self.rightSubView];
    return  true;
}

- (BOOL)generateDay:(UIView *)VIEW {
    self.dayLastPosX = VIEW.frame.origin.x;
    
    UILabel *curr_date = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 100, 20)];
    [curr_date setTextColor:[UIColor blackColor]];
    [curr_date setBackgroundColor:[UIColor clearColor]];
    [curr_date setFont:[UIFont fontWithName: @"Trebuchet MS" size: 20.0f]];
    curr_date.text = @"18 Ноября";
    
    // ВРЕМЯ!

    self.dayLastPosX += 50;
    UILabel *time_1 = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, 100, 20)];
    [time_1 setTextColor:[UIColor blackColor]];
    [time_1 setBackgroundColor:[UIColor clearColor]];
    [time_1 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 20.0f]];
    time_1.text = @"04:00";
    time_1.tag = 55;
   // self.dayLastPosX = 0;

    
    
    
    [VIEW addSubview:curr_date];
    [VIEW addSubview:time_1];
    return true;
}

- (BOOL)generateHeader:(UIView *)VIEW currIndex:(int)index  {
    UIView *header;
    CGRect frame_center = CGRectMake(0, 0, 320, 100);
    header = [[UIView alloc] initWithFrame:frame_center];
    [header setBackgroundColor:Rgb2UIColor(0, 255, 0)];
    header.tag = 77;
    
    NSMutableDictionary *townConf = [NSMutableDictionary new];
    townConf = [self.TOWNS objectForKey:[NSString stringWithFormat:@"%d", index] ];
    
    float width = 0;
    if([[townConf objectForKey:@"town_name"] length] > 6)
        width = 120;
    else
        width = 150;
        
        
    UILabel *town_name = [[UILabel alloc] initWithFrame:CGRectMake(width, 20, 150, 20)];
    [town_name setTextColor:[UIColor blackColor]];
    [town_name setBackgroundColor:[UIColor clearColor]];
    [town_name setFont:[UIFont fontWithName: @"Trebuchet MS" size: 20.0f]];
    town_name.text = [townConf objectForKey:@"town_name"];
    town_name.tag = 43;

    
    //header.tag = 1;
    [header addSubview:town_name];
    
    
    [VIEW addSubview:header];
    return true;
}

- (void)moveToNextView:(UIPanGestureRecognizer *)gesture {
    
    
    CGPoint translation = [gesture translationInView:gesture.view];
    
     [gesture setTranslation:CGPointZero inView:self.centerSubView];
    
     CGPoint velocity = [gesture velocityInView:gesture.view];
    
    
    
    //
    //CGPoint translate = [gesture translationInView:gesture.view];
   // translate.y = 0.0; // I'm just doing horizontal scrolling*/
   // UIView *view = [self.MainSubView hitTest:[gesture locationInView:gesture.view] withEvent:nil];
    // if we're done with gesture, animate frames to new locations
    //NSLog(@"MoveMe%f", translate.x);

    BOOL rightToLeftSwipe = velocity.x < 0;
    
    if(!self.anim_block) {
        
        if(velocity.x == 0)
            self.lockX = true;
        else if(velocity.x > 0) {
            if(velocity.x > velocity.y)
                self.lockX = false;
            else
                self.lockX = true;
        } else if(velocity.x < 0) {
            if(velocity.x < velocity.y)
                self.lockX = false;
            else
                self.lockX = true;
        }
     /*   if(velocity.x != 0)
            self.lockX = false;
        if(velocity.y != 0 && velocity.x == 0)
            self.lockX = true;*/
        self.anim_block = true;
        
        
        [self.saveCoords setObject:[NSNumber numberWithFloat:self.leftSubView.frame.origin.x] forKey:@"leftX"];
        [self.saveCoords setObject:[NSNumber numberWithFloat:self.leftSubView.frame.origin.y] forKey:@"leftY"];
        
        [self.saveCoords setObject:[NSNumber numberWithFloat:self.centerSubView.frame.origin.x] forKey:@"centerX"];
        [self.saveCoords setObject:[NSNumber numberWithFloat:self.centerSubView.frame.origin.y] forKey:@"centerY"];
        
        [self.saveCoords setObject:[NSNumber numberWithFloat:self.rightSubView.frame.origin.x] forKey:@"rightX"];
        [self.saveCoords setObject:[NSNumber numberWithFloat:self.rightSubView.frame.origin.y] forKey:@"rightY"];
        
    }
    
        if(UIGestureRecognizerStateBegan == gesture.state ||
           UIGestureRecognizerStateChanged == gesture.state)
        {
            
            for (UIView *subview in self.centerSubView.subviews) {
                //NSLog(@"%@", subview);
                
                if(subview.tag == 77) {
                    
                        [UIView animateWithDuration:0 animations:^{
                            CGRect centerView  = subview.frame;
                            centerView.origin.y -= translation.y;
                            subview.frame = centerView;
                        }];
                }
            }

            
            if(!self.lockX) {
       
                //CGPoint velocity = [gesture velocityInView:gesture.view];
        

                [UIView animateWithDuration:.3 animations:^{
                    CGRect rightView = self.rightSubView.frame;
                    CGRect centerView = self.centerSubView.frame;
                    CGRect leftView = self.leftSubView.frame;
                    
                    if(centerView.origin.x >= 320 || leftView.origin.x >= 0) {
                        centerView.origin.x = 320;
                        leftView.origin.x = 0;
                    } else if(self.centerSubView.frame.origin.x <= -320 || self.rightSubView.frame.origin.x <= 0) {
                        centerView.origin.x = -320;
                        rightView.origin.x = 0;
                    } else {
                        
                        rightView.origin.x += translation.x ;
                        centerView.origin.x += translation.x ;
                        leftView.origin.x += translation.x ;
                    }
                    
                    centerView.origin.y = [[self.saveCoords objectForKey:@"centerY"] floatValue];
                    leftView.origin.y = [[self.saveCoords objectForKey:@"leftY"] floatValue];
                    rightView.origin.y = [[self.saveCoords objectForKey:@"rightY"] floatValue];
            
                    self.centerSubView.frame = centerView;
                    self.rightSubView.frame = rightView;
                    self.leftSubView.frame = leftView;


                }];
            } else {

              [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{

                CGRect rightView = self.rightSubView.frame;
                CGRect centerView = self.centerSubView.frame;
                CGRect leftView = self.leftSubView.frame;
                
                centerView.origin.x = [[self.saveCoords objectForKey:@"centerX"] floatValue];
                leftView.origin.x = [[self.saveCoords objectForKey:@"leftX"] floatValue];
                rightView.origin.x = [[self.saveCoords objectForKey:@"rightX"] floatValue];


                
                rightView.origin.y += translation.y ;
                centerView.origin.y += translation.y ;
                leftView.origin.y += translation.y ;
                  
                  if(centerView.origin.y < -400) {
                      rightView.origin.y = -400;
                      centerView.origin.y = -400;
                      leftView.origin.y = -400;
                  }
                  
                  if(centerView.origin.y > 0) {
                      rightView.origin.y = 0;
                      centerView.origin.y = 0;
                      leftView.origin.y = 0;
                  }
                  
                  
                
                self.centerSubView.frame = centerView;
                self.rightSubView.frame = rightView;
                self.leftSubView.frame = leftView;
                  
                  
                  NSLog(@"AfterAnim: %f", self.centerSubView.frame.origin.y);
              }completion:^(BOOL finished) {
                 
                  [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                      
                      CGRect rightView = self.rightSubView.frame;
                      CGRect centerView = self.centerSubView.frame;
                      CGRect leftView = self.leftSubView.frame;
                      
                      centerView.origin.x = [[self.saveCoords objectForKey:@"centerX"] floatValue];
                      leftView.origin.x = [[self.saveCoords objectForKey:@"leftX"] floatValue];
                      rightView.origin.x = [[self.saveCoords objectForKey:@"rightX"] floatValue];
                      
                      
                      
                      rightView.origin.y += translation.y + velocity.y / 50.5;
                      centerView.origin.y += translation.y + velocity.y / 50.5;
                      leftView.origin.y += translation.y + velocity.y / 50.5;
                      
                      if(centerView.origin.y < -400) {
                          rightView.origin.y = -400;
                          centerView.origin.y = -400;
                          leftView.origin.y = -400;
                      }
                      
                      if(centerView.origin.y > 0) {
                          rightView.origin.y = 0;
                          centerView.origin.y = 0;
                          leftView.origin.y = 0;
                      }
                      
                      
                      
                      self.centerSubView.frame = centerView;
                      self.rightSubView.frame = rightView;
                      self.leftSubView.frame = leftView;
                      
                      
                      NSLog(@"AfterAnim: %f", self.centerSubView.frame.origin.y);
                  }completion:^(BOOL finished) {
                      
                      NSLog(@"VELOCITY %f", velocity.y);
                      
                  }];

              
              }];
            }
          //  NSLog(@"%f", self.centerSubView.frame.origin.x);
        } else if(gesture.state == UIGestureRecognizerStateEnded) {
            // пальцы убраны
            
            
            if(!self.lockX) {
            
            if(self.centerSubView.frame.origin.x <= -160) {
           
                [UIView animateWithDuration:.3 animations:^{
                    
                    CGRect rightView = self.rightSubView.frame;
                    CGRect centerView = self.centerSubView.frame;
                    CGRect leftView = self.leftSubView.frame;
                    
                    rightView.origin.x = 0;
                    centerView.origin.x = -320;
                    leftView.origin.x = -620;
                    
                    self.centerSubView.frame = centerView;
                    self.rightSubView.frame = rightView;
                    self.leftSubView.frame = leftView;
                    
                } completion:^(BOOL finished){
                    // NSLog(@"%ld", (long)self.currentTownIndex);
                    self.currentTownIndex = (self.currentTownIndex == [self.TOWNS count] - 1) ? 0 : self.currentTownIndex + 1;
                    [self updateTowns];
                }];

            } else if((self.centerSubView.frame.origin.x >= -160 && self.centerSubView.frame.origin.x <= 0) || (self.centerSubView.frame.origin.x <= 160 && self.centerSubView.frame.origin.x >= 0)) {
                
                [UIView animateWithDuration:.3 animations:^{
                    
                    CGRect rightView = self.rightSubView.frame;
                    CGRect centerView = self.centerSubView.frame;
                    CGRect leftView = self.leftSubView.frame;
                    
                    rightView.origin.x = 320;
                    centerView.origin.x = 0;
                    leftView.origin.x = -320;
                    
                    self.centerSubView.frame = centerView;
                    self.rightSubView.frame = rightView;
                    self.leftSubView.frame = leftView;
                    
                } completion:^(BOOL finished){
                }];
                

            } else  if(self.centerSubView.frame.origin.x >= 160 && self.centerSubView.frame.origin.x <= 320) {
                [UIView animateWithDuration:.3 animations:^{
                    
                    CGRect rightView = self.rightSubView.frame;
                    CGRect centerView = self.centerSubView.frame;
                    CGRect leftView = self.leftSubView.frame;
                    
                    rightView.origin.x = 620;
                    centerView.origin.x = 320;
                    leftView.origin.x = 0;
                    
                    self.centerSubView.frame = centerView;
                    self.rightSubView.frame = rightView;
                    self.leftSubView.frame = leftView;
                    
                } completion:^(BOOL finished){
                    //NSLog(@"%ld", (long)self.currentTownIndex);
                    self.currentTownIndex = (self.currentTownIndex == 0) ? [self.TOWNS count] - 1 : self.currentTownIndex - 1;
                    [self updateTowns];
                }];
                
            }
            
            } else {
                
                for (UIView *subview in self.centerSubView.subviews) {
                    //NSLog(@"%@", subview);
                    
                    if(subview.tag == 77) {

                            [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                                
                                CGRect centerView  = subview.frame;
                                
                                centerView.origin.y -= translation.y + velocity.y / 50.5;
                                
                                /* if(centerView.origin.y < -400) {
                                 //  rightView.origin.y = -400;
                                 centerView.origin.y = -400;
                                 //leftView.origin.y = -400;
                                 }
                                 
                                 if(centerView.origin.y > 0) {
                                 // rightView.origin.y = 0;
                                 centerView.origin.y = 0;
                                 // leftView.origin.y = 0;
                                 }*/
                                
                                
                                
                                subview.frame = centerView;
                                //self.rightSubView.frame = rightView;
                                //self.leftSubView.frame = leftView;
                                
                                
                                // NSLog(@"AfterAnim: %f", self.centerSubView.frame.origin.y);
                            }completion:^(BOOL finished) {
                                
                                //  NSLog(@"VELOCITY %f", velocity.y);
                                
                            }];
                        
                        
                    }
                }

                
                
               // float saldo = [[self.saveCoords objectForKeyedSubscript:@"centerY"] floatValue] - self.centerSubView.frame.origin.y;
             //   NSLog(@"%f - %f = %f", self.centerSubView.frame.origin.y, [[self.saveCoords objectForKeyedSubscript:@"centerY"] floatValue], saldo);
                
               // self.animStop = true;
                /*float saldo = velocity.y + self.centerSubView.frame.origin.y / 2;
                 // NSLog(@"%f - %f = %f", self.centerSubView.frame.origin.y, [[self.saveCoords objectForKeyedSubscript:@"centerY"] floatValue], saldo);*/
            
            
                NSLog(@"after Stop: %f", self.centerSubView.frame.origin.y);
              //  [self.centerSubView.layer setPosition:CGPointMake(self.centerSubView.frame.origin.x, self.centerSubView.frame.origin.y)];
                
              //  NSLog(@"POSS_Y: %f", self.centerSubView.layer.frame.origin.y);
                
                /*float increase = self.centerSubView.frame.origin.y - [[self.saveCoords objectForKey:@"centerY"] floatValue];
                [self.saveCoords setObject:[NSNumber numberWithFloat:0] forKey:@"MOVE"];
                if(velocity.y < 0)
                    [self.saveCoords setObject:[NSNumber numberWithFloat:self.centerSubView.frame.origin.y + increase] forKey:@"MOVE"];
                else
                    [self.saveCoords setObject:[NSNumber numberWithFloat:self.centerSubView.frame.origin.y + increase] forKey:@"MOVE"];
                
                NSLog(@"MOVECOORD: %f", [[self.saveCoords objectForKey:@"MOVE"] floatValue]);
                
                CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
                [animation setFromValue:[NSNumber numberWithFloat: self.centerSubView.layer.frame.origin.y]];
                [animation setToValue:[NSNumber  numberWithFloat:[[self.saveCoords objectForKey:@"MOVE"] floatValue]]];
                [animation setDuration:1.0];
                [animation setDelegate:self];*/
                
               // [self.centerSubView.layer addAnimation:animation forKey:@"transform.translation.y"];
                //[self.centerSubView.layer setPosition:CGPointMake(self.centerSubView.frame.origin.x, moveCoord)];
               // [self.saveCoords setObject:[NSNumber numberWithFloat:moveCoord ]  forKey:@"centerY"];
                
                // CGRect centerView = self.centerSubView.frame;
                //centerView.origin.y = saldo;
                // self.centerSubView.frame = centerView;

               // float PLUS = self.centerSubView.frame.origin.y + translation.y;
                
              /*    [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                      
                      CGRect rightView = self.rightSubView.frame;
                      CGRect centerView = self.centerSubView.frame;
                      CGRect leftView = self.leftSubView.frame;
                      
                      if(self.rightSubView.frame.origin.y - increase < -430) {
                          rightView.origin.y = -430;
                          centerView.origin.y = -430;
                          leftView.origin.y = -430;
                      } else if(self.centerSubView.frame.origin.y - increase > 0) {
                          rightView.origin.y = 0;
                          centerView.origin.y = 0;
                          leftView.origin.y = 0;
                      } else {
                          rightView.origin.y -= increase;
                          centerView.origin.y -= increase;
                          leftView.origin.y -= increase;
                      }
                      
                      

                      
                      self.centerSubView.frame = centerView;
                      self.rightSubView.frame = rightView;
                      self.leftSubView.frame = leftView;
                      
                  } completion:^(BOOL finished) {
                      CGRect rightView = self.rightSubView.frame;
                      CGRect centerView = self.centerSubView.frame;
                      CGRect leftView = self.leftSubView.frame;
                      
                      
                      
                      
                      self.centerSubView.frame = centerView;
                      self.rightSubView.frame = rightView;
                      self.leftSubView.frame = leftView;

                  }];*/
            }
            self.anim_block = false;
           // NSLog(@"FINISHED");
        }
    
    
}


- (void)animationDidStart:(CAAnimation *)theAnimation {
    NSLog(@"START");
    //self.animStop = true;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
   // theAnimation.
   // if(self.animStop) {
    CGRect centerView = self.centerSubView.frame;
    
    centerView.origin.y = [[self.saveCoords objectForKey:@"MOVE"] floatValue];
    
     self.centerSubView.frame = centerView;

        NSLog(@"FINISH %f - %f", self.centerSubView.layer.frame.origin.y,[[self.saveCoords objectForKey:@"MOVE"] floatValue]);
      //  self.animStop = false;
    //r}
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
