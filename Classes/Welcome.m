//
//  Welcome.m
//  MediMoni
//
//  Created by hsa1 on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Welcome.h"
#import "DemoHintView.h"
#import "JSON/JSON.h"
#import "fileMngr.h"
#import "AppSharedInstance.h"
#import "ADLivelyTableView.h"
#import "ListCell.h"
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
#import "LoginScreen.h"
#import "BlockAlertView.h"
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1
@interface Welcome ()

@end

@implementation Welcome
@synthesize recordDict;
@synthesize petArray;
@synthesize _assQues;
@synthesize _assAns;
@synthesize assesment;
@synthesize tableContents;
@synthesize sortedKeys;
@synthesize first;



AppSharedInstance *instance;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
   
    }
    return self;
}
-(void)back
{
    
}


- (void)myTask {
	
	sleep(20);
}

-(IBAction)sunc:(id)sender
{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    
	HUD.delegate = self;
	HUD.labelText = @"Loading...";
    [HUD show:YES];
    [self performSelector:@selector(sunc1) withObject:nil afterDelay:0.2 ];
}

-(IBAction)signout
{
    
    LoginScreen*new = [[LoginScreen alloc] initWithNibName:@"LoginScreen" bundle:nil];
   [self.navigationController pushViewController:new animated:NO];
    [LoginScreen release];
    
}

