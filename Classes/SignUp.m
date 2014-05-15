//
//  SignUp.m
//  MediMoni
//
//  Created by hsa1 on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignUp.h"
#import "DemoHintView.h"
#import "BlockAlertView.h"
#import "JSON/JSON.h"
@interface SignUp ()

@end

@implementation SignUp
@synthesize pickerView;
@synthesize pickerCountry;
@synthesize countrybutt;
@synthesize agebutt;


- (IBAction)checkboxButton:(UIButton *)button{
    
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    
    for (UIButton *but in [self.view subviews]) {
        if ([but isKindOfClass:[UIButton class]] && ![but isEqual:button]) {
            [but setSelected:NO];
        }
    }
    if (!button.selected)
    {
        button.selected = !button.selected;
        [[NSUserDefaults standardUserDefaults]setInteger:button.tag forKey:@"syncType"];
    }
    
    if(button.tag==1)
    {
        sex=@"male";
    }
    else{
         sex=@"female";
    }
}
-(BOOL)validateEmail:(NSString*)candidate{
    NSString *emailFormat1 = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    
    NSPredicate *emailTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailFormat1];
    return [emailTest1 evaluateWithObject:candidate];
    
}
-(BOOL)validateUsername:(NSString *)user

{
    NSString *userFormat1 =@"(?:[A-Za-z]+[a-z0-9]*)";
    
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *userTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userFormat1];
    return [userTest1 evaluateWithObject:user];
    
}


