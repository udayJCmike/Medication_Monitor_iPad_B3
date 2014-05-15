#import "Addremainder.h"
#import "AppSharedInstance.h"
#import "ListCell.h"
#import "AboutmeViewController.h"
#import "ADLivelyTableView.h"
#import "AddRemainder.h"
#import "fileMngr.h"
#import "BlockAlertView.h"
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1

@implementation UINavigationBar (CustomImage)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"Top_Panel.png"];
    [image drawInRect:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height)];
}

@end
@implementation Addremainder
@synthesize petArray;
@synthesize recordDict;
@synthesize datePicker;
@synthesize clicked;
@synthesize index;
@synthesize notifname;
@synthesize notifdate;

AppSharedInstance *instance;

#pragma mark -
#pragma mark View lifecycle


-(IBAction)setTime

{
    if(clicked==1)
    {
        timeset=1;
    }
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    if(timePicker.hidden==YES)
    {
        timePicker.hidden=NO;
    }
    else
    {
        timePicker.hidden=YES;
        
    }
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"  h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:timePicker.date];
    timeLabel.text=timetofill;
}

- (IBAction)changeTimeInLabel:(id)sender

{
	
    
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"  h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:timePicker.date];
    timeLabel.text=timetofill;
    
    
    
}


- (IBAction)once:(UIButton *)button{
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
        mask.hidden=YES;
        setdate.hidden=NO;
        dateLabel.hidden=NO;
        
        maskDaily.hidden=NO;
        settime.hidden=YES;
        timeLabel.hidden=YES;
        timePicker.hidden=YES;
        alertType=1;
        
    }
    else
    {
        mask.hidden=NO;
        setdate.hidden=YES;
        dateLabel.hidden=YES;
        datePicker.hidden=YES;
        
        
        timeLabel.hidden=NO;
        settime.hidden=NO;
        maskDaily.hidden=YES;
        alertType=2;
        
    }
    
}
- (void)ThingYouWantToDoWithString:(NSNotification *)notification{
    // Make sure you have an string set up in your header file or just do NSString *theString = [notification object] if your using ARC, if not allocate and initialize it and then do what I just said
    
    timeLabel.hidden=NO;
    dateLabel.hidden=NO;
    theString = [notification object];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init] ;
    [dateFormat setDateFormat:@"dd-MM-YYYY"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"Date: %@", dateString);
    
    dateLabel.text=[NSString stringWithFormat:@"%@",theString];
   
    
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    
    
    NSDate* now = [NSDate date];
    datePicker.minimumDate=now;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    
    opt=@"";
    self.view.userInteractionEnabled=YES;
    if (clicked==1) {
        name.text=notifname;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init] ;
        [dateFormat setDateFormat:@"dd-MM-YYYY"];
        NSString *dateString = [dateFormat stringFromDate:notifdate];
        NSLog(@"Date: %@", dateString);
        
        dateLabel.text=dateString;
        
        
        
    }
    
    
    
    
    //   NSFileManager *tempfileManager=[NSFileManager defaultManager];
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
	reminderFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"reminderFile.hsa"]];
    
    dicfile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"dicfile.hsa"]];
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:reminderFile])
	{
		_RemaindersArray=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:reminderFile]];
		
	}
	else
	{
		_RemaindersArray=[[NSMutableArray alloc]init];
	}
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dicfile])
	{
		dictionaryArray=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:dicfile]];
     
		
	}
	else
	{
		dictionaryArray=[[NSMutableArray alloc]init];
	}
    
    
    
    
    dictionary=[[NSMutableArray alloc]init];
    
    
    
    
    if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top_Panel.png"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    
    
    
    
    share1=NO;

    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Reminders", @"");
    [label sizeToFit];
    
    
	
	
	
    
    
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveImage = [UIImage imageNamed:@"Save.png"]  ;
    [save setBackgroundImage:saveImage forState:UIControlStateNormal];
    [save addTarget:self action:@selector(saveRemainder)
   forControlEvents:UIControlEventTouchUpInside];
    save.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc]
                                    initWithCustomView:save] autorelease];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@"Back.png"]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    instance = [AppSharedInstance sharedInstance];
	
    savedValue = [[NSUserDefaults standardUserDefaults]
                  integerForKey:@"ApptType"];
    
    
    
    
    self.recordDict=recordDict;
    self.petArray = [instance getPet];
	

    
	
}

