//
//  AppDelegate.h
//  child_views
//
//  Created by ClevMind on 27.10.14.
//  Copyright (c) 2014 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UIViewController *MAIN;
@property (nonatomic, strong) UIView *MainSubView;
@property (nonatomic, strong) UIView *leftSubView;
@property (nonatomic, strong) UIView *centerSubView;
@property (nonatomic, strong) UIView *rightSubView;
@property (nonatomic) NSInteger currentViewIndex;
@property (nonatomic) NSInteger currentPosOffset;
@property (nonatomic) NSInteger currentViewPos;
@property (nonatomic) NSInteger currentTownIndex;
@property (nonatomic) float animSpeed;
@property BOOL anim_block;
@property NSMutableDictionary *TOWNS;
@property NSMutableDictionary *saveCoords;
@property BOOL lockX;
@property BOOL animStop;
@property float dayLastPosX;
@property float dayLastPosY;

@end