-(BOOL)validateMobile:(NSString*)mobilenumber{
    NSString *mobileFormat1 =  @"[0-9]{10}?";
    
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *mobileTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat1];
    return [mobileTest1 evaluateWithObject:mobilenumber];
    
}
-(BOOL)validateNames:(NSString *)country1
{
    NSString *countryFormat1 = @"(?:[A-Za-z]+[a-z]*)";
    
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *countryTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countryFormat1];
    return [countryTest1 evaluateWithObject:country1];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)back
{
    [[self.navigationController.navigationBar viewWithTag:111]removeFromSuperview];
     [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    
    pickerView.hidden=YES;
    pickerCountry.hidden=YES;
    [super viewDidLoad];
    
    
    //age picker
    arrayNo = [[NSMutableArray alloc] init];
    [arrayNo addObject:@" 10-20 "];
    [arrayNo addObject:@" 21-30 "];
    [arrayNo addObject:@" 31-40 "];
    [arrayNo addObject:@" 41-50"];
    [arrayNo addObject:@" 51-60"];
    [arrayNo addObject:@" 61-70"];
    [arrayNo addObject:@" 71-80"];
    [arrayNo addObject:@" 81-90"];
    [arrayNo addObject:@" 91-100"];
    countryname=[[NSMutableArray alloc]init];
    [countryname addObject:@"Algeria"];
    [countryname addObject:@"Angola"];
    [countryname addObject:@"Anguilla"];
    [countryname addObject:@"Antigua and Barbuda"];
    [countryname addObject:@"Argentina"];
    [countryname addObject:@"Armenia"];
    [countryname addObject:@"Australia"];
    [countryname addObject:@"Austria"];
    [countryname addObject:@"Azerbaijan"];
    [countryname addObject:@"Bahamas"];
    [countryname addObject:@"Bahrain"];
    [countryname addObject:@"Barbados"];
    [countryname addObject:@"Belarus"];
    [countryname addObject:@"Belgium"];
    [countryname addObject:@"Belize"];
    [countryname addObject:@"Bermuda"];
    [countryname addObject:@"Bolivia"];
    [countryname addObject:@"Botswana"];
    [countryname addObject:@"Brazil"];
    [countryname addObject:@"Brunei"];
    [countryname addObject:@"Darussalam"];
    [countryname addObject:@"Bulgaria"];
    [countryname addObject:@"Canada"];
    [countryname addObject:@"Cayman Islands"];
    [countryname addObject:@"Chile"];
    [countryname addObject:@"China"];
    [countryname addObject:@"Colombia"];
    [countryname addObject:@"Costa Rica"];
    [countryname addObject:@"Croatia"];
    [countryname addObject:@"Cyprus"];
    [countryname addObject:@"Czech Republic"];
    [countryname addObject:@"Denmark"];
    [countryname addObject:@"Dominica"];
    [countryname addObject:@"Dominican Republic"];
    [countryname addObject:@"Ecuador"];
    [countryname addObject:@"Egypt"];
    [countryname addObject:@"El Salvador"];
    [countryname addObject:@"Estonia"];
    [countryname addObject:@"Finland"];
    [countryname addObject:@"France"];
    [countryname addObject:@"Germany"];
    [countryname addObject:@"Ghana"];
    [countryname addObject:@"Greece"];
    [countryname addObject:@"Grenada"];
    [countryname addObject:@"Guatemala"];
    [countryname addObject:@"Guyana"];
    [countryname addObject:@"Honduras"];
    [countryname addObject:@"Hong Kong"];
    [countryname addObject:@"Hungary"];
    [countryname addObject:@"Iceland"];
    [countryname addObject:@"India"];
    [countryname addObject:@"Indonesia"];
    [countryname addObject:@"Ireland"];
    [countryname addObject:@"Israel"];
    [countryname addObject:@"Italy"];
    [countryname addObject:@"Jamaica"];
    [countryname addObject:@"Japan"];
    [countryname addObject:@"Jordan"];
    [countryname addObject:@"Kazakstan"];
    [countryname addObject:@"Kenya"];
    [countryname addObject:@"Korea"];
    [countryname addObject:@"Kuwait"];
    [countryname addObject:@"Latvia"];
    [countryname addObject:@"Lebanon"];
    [countryname addObject:@"Lithuania"];
    [countryname addObject:@"Luxembourg"];
    [countryname addObject:@"Macau"];
    [countryname addObject:@"Macedonia"];
    [countryname addObject:@"Madagascar"];
    [countryname addObject:@"Malaysia"];
    [countryname addObject:@"Mali"];
    [countryname addObject:@"Malta"];
    [countryname addObject:@"Mauritius"];
    [countryname addObject:@"Mexico"];
    [countryname addObject:@"Moldova"];
    [countryname addObject:@"Montserrat"];
    [countryname addObject:@"Netherlands"];
    [countryname addObject:@"New Zealand"];
    [countryname addObject:@"Nicaragua"];
    [countryname addObject:@"Niger"];
    [countryname addObject:@"Nigeria"];
    [countryname addObject:@"Norway"];
    [countryname addObject:@"Oman"];
    [countryname addObject:@"Pakistan"];
    [countryname addObject:@"Panama"];
    [countryname addObject:@"Paraguay"];
    [countryname addObject:@"Peru"];
    [countryname addObject:@"Philippines"];
    [countryname addObject:@"Poland"];
    [countryname addObject:@"Portugal"];
    [countryname addObject:@"Qatar"];
    [countryname addObject:@"Romania"];
    [countryname addObject:@"Russia"];
    [countryname addObject:@"Saint Kitts and Nevis"];
    [countryname addObject:@"Saint Lucia"];
    [countryname addObject:@"Saint Vincent and The Grenadines"];
    [countryname addObject:@"Saudi Arabia"];
    [countryname addObject:@"Senegal"];
    [countryname addObject:@"Singapore"];
    [countryname addObject:@"Slovakia"];
    [countryname addObject:@"Slovenia"];
    [countryname addObject:@"South Africa"];
    [countryname addObject:@"Spain"];
    [countryname addObject:@"Sri Lanka"];
    [countryname addObject:@"Suriname"];
    [countryname addObject:@"Sweden"];
    [countryname addObject:@"Switzerland"];
    [countryname addObject:@"Taiwan"];
    [countryname addObject:@"Tanzania"];
    [countryname addObject:@"Trinidad and Tobago"];
    [countryname addObject:@"Tunisia"];
    [countryname addObject:@"Turkey"];
    [countryname addObject:@"Turks and Caicos Islands"];
    [countryname addObject:@"Uganda"];
    [countryname addObject:@"United Arab Emirates"];
    [countryname addObject:@"United Kingdom"];
    [countryname addObject:@"United States"];
    [countryname addObject:@"Uruguay"];
    [countryname addObject:@"Uzbekistan"];
    [countryname addObject:@"Venezuela"];
    [countryname addObject:@"Vietnam"];
    [countryname addObject:@"Virgin Islands, British"];
    [countryname addObject:@"Yemen"];
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    sex=@"null";
       
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    pass.clearButtonMode = UITextFieldViewModeWhileEditing;
    cpass.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    mobile.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    firstname.clearButtonMode=UITextFieldViewModeWhileEditing;
    lastname.clearButtonMode=UITextFieldViewModeWhileEditing;
    face.clearButtonMode = UITextFieldViewModeWhileEditing;
    skype.clearButtonMode = UITextFieldViewModeWhileEditing;


    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Sign Up", @"");
    [label sizeToFit];
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@"Back.png"]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;

  
        
    agebutt.text=@"Select Age";
    
       
    countrybutt.text=@"United States";

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapped)];
    [pickerView addGestureRecognizer:tapGR];
    UITapGestureRecognizer *tapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapped)];
    [pickerCountry addGestureRecognizer:tapGR1];
    
    
      
    }//name, *pass,*cpass,*email,*skype,*face,*mobile,*state,*city,*age,*country