-(void)dismissKeyboard {
    [name resignFirstResponder];
}
-(void)saveRemainder
{
    if([name.text length]!=0 &&((once.selected)||(daily.selected)))
    {
        
        
        [dictionaryArray addObject:dictionary];
        [fileMngr saveDatapath:dicfile contentarray:dictionaryArray];
        
        
   
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        NSDate *pickerDate;
        if(alertType==1)
        {
            pickerDate = [self.datePicker date];
        }
        else
        {
            pickerDate = [timePicker date];
        }
        NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                                       fromDate:pickerDate];
        NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
                                                       fromDate:pickerDate];
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
        [dateComps setDay:[dateComponents day]];
        [dateComps setMonth:[dateComponents month]];
        [dateComps setYear:[dateComponents year]];
        [dateComps setHour:[timeComponents hour]];
        // Notification will fire in one minute
        [dateComps setMinute:[timeComponents minute]];
        [dateComps setSecond:[timeComponents second]];
        NSDate *itemDate = [calendar dateFromComponents:dateComps];
        [dateComps release];
        
        
        
        if(clicked==1)
                {
                    
                    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
            UILocalNotification *notif = [notificationArray objectAtIndex:index];
            NSLog(@"Notification deleted at %@",notif.alertBody);
            
            [[UIApplication sharedApplication] cancelLocalNotification:notif];
            
            
        }
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        localNotif.fireDate = itemDate;
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]autorelease]];
        [formatter setTimeStyle:NSDateFormatterFullStyle];
        
                // Notification details
        localNotif.alertBody = [name text];
        // Set the action button
        localNotif.alertAction = @"View";
        
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber = 1;
        
        
        if(alertType==2)
        {
            localNotif.repeatInterval = NSDayCalendarUnit;
            NSLog(@" localNotif.repeatInterval:%i",localNotif.repeatInterval);
        }
        else
        {
            localNotif.repeatInterval = 0;
        }
        
        
        
        UIApplication* app = [UIApplication sharedApplication];
        // this will schedule the notification to fire at the fire date
        [app scheduleLocalNotification:localNotif];
        
        // this will fire the notification right away, it will still also fire at the date we set
        //i hidden here dueto displaying the same remainder for 2 times==>
  [app presentLocalNotificationNow:localNotif];
        // Specify custom data for the notification
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject: localNotif.fireDate forKey:@"date"];
        localNotif.userInfo = infoDict;
        
        // Schedule the notification
        // [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
         [localNotif release];
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
    else
    {
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Enter All The Required Fields."];
        
        
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
        
    }
    
}
-(void)back
{
    
    
    [[self.navigationController.navigationBar viewWithTag:111]removeFromSuperview];
    [[self navigationController] popViewControllerAnimated:YES];
}






- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.recordDict=recordDict;

    [[self.navigationController.navigationBar viewWithTag:121]removeFromSuperview];
    [self.navigationController.navigationBar viewWithTag:111].hidden=NO;
    
    
    
    
}

-(IBAction)setDate
{
    if (clicked==1) {
        dateset=1;
    }
    if(datePicker.hidden==YES)
    {
        self.datePicker.hidden=NO;
    }
    else
    {
        self.datePicker.hidden=YES;
        
    }
    
    NSDate *pickerDate = [self.datePicker date];
    setdate.titleLabel.text=[NSString stringWithFormat:@"%@",pickerDate];
}



#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [petArray count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#if USE_CUSTOM_DRAWING
    const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger BOTTOM_LABEL_TAG = 1002;
    UILabel *topLabel;
    UILabel *bottomLabel;
    UIImageView *i;
