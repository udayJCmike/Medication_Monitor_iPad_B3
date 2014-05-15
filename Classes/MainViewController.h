//
//  MainViewController.h
//  RSSReader
//
//  Created by Dean Collins on 5/04/09.
//  Copyright 2009 Big Click Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTabBar.h"

@interface MainViewController : UINavigationController {
	UINavigationController *navigationController;
    NSMutableDictionary *recordDict;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) UINavigationController *navigationController;
@property (retain, nonatomic) NSMutableDictionary *recordDict;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic,retain)UIViewController*viewcontroller;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray*notificationsArray;
@end