-(void)dismissKeyboard {
    [name resignFirstResponder];
    [pass resignFirstResponder];
    [cpass resignFirstResponder];
    [email resignFirstResponder];
    [skype resignFirstResponder];
    [mobile resignFirstResponder];
    [firstname resignFirstResponder];
    [lastname resignFirstResponder];
    [face resignFirstResponder];
    [agebutt resignFirstResponder];
     
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    if(pickerView.tag==1){
        return 1;}
    else if(pickerCountry.tag==2){
        return 1;}
}



- (void)pickerViewTapped {
    pickerView.hidden=YES;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;{
    if(pickerView.tag==1){
        return [arrayNo count];}
    else if(pickerCountry.tag==2){
        return [countryname count];}
    }


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if(pickerView.tag==1){
        return [arrayNo objectAtIndex:row];
    }
    else if(pickerCountry.tag==2)
    return [countryname objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag==1)
    
    agebutt.text= [arrayNo objectAtIndex:row];
  
    else if(pickerCountry.tag==2)
        countrybutt.text=[countryname objectAtIndex:row];
    
    self.pickerView.hidden=YES;
    self.pickerCountry.hidden=YES;
}
- (IBAction)agebut:(id)sender{
    
    if(pickerView.hidden==YES){
        [(UILabel*)[self.view viewWithTag:3] resignFirstResponder];
        self.pickerView.hidden=NO;}

    
}
- (IBAction)countrybut:(id)sender{
    if(pickerCountry.hidden==YES){
        [(UILabel*)[self.view viewWithTag:4] resignFirstResponder];
        self.pickerCountry.hidden=NO;}
    }
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(pickerView.hidden==NO)
    {
        pickerView.hidden=YES;
    }
    if(pickerCountry.hidden==NO)
    {
        pickerCountry.hidden=YES;
    }

}