#endif
    
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
        
        const CGFloat LABEL_HEIGHT = 40;
        UIImage *image = [UIImage imageNamed:@"imageA.png"];
        
        //
        // Create the label for the top row of text
        //
        topLabel =
        [[[UILabel alloc]initWithFrame:CGRectMake(160,40,aTableView.bounds.size.width -
                                                  image.size.width - 4.0 * cell.indentationWidth
                                                  - indicatorImage.size.width,
                                                  LABEL_HEIGHT)]
         autorelease];
        [cell.contentView addSubview:topLabel];
        
        i=[[UIImageView alloc]initWithFrame:CGRectMake(30,15,80,80)];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"pet_%d.png",[[[petArray objectAtIndex:indexPath.section] objectForKey:@"pk"] intValue]]];
        NSData *imageData = [NSData dataWithContentsOfFile:path];
        
        i.image=[UIImage imageWithData:imageData];
        [cell.contentView addSubview:i];
        
        //
        // Configure the properties for the text that are the same on every row
        //
        topLabel.tag = TOP_LABEL_TAG;
        topLabel.backgroundColor = [UIColor clearColor];
        topLabel.textColor = [UIColor colorWithRed:0.6 green:0.4 blue:0.2 alpha:1.0];
        topLabel.highlightedTextColor = [UIColor redColor];
        topLabel.font = [UIFont systemFontOfSize:40];
        
        //
        // Create the label for the top row of text
        //
        bottomLabel =
        [[[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     100,
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
        bottomLabel.textColor = [UIColor colorWithRed:0.6 green:0.4 blue:0.2 alpha:1.0];
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
    
    
    topLabel.text =  [[petArray objectAtIndex:indexPath.section] objectForKey:@"name"];
    //bottomLabel.text =@"raja" ;
    
    
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
    
    
    cell.textLabel.text=@"add";
    cell.textLabel.textColor=[UIColor greenColor];
    // cell.textLabel.center=CGPointMake(cell.textLabel.center.x+100, cell.textLabel.center.y);
    //
    // Here I set an image based on the row. This is just to have something
    // colorful to show on each row.
    //
    
    
    
    
#else
    cell.text = [NSString stringWithFormat:@"Cell at row %ld.", [indexPath row]];
#endif
    
    return cell;
}




- (void)setData:(NSDictionary *)rowData
{
    
}

#pragma mark -
#pragma mark Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
      
    if(cell.textLabel.text==@"add")
    {
        
        NSString*str =  [[petArray objectAtIndex:indexPath.section] objectForKey:@"name"];
        
        [dictionary addObject:str];
        
        cell.textLabel.text=@"remove";
        cell.textLabel.textColor=[UIColor redColor];
   
        
        
    }
    else if(cell.textLabel.text==@"remove")
    {
        NSString*str =  [[petArray objectAtIndex:indexPath.section] objectForKey:@"name"];
        [dictionary removeObject:str];
        cell.textLabel.text=@"add";
        
        cell.textLabel.textColor=[UIColor greenColor];
        
    }
    
    
    if (cell.accessoryType == UITableViewCellAccessoryNone)		{
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else if (cell.accessoryType == UITableViewCellAccessoryCheckmark)	{
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
}






#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}

- (IBAction)changeDateInLabel:(id)sender
{
	//Use NSDateFormatter to write out the date in a friendly format
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
	NSString*str = [NSString stringWithFormat:@"%@",
                    [df stringFromDate:datePicker.date]];
    
    //NSLog(@"RAja");
	[df release];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"  h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:datePicker.date];
    NSString*str2=timetofill;
    
    NSString *coordinates = [NSString stringWithFormat:@"%@ %@", str, str2];
    dateLabel.text=coordinates;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(datePicker.hidden==NO)
    {
        datePicker.hidden=YES;
        
       
    }
    
    if(timePicker.hidden==NO)
    {
        timePicker.hidden=YES;
            }
    
     
    
  }




- (void)dealloc {
	
    [datePicker release];
	[super dealloc];
}





@end

