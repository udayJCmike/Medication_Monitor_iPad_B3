//
//  LoginScreen.h
//  MediMoni
//
//  Created by hsa1 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "GTabBar.h"
#import"MainViewController.h"

@interface LoginScreen : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>
{
    IBOutlet UITextField *name, *pass;
    IBOutlet UIButton *rem;
    MBProgressHUD *HUD;
    BOOL isConnect;
    UITabBarController *tabbarcontroller;
    GTabBar *tabview;
    
}
-(IBAction)rem:(id)sender;
- (IBAction) SignIn;
-(IBAction)SingnUp;

@end