-(IBAction)SingnUp
{
        static int c=0;
        
        [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
        [(UITextField*)[self.view viewWithTag:102] resignFirstResponder];
        [(UITextField*)[self.view viewWithTag:105] resignFirstResponder];
        [(UITextField*)[self.view viewWithTag:106] resignFirstResponder];
        [(UITextField*)[self.view viewWithTag:107] resignFirstResponder];
        [(UITextField*)[self.view viewWithTag:108] resignFirstResponder];
        [(UITextField*)[self.view viewWithTag:109] resignFirstResponder];
        [(UITextField*)[self.view viewWithTag:110] resignFirstResponder];
        [(UILabel*)[self.view viewWithTag:3] resignFirstResponder];
        [(UILabel*)[self.view viewWithTag:4] resignFirstResponder];
        
        //Displaying RedTextBox 
        if ([name.text length] == 0)
        {
            us.hidden=NO;
        }
        else
        {
            us.hidden=YES;
        }
        
        if ([pass.text length] == 0)
        {
            pa.hidden=NO;
        }
        else
        {
            pa.hidden=YES;
        }
        if ([cpass.text length] == 0)
        {
            
            copa.hidden=NO;
        }
        else
        {
            copa.hidden=YES;
        }
        
        
                
        if ([email.text length] == 0)
        {
            
            eid.hidden=NO;
        }
        else
        {
            eid.hidden=YES;
        }
        if([agebutt.text isEqualToString: @"Select Age"] )
        {
            
            age.hidden=NO;
        }
        else
        {
            age.hidden=YES;
        }
    if([mobile.text length]==0 )
    {
        
        mobileval.hidden=NO;
    }
    else
    {
        mobileval.hidden=YES;
    }

    
    
        if([email.text length] != 0&&[cpass.text length] != 0&&[pass.text length] != 0&&[name.text length] != 0 && ![agebutt.text isEqualToString:@"Select Age"] &&! [sex isEqualToString: @"null"]&&[mobile.text length] !=0)
            
        {
            //Sign Up Validation For Required Details
            c=0;
            if ([self validateUsername:[name text]]==1)
            {
                if([agebutt.text length]!=0)
                {
                    if([self validateEmail:[email text]] ==1)
                    {
                        
                        if ([pass.text isEqualToString:cpass.text])
                        {
                            if([self validateMobile:[mobile text]]==1)
                            {
                                c=1;
                            }
                            else
                            {
                                BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Enter Valid Mobile Number."];
                                
                           
                                [alert setDestructiveButtonWithTitle:@"x" block:nil];
                                [alert show];
                                
                            }
                        }
                        else
                        {
                            
                            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Password Doesnt Match."];
                            
                     
                            [alert setDestructiveButtonWithTitle:@"x" block:nil];
                            [alert show];
                        }
                        
                    }
                    
                    else
                    {
                        
                        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Enter the valid email id."];
                        
                        [alert setDestructiveButtonWithTitle:@"x" block:nil];
                        [alert show];
                        
                    }
                    
                }
                
                else
                {
                    
                    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Enter Age."];
      
                    [alert setDestructiveButtonWithTitle:@"x" block:nil];
                    [alert show];
                }
                
                
                
            }
            
            
            else{
                BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Enter the valid Username."];
                
                [alert setDestructiveButtonWithTitle:@"x" block:nil];
                [alert show];
                
            }
            
                        
            
            if(c==1)
            {
                NSLog(@"signup called");
                HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
                [self.navigationController.view addSubview:HUD];
                HUD.delegate = self;
                HUD.labelText = @"Registering....";
                [HUD show:YES];
                [self performSelector:@selector(signUpMethod)withObject:nil afterDelay:0.2 ];
                
            }
            else{
                NSLog(@"%d",c);
                NSLog(@"signup failed");
            }
        }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Please Enter All The Required Fields."];
            
            [alert setDestructiveButtonWithTitle:@"x" block:nil];
            [alert show];
        }
        
        
    }



