//
//  Communicate.m
//  MediMoni
//
//  Created by hsa1 on 26/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Communicate.h"
#import "BlockAlertView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "RootViewController.h"
#import "SignUp.h"
#import "AboutmeViewController.h"
#import "NewViewController.h"
#import "Cremainder.h"
#import "que.h"
#import "Appoinment.h"
#import "Communicate.h"
#import "Assessment.h"
#import "MainViewController.h"
#import "Welcome.h"

@interface Communicate ()

@end

@implementation Communicate

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)FaceClicked
{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"facetime:///"]];


}
-(IBAction)SkypeClicked
{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"skype:///"]];
}
-(void)back
{
    
   
}
-(IBAction)mailClicked
{
       
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        
     
        [mailer setSubject:@"Mail "];
        
        UIImage *barButton = [UIImage imageNamed:@"sSend.png"];
        [[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
        {
           [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top_Panel.png"] forBarMetrics:UIBarMetricsDefault];
            mailer.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
            
            
        }
        
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@example.com", nil];
        [mailer setToRecipients:toRecipients];
        
        UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        NSData *imageData = UIImagePNGRepresentation(myImage);
                
        NSString *emailBody = [NSString stringWithFormat:@"hi"];
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
       
        
        [self presentModalViewController:mailer animated:YES ];
        
        [mailer release];
    }
    else
    {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Failure!" message:@"Your device doesn't support the composer sheet."];
        
    
    [alert setDestructiveButtonWithTitle:@"x" block:nil];
    [alert show];
 
    
    
    }
    
}

-(IBAction)comtomedi
{
    
    RootViewController*new = [[RootViewController alloc] initWithNibName:@"roor" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [RootViewController release];
    
}
-(IBAction)comtorem
{
    
    Cremainder*new = [[Cremainder alloc] initWithNibName:@"Cremainder" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Cremainder release];
}
-(IBAction)comtoass
{
    
    Assessment*new = [[Assessment alloc] initWithNibName:@"Assessment" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Assessment release];
}
-(IBAction)comtoapp
{
    
    Appoinment*new = [[Appoinment alloc] initWithNibName:@"Appoinment" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Appoinment release];
}
-(IBAction)comtohome
{
    
    Welcome*new = [[Welcome alloc] initWithNibName:@"Welcome" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Welcome release];
}
-(IBAction)comtoset
{
    
    NewViewController*new = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [NewViewController release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			//NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [comload
     setImage:[UIImage imageNamed:@"Communicate2.png"]forState:UIControlStateNormal];
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@" "]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top_Panel.png"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    
  
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Communicate", @"");
    [label sizeToFit];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