-(IBAction)Hometomedi
{
    
    RootViewController*new = [[RootViewController alloc] initWithNibName:@"roor" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [RootViewController release];
    
}
-(IBAction)Hometorem
{
    
    Cremainder*new = [[Cremainder alloc] initWithNibName:@"Cremainder" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Cremainder release];
}
-(IBAction)Hometoass
{
    
    Assessment*new = [[Assessment alloc] initWithNibName:@"Assessment" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Assessment release];
}
-(IBAction)Hometoapp
{
    
    Appoinment*new = [[Appoinment alloc] initWithNibName:@"Appoinment" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Appoinment release];
}
-(IBAction)Hometocom
{
    
    Communicate*new = [[Communicate alloc] initWithNibName:@"Communicate" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Communicate release];
}
-(IBAction)Hometoset
{
    
    NewViewController*new = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [NewViewController release];
}

-(IBAction)sunc1
{
    
    
    instance = [AppSharedInstance sharedInstance];
    self.petArray = [instance getPet];
    self._assQues=[instance getAssQue];
    self._assAns=[instance getAssAnswer];
    self.assesment=[instance getAssesment];
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    
    
    
    Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
	switch (netStatus)
	{
		case NotReachable:
		{
			isConnect=NO;
			NSLog(@"Access Not Available");
			break;
		}
			
		case ReachableViaWWAN:
		{
			isConnect=YES;
			NSLog(@"Reachable WWAN");
			break;
		}
		case ReachableViaWiFi:
		{
			isConnect=YES;
		NSLog(@"Reachable WiFi");
			break;
		}
	}
	
	
    
    if(isConnect)
    {
        
    }
  
    else
    {
        HUD.labelText = @"Check network connection....";
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD hide:YES afterDelay:2];
        return;
    }
    
    
    
    NSString *resultResponse=[self HttpPostEntityFirst1:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSString *resultResponse1=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSString *resultResponseASS=[self HttpPostEntityFirstASS:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSString *resultResponseREMINDER=[self HttpPostEntityFirstREMINDER:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSString *resultResponsePROVIDER=[self HttpPostEntityFirstPROVIDER:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSString* _listOfPro=[self HttpPostEntityFirst_listOfPro:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    
    
    
    
    
    
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    
	NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
    NSDictionary *luckyNumbers1 = [json objectWithString:resultResponse1 error:&error];
    NSDictionary *luckyNumbersASS = [json objectWithString:resultResponseASS error:&error];
    
    NSDictionary *luckyNumbersProvider = [json objectWithString:resultResponsePROVIDER error:&error];
    NSDictionary *Provideritems = [luckyNumbersProvider objectForKey:@"serviceresponse"];
    NSArray *Provideritems1=[Provideritems objectForKey:@"Select Provider"];
    
    
    NSDictionary *luckyNumberslistofpro = [json objectWithString:_listOfPro error:&error];
    NSDictionary *_listOfProitems = [luckyNumberslistofpro objectForKey:@"serviceresponse"];
    NSArray *_listOfProitems1=[_listOfProitems objectForKey:@"Select Providers"];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
    NSMutableArray *ProDl=[[NSMutableArray alloc]init];
    NSMutableArray *ProNaml=[[NSMutableArray alloc]init];
    NSString*ProDFilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFilel"]];
    NSString*ProNamfilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfilel"]];
    NSLog(@"_listOfProitems1:%@",_listOfProitems1);
    for (id anUpdate in _listOfProitems1)
    {
        NSDictionary *ProID=[(NSDictionary*)anUpdate objectForKey:@"provideid"];
        NSDictionary *ProName=[(NSDictionary*)anUpdate objectForKey:@"providername"];
      
        [ProDl addObject:[NSString stringWithFormat:@"%@",ProID]];
        [ProNaml addObject:[NSString stringWithFormat:@"%@",ProName]];
    }
    
    [fileMngr saveDatapath:ProDFilel contentarray:ProDl];
    [fileMngr saveDatapath:ProNamfilel contentarray:ProNaml];
    
    HUD.labelText = @"Feteching Data...";
    // return;
    

    
    NSMutableArray *ProD=[[NSMutableArray alloc]init];
    NSMutableArray *ProNam=[[NSMutableArray alloc]init];
    
    NSLog(@"Provideritems1:%@",Provideritems1);
    for (id anUpdate in Provideritems1)
    {
        NSDictionary *ProID=[(NSDictionary*)anUpdate objectForKey:@"provideid"];
        NSDictionary *ProName=[(NSDictionary*)anUpdate objectForKey:@"providername"];
       
        [ProD addObject:[NSString stringWithFormat:@"%@",ProID]];
        [ProNam addObject:[NSString stringWithFormat:@"%@",ProName]];
        
    }
    
    
	NSString*ProDFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFile"]];
    NSString*ProNamfile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfile"]];
    [fileMngr saveDatapath:ProDFile contentarray:ProD];
    [fileMngr saveDatapath:ProNamfile contentarray:ProNam];
    
       
    
    
    
    /*REMINDERS***************/
    
    
    
    
    
    NSDictionary *luckyNumbersREMINDER = [json objectWithString:resultResponseREMINDER error:&error];
    NSDictionary *REMINDERitems = [luckyNumbersREMINDER objectForKey:@"serviceresponse"];
    NSArray *REMINDERitems1=[REMINDERitems objectForKey:@"Patient Reminder"];
    
    
    
    for (id anUpdate in REMINDERitems1)
    {
        
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"remindername"];
        NSDictionary *arrayListType=[(NSDictionary*)anUpdate objectForKey:@"remindertype"];
        NSDictionary *arrayListDate=[(NSDictionary*)anUpdate objectForKey:@"reminderdate"];
        NSLog(@"remaindername:%@",arrayList);
        NSLog(@"remaindername:%@",arrayListType);
        NSLog(@"remaindername:%@",arrayListDate);
        
        
        
        NSString *dateString = [NSString stringWithFormat:@"%@",arrayListDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd  hh:mm"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:dateString];
        [dateFormatter release];
        NSString*s=[NSString stringWithFormat:@"%@",arrayListType];
     
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        localNotif.fireDate = dateFromString;
        localNotif.timeZone = [NSTimeZone systemTimeZone];
        localNotif.alertBody = [NSString stringWithFormat:@"%@",arrayList ];
        localNotif.alertAction = @"View";
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber = 0;
                if([s isEqualToString:@"Daily"])
        {
          localNotif.repeatInterval = NSDayCalendarUnit;
        }
        else
        {
            localNotif.repeatInterval = 0;
        }
        
      /*  NSMutableArray *SheduleArray=[[NSMutableArray alloc] initWithArray:[[UIApplication sharedApplication]scheduledLocalNotifications]];
             for(int s=0;s<[SheduleArray count];s++){
                 UILocalNotification *Not=[SheduleArray objectAtIndex:s];
               int getId=[[Not.userInfo valueForKey:@"Id"] intValue];
                 if(getId==(int)runNumber)
                 {
                         [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
                         }
               }
   
        */
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        [localNotif release];
        
        
        
    }
    
    
    
    
    
    //////***********************ASSESSMENT*********************??//
    
    NSDictionary *items = [luckyNumbers objectForKey:@"serviceresponse"];
    NSArray *items1=[items objectForKey:@"Patient Medicines"];
    
    NSDictionary *itemsApp = [luckyNumbers1 objectForKey:@"serviceresponse"];
    NSArray *items1App=[itemsApp objectForKey:@"Patient Appointment"];
    
    
    NSDictionary *qusres = [luckyNumbersASS objectForKey:@"serviceresponse"];
    
    NSArray *patQuestion=[qusres objectForKey:@"Patient Question"];
    
   NSLog(@"RESULT ASSESS =%@",patQuestion);
    
    
    for (id anUpdate in patQuestion)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assid"];
        NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assname"];
        
      
        
        if([self.assesment count]==0)
        {
            [recordDict setObject:arrayList forKey:@"id"];
            [recordDict setObject:arrayList1 forKey:@"name"];
            [instance insertAssesment:recordDict];
            
            
            
            NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assessment"];
              NSLog(@"Arraylist2 val:%@",arrayList2);
            for (id anUpdate in arrayList2)
            {
                
                [recordDict setObject:arrayList forKey:@"assid"];
             
                [recordDict setObject:arrayList1 forKey:@"assname"];
               
                
                
                NSDictionary *arrayListid=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assparentquestionid"];
                NSDictionary *arrayList3=[(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
                
                [recordDict setObject:arrayListid forKey:@"assquestionid"];
                
                
                [recordDict setObject:arrayList1 forKey:@"assquestion"];
                [recordDict setObject:arrayList2 forKey:@"assparentquestionid"];
                [recordDict setObject:arrayList3 forKey:@"assparentanswerid"];
                [instance insertAss:recordDict];
                
                
                
                
                
                //**************ANSWERS*************
                NSDictionary *arrayList22=[(NSDictionary*)anUpdate objectForKey:@"answer"];
                for (id anUpdate in arrayList22)
                {
                    
                    
                 
                    [recordDict setObject:arrayList forKey:@"assid"];
                 
                    
                    
                    NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assanswerid"];
                    NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assanswer"];
                    [recordDict setObject:arrayList1 forKey:@"ansid"];
                    [recordDict setObject:arrayList2 forKey:@"answer"];
                    [instance insertAnswer:recordDict];
                    
               
                    
                }
                
                
                
            }
            
        }
        else
        {
            Add=0;
            for(int j=0;j<[self.assesment count];j++)
            {
                NSString*s1= [[self.assesment objectAtIndex:j] objectForKey:@"id"];
                NSString*s=[(NSDictionary*)anUpdate objectForKey:@"assid"];
               
                if(![s1 isEqualToString:s])
                {
                    Add++;
                    
                     
                    
                    
                }
                
            }
            
            if(Add==[self.assesment count])
            {
                [recordDict setObject:arrayList forKey:@"id"];
                [recordDict setObject:arrayList1 forKey:@"name"];
                [instance insertAssesment:recordDict];
                
                
                
                NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assessment"];
                
                for (id anUpdate in arrayList2)
                {
                    
                    [recordDict setObject:arrayList forKey:@"assid"];
               
                    [recordDict setObject:arrayList1 forKey:@"assname"];
             
                    
                    
                    NSDictionary *arrayListid=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                    NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                    NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assparentquestionid"];
                    NSDictionary *arrayList3=[(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
                    
                    [recordDict setObject:arrayListid forKey:@"assquestionid"];
                    
                    
                    [recordDict setObject:arrayList1 forKey:@"assquestion"];
                    [recordDict setObject:arrayList2 forKey:@"assparentquestionid"];
                    [recordDict setObject:arrayList3 forKey:@"assparentanswerid"];
                    [instance insertAss:recordDict];
                    
                    
                    
                    
                    
                    //**************ANSWERS*************
               NSDictionary *arrayList22=[(NSDictionary*)anUpdate objectForKey:@"answer"];
                    for (id anUpdate in arrayList22)
                    {
                        
                        [recordDict setObject:arrayList forKey:@"assid"];
                        //    [instance insertAnswer:recordDict];
                        
                        NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assanswerid"];
                        NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assanswer"];
                        
                        
                        [recordDict setObject:arrayList1 forKey:@"ansid"];
                        [recordDict setObject:arrayList2 forKey:@"answer"];
                        [instance insertAnswer:recordDict];
                    }
                }
               
            }
            
            
            
            
        }
        
        
        
        
    }
    
    //********************ASSESSMENT   END***********************************************??//
    
    
    
    
    
    
    
    
    
    NSMutableArray*tempM=[[NSMutableArray alloc]init];
    NSMutableArray*tempD=[[NSMutableArray alloc]init];

    for (id anUpdate in items1)
    {
        NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"serviceresponse"];
      NSLog(@"MEDI NAME:%@",[arrayList1 objectForKey:@"medicinename"]);
        NSLog(@"DIRECTION:%@",[arrayList1 objectForKey:@"direction"]);
        NSLog(@"NOTES:%@",[arrayList1 objectForKey:@"medicinenotes"]);
        
        [tempM addObject:[arrayList1 objectForKey:@"medicinename"]];
            [tempD addObject:[arrayList1 objectForKey:@"direction"]];
            
        
        
    }
    
   
    
    if([petArray count]==0)
    {
        for(int j=0;j<[tempM count];j++)
        {
            [recordDict setObject:[tempM objectAtIndex:j] forKey:@"name"];
            [recordDict setObject:[tempD objectAtIndex:j] forKey:@"akc"];
           
            [instance insertPet:recordDict];
            
        }
    }
    else
    {
        
        
        int xx=0;
        for(int i=0;i<[tempM count];i++)
        {
            xx=0;
            for(int j=0;j<[petArray count];j++)
            {
                
                NSString*s=[tempM objectAtIndex:i];
                NSString*s1= [[petArray objectAtIndex:j] objectForKey:@"name"];
                
                            
                if([s isEqualToString:s1])
                {
                    
                }
                else {
                    
                    xx++;
                    
                    if(xx==[petArray count])
                    {
                        xx=0;
                        ////NSLog(@"raja");
                        [recordDict setObject:[tempM objectAtIndex:i] forKey:@"name"];
                         [recordDict setObject:[tempD objectAtIndex:i] forKey:@"akc"];
                        [instance insertPet:recordDict];
                      
                        
                        
                    }
                }
            }
        }
    }
    
    
    
    
    
   NSLog(@"Petarrat in sync:%@",self.petArray);
    
    
    
    
    
    
    
    
    
    /********************AppoinMent********************/
    
    NSMutableArray*temp=[[NSMutableArray alloc]init];
    NSMutableArray*temp1=[[NSMutableArray alloc]init];
    for (id anUpdate1 in items1App)
    {
        NSDictionary *arrayList1=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
        
        
        [temp addObject:[arrayList1 objectForKey:@"appdate"]];
        [temp1 addObject:[arrayList1 objectForKey:@"appnotes"]];
        
        
    }
    
    
    
    
    
    if([_AppDArr count]==0&&[_AppNArr count]==0)
    {
        for(int j=0;j<[temp count];j++)
        {
            [_AppDArr addObject:[temp objectAtIndex:j]];
            [_AppNArr addObject:[temp1 objectAtIndex:j]];
        }
    }
    else {
        int x=0;
        for(int i=0;i<[temp1 count];i++)
        {
            x=0;
            for(int j=0;j<[_AppNArr count];j++)
            {
                
                NSString*s=[temp1 objectAtIndex:i];
                NSString*s1=[_AppNArr objectAtIndex:j];
                
                if([s isEqualToString:s1])
                {
                    
                }
                else {
                    
                    x++;
                    
                    if(x==[_AppNArr count])
                    {
                        x=0;
                        
                        [_AppDArr addObject:[temp objectAtIndex:i]];
                        [_AppNArr addObject:[temp1 objectAtIndex:i]];
                        
                    }
                }
            }
            
            
            
        }
        
    }
    
    
    
    [fileMngr saveDatapath:appoFile contentarray:_AppDArr];
    [fileMngr saveDatapath:appoNFile contentarray:_AppNArr];
    
    HUD.labelText = @"Completed.";
    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:0];
    [self viewWillAppear:YES];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.sortedKeys count];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [self.sortedKeys objectAtIndex:section];
}



// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *listData =[self.tableContents objectForKey:[self.sortedKeys objectAtIndex:section]];
	return [listData count];
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#if USE_CUSTOM_DRAWING
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger BOTTOM_LABEL_TAG = 1002;
	UILabel *topLabel;
	UILabel *bottomLabel;
#endif
    NSArray *listData =[self.tableContents objectForKey:[self.sortedKeys objectAtIndex:[indexPath section]]];
    NSLog(@"[self.sortedKeys objectAtIndex:[indexPath section]] ---->%@",[self.sortedKeys objectAtIndex:[indexPath section]]);
    
    
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		
		cell =[[[UITableViewCell alloc]initWithFrame:CGRectZero
                                     reuseIdentifier:CellIdentifier]
               autorelease];
        
#if USE_CUSTOM_DRAWING
		UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
		cell.accessoryView =
        [[[UIImageView alloc]
          initWithImage:nil]
         autorelease];
		
		const CGFloat LABEL_HEIGHT = 20;
		UIImage *image = [UIImage imageNamed:@"imageA.png"];
        
		//
		// Create the label for the top row of text
		//
		topLabel =
        [[[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     image.size.width + 2.0 * cell.indentationWidth,
                     0.5 * (aTableView.rowHeight - 2 * LABEL_HEIGHT),
                     aTableView.bounds.size.width -
                     image.size.width - 4.0 * cell.indentationWidth
                     - indicatorImage.size.width,
                     LABEL_HEIGHT)]
         autorelease];
		[cell.contentView addSubview:topLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		topLabel.highlightedTextColor = [UIColor redColor];
		topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
        
		//
		// Create the label for the top row of text
		//
		bottomLabel =
        [[[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     image.size.width + 2.0 * cell.indentationWidth,
                     0.5 * (aTableView.rowHeight - 2 * LABEL_HEIGHT) + LABEL_HEIGHT,
                     aTableView.bounds.size.width -
                     image.size.width - 4.0 * cell.indentationWidth
                     - indicatorImage.size.width,
                     LABEL_HEIGHT)]
         autorelease];
		[cell.contentView addSubview:bottomLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		bottomLabel.tag = BOTTOM_LABEL_TAG;
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		bottomLabel.highlightedTextColor = [UIColor redColor];
		bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
        
		//
		// Create a background image view.
		//
		cell.backgroundView =
        [[[UIImageView alloc] init] autorelease];
		cell.selectedBackgroundView =
        [[[UIImageView alloc] init] autorelease];
#endif
	}
    
#if USE_CUSTOM_DRAWING
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
	}
    if([[self.sortedKeys objectAtIndex:[indexPath section]]isEqual:@"Appointment"])
    {
        
        bottomLabel.text=[_AppDArr objectAtIndex:indexPath.row];
        topLabel.text=[_AppNArr objectAtIndex:indexPath.row];
    }
    
    else if([[self.sortedKeys objectAtIndex:[indexPath section]]isEqual:@"Reminder"])
    {
        UILocalNotification *notif = [reminderarray objectAtIndex:indexPath.row];
                
        
        topLabel.text = notif.alertBody;
        bottomLabel.text =[notif.fireDate descriptionWithLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]autorelease]] ;
        
    }
    else if([[self.sortedKeys objectAtIndex:[indexPath section]]isEqual:@"Medication"])
    {
        topLabel.text=[[petArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        bottomLabel.text=[[petArray objectAtIndex:indexPath.row]objectForKey:@"fromd"];
        
    }
    
    
	UIImage *rowBackground;
	UIImage *selectionBackground;
	NSInteger sectionRows = [aTableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	if (row == 0 && row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"Normal.png"];
		selectionBackground = [UIImage imageNamed:@"Higlight.png"];
	}
	else if (row == 0)
	{
		rowBackground = [UIImage imageNamed:@"Normal.png"];
		selectionBackground = [UIImage imageNamed:@"Higlight.png"];
	}
	else if (row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"Normal.png"];
		selectionBackground = [UIImage imageNamed:@"Higlight.png"];
	}
	else
	{
		rowBackground = [UIImage imageNamed:@"Normal.png"];
		selectionBackground = [UIImage imageNamed:@"Higlight.png"];
	}
	((UIImageView *)cell.backgroundView).image = rowBackground;
	((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
	
	//
	// Here I set an image based on the row. This is just to have something
	// colorful to show on each row.
	//
	
#else
	cell.text = [NSString stringWithFormat:@"Cell at row %ld.", [indexPath row]];
#endif
	
	return cell;
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}








-(IBAction)back1;
{
    
    [[self navigationController] popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    choose=0;
    int syncType=[[NSUserDefaults standardUserDefaults]integerForKey:@"syncType"];
    instance = [AppSharedInstance sharedInstance];
    self._assQues=[instance getAssQue];
    self._assAns=[instance getAssAnswer];
    self.assesment=[instance getAssesment];
    [myTable reloadData];
   
    
    if(syncType==1)
    {
        if(self.navigationItem.rightBarButtonItem==nil)
        {
            UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *saveImage = [UIImage imageNamed:@"Sync.png"]  ;
            [save setBackgroundImage:saveImage forState:UIControlStateNormal];
            [save addTarget:self action:@selector(sunc:) forControlEvents:UIControlEventTouchUpInside];
            save.frame = CGRectMake(0, 0, 80, 40);
            saveButton = [[[UIBarButtonItem alloc]
                           initWithCustomView:save] autorelease];
            
            self.navigationItem.rightBarButtonItem = saveButton;
        }
        else
        {
            self.navigationItem.rightBarButtonItem = saveButton;
        }
        
    }
    else
    {
        if(self.navigationItem.rightBarButtonItem!=nil)
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
    
    
    
    reminderarray=[[NSMutableArray alloc]init];
    
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(int i=0;i<[notificationArray count];i++)
    {
        UILocalNotification *notif = [notificationArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = notif.userInfo;
        
        NSDate *dateCurrent = [userInfoCurrent valueForKey:@"date"];
        //  ////NSLog(@"Found scheduled alarm with date:%@", userInfoCurrent );
        
        
        [reminderarray addObject:notif];
        
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"MM/dd/yyyy"];
        NSString *result = [df stringFromDate:dateCurrent];
        [df release];
        
        
        
        NSDate* date = [NSDate date];
        NSDateFormatter* df1 = [[NSDateFormatter alloc]init];
        [df1 setDateFormat:@"MM/dd/yyyy"];
        NSString *result1 = [df1 stringFromDate:date];
        
        
        
        if([result isEqualToString:result1])
        {
                   }
        
        
            }
    
    self.petArray = [instance getPet];
    //NSLog(@"self.petarray in welcome view will appear:%@",self.petArray);
 NSMutableArray*a=[[NSMutableArray alloc]init];
     // NSLog(@"%i",[self.petArray count]);
    for(int j=0;j<[self.petArray count];j++)
    {
        NSLog(@"yes");
        NSString*s1= [[self.petArray objectAtIndex:j] objectForKey:@"patid"];
        NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
       
      if(([s1 isEqualToString:UserId])||([s1 isEqual:@""]))
        {
            [a addObject:[self.petArray objectAtIndex:j]];
            
            
        }
    }
    
    self.petArray=a;
 
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
	appoFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"appoFile.hsa"]];
    appoNFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"appoNFile.hsa"]];
    
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:appoFile])
	{
		_AppDArr=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:appoFile]];
		
	}
	else
        
	{
		_AppDArr=[[NSMutableArray alloc]init];
	}
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:appoNFile])
	{
		_AppNArr=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:appoNFile]];
		
	}
	else
	{
		_AppNArr=[[NSMutableArray alloc]init];
	}
    
    
    
    
    
   
    
    /********************AppoinMent   End********************/
    
    
    NSString*name=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    
    //For displaying multiple medicine,reminder,appointments in welcome screen...
    NSDictionary *temp =[[NSDictionary alloc]initWithObjectsAndKeys:reminderarray,@"Reminder",_AppDArr,@"Appointment",petArray,@"Medication",nil];
    
    self.tableContents =temp;
    [temp release];
	NSLog(@"table %@",self.tableContents);
	NSLog(@"table with Keys %@",[self.tableContents allKeys]);
	self.sortedKeys =[[self.tableContents allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSLog(@"sorted %@",self.sortedKeys);
	[reminderarray release];
	[_AppDArr release];
    [petArray release];
    [myTable reloadData];
    
    
}


- (void)viewDidLoad
{
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@""]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
        [super viewDidLoad];
    [homeload setImage:[UIImage imageNamed:@"Home2.png"]forState:UIControlStateNormal];
    
    myTable.backgroundColor = [UIColor clearColor];
    reminderarray=[[NSMutableArray alloc]init];
      NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(int i=0;i<[notificationArray count];i++)
    {
        UILocalNotification *notif = [notificationArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = notif.userInfo;
        
        NSDate *dateCurrent = [userInfoCurrent valueForKey:@"date"];
        //  ////NSLog(@"Found scheduled alarm with date:%@", userInfoCurrent );
        
        
        [reminderarray addObject:notif];
        
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"MM/dd/yyyy"];
        NSString *result = [df stringFromDate:dateCurrent];
        [df release];
        
        
        
        NSDate* date = [NSDate date];
        NSDateFormatter* df1 = [[NSDateFormatter alloc]init];
        [df1 setDateFormat:@"MM/dd/yyyy"];
        NSString *result1 = [df1 stringFromDate:date];
        
        
        
        if([result isEqualToString:result1])
        {
           
        }
        
        
        
          }
    
    
    ADLivelyTableView * livelyTableView = (ADLivelyTableView *)myTable;
    livelyTableView.initialCellTransformBlock = ADLivelyTransformFan;
    
    myTable.rowHeight=100;
	myTable.separatorColor = [UIColor clearColor];
 
    
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Home", @"");
    [label sizeToFit];
    
    
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveImage = [UIImage imageNamed:@"Sync.png"]  ;
    [save setBackgroundImage:saveImage forState:UIControlStateNormal];
    [save addTarget:self action:@selector(sunc:)
   forControlEvents:UIControlEventTouchUpInside];
    save.frame = CGRectMake(0, 0, 80, 40);
    saveButton = [[[UIBarButtonItem alloc]
                   initWithCustomView:save] autorelease];
    
    
    int syncType=[[NSUserDefaults standardUserDefaults]integerForKey:@"syncType"];
    
    
    if(syncType==1)
    {
        
        self.navigationItem.rightBarButtonItem = saveButton;
        
    }
    else
    {
       
    }
    
    
    
    instance = [AppSharedInstance sharedInstance];
    
    
    if ([recordDict count]>0) {
        
        
	}
	else {
		recordDict = [[NSMutableDictionary alloc] init];
	}
    
       self.petArray = [instance getPet];
   
  NSMutableArray*a=[[NSMutableArray alloc]init];
    
    NSLog(@"%i",[self.petArray count]);
    for(int j=0;j<[self.petArray count];j++)
    {
        NSLog(@"yes");
        NSString*s1= [[self.petArray objectAtIndex:j] objectForKey:@"patid"];
        NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
        
    if(([s1 isEqualToString:UserId])||([s1 isEqual:@""]))
        {
            [a addObject:[self.petArray objectAtIndex:j]];
            
            
        }
    }
    
        self.petArray=a;
       
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
	appoFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"appoFile.hsa"]];
    appoNFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"appoNFile.hsa"]];
    
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:appoFile])
	{
		_AppDArr=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:appoFile]];
		
	}
	else
	{
		_AppDArr=[[NSMutableArray alloc]init];
	}
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:appoNFile])
	{
		_AppNArr=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:appoNFile]];
		
	}
	else
	{
		_AppNArr=[[NSMutableArray alloc]init];
	}
    
    
    
    
    
    
    
    /********************AppoinMent   End********************/
   
    NSString*name=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    
    welcome.text=[NSString stringWithFormat:@"Welcome %@ !",name];
    if(first==1)
    {
        first=0;
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Welcome!" message:name];
        

        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
    }

      NSDictionary *temp =[[NSDictionary alloc]initWithObjectsAndKeys:reminderarray,@"Reminder",_AppDArr,@"Appointment",petArray,@"Medication",nil];
    
    self.tableContents =temp;
    [temp release];
	NSLog(@"table %@",self.tableContents);
	NSLog(@"table with Keys %@",[self.tableContents allKeys]);
	self.sortedKeys =[[self.tableContents allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSLog(@"sorted %@",self.sortedKeys);
	[reminderarray release];
	[_AppDArr release];
    [petArray release];
    
    [myTable reloadData];
    
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
       return 30.0f;
    }

//To set color for every header in table section
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,300)];
        tempView.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"Top_Panel.png"]];
        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
        tempLabel.backgroundColor=[UIColor clearColor];
        tempLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        tempLabel.shadowOffset = CGSizeMake(0,2);
        tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
        tempLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
       
        tempLabel.text=[self.sortedKeys objectAtIndex:section];
        [tempView addSubview:tempLabel];
    
        [tempLabel release];
        return tempView;
    }

//Apponment
-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    HUD.labelText = @"Feteching Apoinments...";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/appointmentresponce.php?service=appdetail"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    return data;
    
}













-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    HUD.labelText = @"Feteching Medicines...";
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/medicineresponce.php?service=patmeddetail"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    return data;
    
}






//Assessment
-(NSString *)HttpPostEntityFirstASS:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    HUD.labelText = @"Feteching Assesments...";
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/questionresponce.php?service=question"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    return data;
    
}


-(NSString *)HttpPostEntityFirstREMINDER:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    HUD.labelText = @"Feteching reminders...";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/reminderresponce.php?service=reminder"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    return data;
    
}


-(NSString *)HttpPostEntityFirstPROVIDER:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    
    HUD.labelText = @"Feteching Providers Requests..";
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/requestresponce.php?service=providerlist"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    return data;
    
}





-(NSString *)HttpPostEntityFirst_listOfPro:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    HUD.labelText = @"Feteching Providers...";
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/requestresponce.php?service=providers"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    return data;
    
}




- (void)viewDidUnload
{
    [tableContents release];
	[sortedKeys release];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