-(void)signUpMethod
{
    
    //NSLog(@"checkService");
    
    
    Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
	switch (netStatus)
	{
		case NotReachable:
		{
			isConnect=NO;
			//NSLog(@"Access Not Available");
			break;
		}
			
		case ReachableViaWWAN:
		{
			isConnect=YES;
			//NSLog(@"Reachable WWAN");
			break;
		}
		case ReachableViaWiFi:
		{
			isConnect=YES;
			//NSLog(@"Reachable WiFi");
			break;
		}
	}
	
	
    
    if(isConnect)
    {
        
    }
    //  imgName=@"Connected.png";
    else
    {
        HUD.labelText = @"Check network connection....";
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD hide:YES afterDelay:1];
        return;
    }
    
    
    
    [name resignFirstResponder];
    [pass resignFirstResponder];
    [cpass resignFirstResponder];
    
    ////NSLog(@"signup");
    if ([[pass text]isEqualToString:[cpass text]]) 
    {
        
        
        ////NSLog(@"REGISTRATION"); 
        NSString *resultResponse=[self HttpPostEntityFirst:@"username" ForValue1:name.text EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
        //NSLog(@"********%@",resultResponse);
        
        
        NSError *error;
        
        SBJSON *json = [[SBJSON new] autorelease];
        NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
        
     
        if (luckyNumbers == nil)
        {
            
            //NSLog(@"RAJA");
            
        }
        else 
        {
            
            NSDictionary* menu = [luckyNumbers objectForKey:@"serviceresponse"];
            //NSLog(@"Menu id: %@", [menu objectForKey:@"servicename"]);
            
            
            
            if ([[menu objectForKey:@"servicename"] isEqualToString:@"Signup"]) 
            {
                if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"]) 
                {
                    HUD.labelText = @"Completed.";
                    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
                    HUD.mode = MBProgressHUDModeCustomView;
                    [HUD hide:YES afterDelay:0];
                    
                                    
                    
                    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Info!" message:@"Registration successful!"];
                    
                  
                    [alert setDestructiveButtonWithTitle:@"x" block:nil];
                    [alert show];
                    [[self navigationController] popViewControllerAnimated:YES];
                    
                    
                }
                else
                {
                    
           
                    
                    if ([[menu objectForKey:@"message"] isEqualToString:@"Already Exist"])
                    {
                 
                        
                        
                        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"UserName Already Exits and active."];
                        
                        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
                        [alert setDestructiveButtonWithTitle:@"x" block:nil];
                        [alert show];
                        
                           [HUD hide:YES];
                        return;
                    }
                                    
                    
                }
            }
            
            
            
            
            
            
        }
        
          
    }
    else if([[name text] isEqualToString:@""])
    {
        
          
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Failed!" message:@"Registration Failed."];
        

        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
        
    }
    else
    {
        
             
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"password!" message:@"Incorrect Password."];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
        
        
        
        }
    
 
       [HUD hide:YES];
    
}


-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    // NSString *authKey=@"rzTFevN099Km39PV";
    // NSString *userId=@"alagar@ajsquare.net";
    
    
    //NSLog(@"HTTP");
    
    
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&fname=%@&lname=%@&pswd=%@&sex=%@&age=%@&email=%@&skype=%@&facetime=%@&mobile=%@&country=%@&%@=%@",firstEntity,value1,firstname.text,lastname.text,pass.text,sex,agebutt.text,email.text,skype.text,face.text,mobile.text,countrybutt.text,secondEntity,value2];
    
      
    
      NSURL *url=[NSURL URLWithString:@"http://medsmonit.com/Service/patientresponce.php?service=patinsert"];
   
    
    
    ////NSLog(post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
     //NSLog(@"postlenth%@",postLength);
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //when we user https, we need to allow any HTTPS cerificates, so add the one line code,to tell teh NSURLRequest to accept any https certificate, i'm not sure //about the security aspects
    
    
    //    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    
    
   
    
    return data;
    
}


- (void)viewDidUnload
{
    [pickerView release];
    [self setCountrybutt:nil];
    [self setPickerCountry:nil];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [countrybutt release];
    [pickerCountry release];
    [super dealloc];
}

@end
