//
//  Communicate.h
//  MediMoni
//
//  Created by hsa1 on 26/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface Communicate : UIViewController<MFMailComposeViewControllerDelegate>
{
    IBOutlet UIButton*face;
    IBOutlet UIButton*skype;
    IBOutlet UIButton*mail;
      IBOutlet UIButton * comload;
}
-(IBAction)FaceClicked;
-(IBAction)SkypeClicked;
-(IBAction)mailClicked;

-(IBAction)comtomedi;
-(IBAction)comtorem;
-(IBAction)comtoass;
-(IBAction)comtoapp;
-(IBAction)comtohome;
-(IBAction)comtoset;

@end
