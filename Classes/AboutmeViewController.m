//
//  AboutmeViewController.m
//  PetLove
//
//  Created by CS Soon on 4/8/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//

#import "AboutmeViewController.h"
#import "AppSharedInstance.h"
#import "NoteViewController.h"
#import "AudioFilesCOntroller.h"
#import "JSON/JSON.h"
#import "SVSegmentedControl.h"
#import "JSON/JSON.h"
#import <QuartzCore/QuartzCore.h>
#import "BlockAlertView.h"
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1


@implementation AboutmeViewController
@synthesize recordDict;
@synthesize dobPicker;
@synthesize datePicker;
@synthesize total;
@synthesize datePicker1;
AppSharedInstance *instance;


- (void)viewWillAppear:(BOOL)animated {
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    [super viewWillAppear:animated];
    iButton.titleLabel.text=@"No image";
    [iButton setImage:[UIImage imageNamed:@"noimage.png"] forState:UIControlStateNormal];
    
      
    
    
    ////NSLog(@"RAJATYPE:%@",type);
    
    [myTable reloadData];
    [myTable1 reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView.tag==222)
    {
        return [_onceTime count];
    }
    else
    {
        return [_TimeArray count];
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#if USE_CUSTOM_DRAWING
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger BOTTOM_LABEL_TAG = 1002;
	UILabel *topLabel;
	UILabel *bottomLabel;
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
		
		const CGFloat LABEL_HEIGHT = 20;
		UIImage *image = [UIImage imageNamed:@"imageA.png"];
        
		//
		// Create the label for the top row of text
		//
		topLabel =
        [[[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     100,
                     
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
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
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
        bottomLabel.center=CGPointMake(280, 22);
		[cell.contentView addSubview:bottomLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		bottomLabel.tag = BOTTOM_LABEL_TAG;
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		bottomLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
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
	
    
    
    
    
    

    if(aTableView.tag==222)
    {
        bottomLabel.text =[_onceTime objectAtIndex:indexPath.row];
    }
    else
    {
        bottomLabel.text =[_TimeArray objectAtIndex:indexPath.row];
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
	
#endif
	
	return cell;
}




#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}






-(IBAction)changeTime:(id)sender
{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    if(timepicker.hidden==NO)
    {
               
    }
    
}


-(void)aMethod1
{
    
    setTimePicker.hidden=YES;
    NSLocale *usLocale = [[[NSLocale alloc]
                           initWithLocaleIdentifier:@"en_US"] autorelease];
    
    
    
    
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:setTimePicker.date];
    tim.text=timetofill;
    
    
    [_onceTime addObject:timetofill];
    [myTable1 reloadData];
    
    
    
}



-(void)aMethod
{
    
    timepicker.hidden=YES;
    NSLocale *usLocale = [[[NSLocale alloc]
                           initWithLocaleIdentifier:@"en_US"] autorelease];
    
    NSDate *pickerDate = [timepicker date];
  
    NSString *selectionString = [[NSString alloc]
                                 initWithFormat:@"%@",
                                 [pickerDate descriptionWithLocale:usLocale]];
    NSString *dateString = selectionString;
 
    
    
    
    
    
    [_TimeArray addObject:dateString];
    [myTable reloadData];
}
-(IBAction)Morning1:(id)sender
{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    if(timepicker.hidden==YES)
    {
        timepicker.hidden=NO;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(aMethod)
         forControlEvents:UIControlEventTouchDown];
     
        [button setImage:[UIImage imageNamed:@"Add_Time.png"] forState:UIControlStateNormal];
        button.frame = CGRectMake(490.0, 85.0, 140.0, 40.0);
        [timepicker addSubview:button];
        
        
    }
    
}








-(IBAction)removeMorning
{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    if (myTable.editing)
    {
		myTable.editing=NO;
    }
    else
    {
        myTable.editing=YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        if(tableView.tag==222)
        {
            [_onceTime removeObjectAtIndex:indexPath.section];
            
            
            [myTable1 reloadData];
            if ([_onceTime count] > 0)
            {
                
            }
            else{
              
            }
        }
        else{
            [_TimeArray removeObjectAtIndex:indexPath.section];
            
            
            [myTable reloadData];
            if ([_TimeArray count] > 0)
            {
                
            }
            else{
               
            }
            
        }
		
	}
	
}


-(void)uploadimage
{
    UIImage *image = [UIImage imageNamed:@"AddAftn.png"];
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:8080/imgupload?filename=myimage"];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    
    [request addValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[NSData dataWithData:data]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event touchesForView:self.view] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    
    datePicker1.minimumDate=datePicker.date;
    if(picker1)
    {
        
        
        [picker1 removeFromSuperview];
        
        picker1=nil;
    }
    
    
    if(setTimePicker.hidden==NO)
    {
        setTimePicker.hidden=YES;
                
        
    
        
    }
    
    if(datePicker.hidden==NO)
    {
        datePicker.hidden=YES;
           }
    if(datePicker1.hidden==NO)
    {
        datePicker1.hidden=YES;
                
    }
    
        
    
    
    
}


- (IBAction)changefromTime:(id)sender
{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    //  setTimePicker.hidden=YES;
    
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    NSString *timetofill = [outputFormatter stringFromDate:setTimePicker.date];
   
    
    
    
}

- (IBAction)changefromdate:(id)sender
{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    datePicker1.minimumDate=datePicker.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
	fromd.text = [NSString stringWithFormat:@"%@",
                  [df stringFromDate:datePicker.date]];
	[df release];
    
    
}
- (IBAction)changeTodate:(id)sender
{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    datePicker1.minimumDate=datePicker.date;
 
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    tod.text = [NSString stringWithFormat:@"%@",
                [df stringFromDate:datePicker1.date]];
    [df release];
    
    UIPickerView*d= sender;

}

-(IBAction)setTimer:(id)sender
{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    datePicker1.hidden=YES;
    datePicker.hidden=YES;
    if(setTimePicker.hidden==YES)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(aMethod1)
         forControlEvents:UIControlEventTouchDown];
                [button setImage:[UIImage imageNamed:@"Add_Time.png"] forState:UIControlStateNormal];
        button.frame = CGRectMake(490.0, 85.0, 140.0, 40.0);
        [setTimePicker addSubview:button];
        
        setTimePicker.hidden=NO;
    }
    else
    {
        setTimePicker.hidden=YES;
    }
}

-(IBAction)setFromDate
{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    datePicker1.hidden=YES;
    setTimePicker.hidden=YES;
    if(datePicker.hidden==YES)
    {
        self.datePicker.hidden=NO;
    }
    else
    {
        self.datePicker.hidden=YES;
    }
}


-(IBAction)setToDate

{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    datePicker.hidden=YES;
    setTimePicker.hidden=YES;
    if(datePicker1.hidden==YES)
    {
        self.datePicker1.hidden=NO;
    }
    else
    {
        self.datePicker1.hidden=YES;
    }
}

-(IBAction)takePhoto {
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    
    
	UIActionSheet *actionSheet;
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
		actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose Existing Photo",@"Take Photo",nil];
	else
		actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose Existing Photo",nil];
	actionSheet.delegate =self;
	[actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[actionSheet showInView:[self view]];
	[actionSheet release];
}

//Actionsheet delegate return and act on
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UIImagePickerControllerSourceType sourceType;
	// Set the source type according to the user's selection
	switch(buttonIndex)
	{
		case 0:
			if(share1==YES)
			{
				share1=NO;
                
				return;
			}
			else {
				sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
			}
            
			break;
		case 1:
			if(share1==YES)
			{
				return;
			}
			else {
				if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
					sourceType = UIImagePickerControllerSourceTypeCamera;
				else
					return;
			}
            
			
			break;
		default:
			return;
	}
	
	// Set up the image picker
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = sourceType;
    popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    [popover presentPopoverFromRect:CGRectMake(250.0,150.0,200.0,90.0)
                             inView:self.view
           permittedArrowDirections:UIPopoverArrowDirectionAny
                           animated:YES];
    [imagePicker release];

    
    
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self saveImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
    buttonImage =  [info objectForKey:@"UIImagePickerControllerOriginalImage"];

    
	[iButton setImage:buttonImage forState:UIControlStateNormal];
    
    
    [popover dismissPopoverAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}

-(void)saveImage:(UIImage *)img2{
   
 
	UIImage *thumbImage =[img2 resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(90, 90) interpolationQuality:kCGInterpolationHigh];
	//thumbImage = [thumbImage croppedImage:CGRectMake(0,0,90,90)];
	
	NSString *filename = [NSString stringWithFormat:@"pet_%d.png",[[recordDict objectForKey:@"pk"] intValue]];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	[UIImagePNGRepresentation(thumbImage) writeToFile:[documentsDirectory stringByAppendingPathComponent:filename] atomically:YES];
 
    
    
}

- (IBAction)checkboxButton:(UIButton *)button{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    
    if( !button.selected)
    {
        [button setSelected:YES];
        [aButton1 setSelected:NO];
        [aButton2 setSelected:NO];
        type=@"Once";
    }
}


- (IBAction)checkboxButton1:(UIButton *)button{
    
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    if( !button.selected)
    {
        [button setSelected:YES];
        [aButton setSelected:NO];
        [aButton2 setSelected:NO];
        type=@"Daily";
        
    }
}

- (IBAction)checkboxButton2:(UIButton *)button{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    
    if( !button.selected)
    {
        [button setSelected:YES];
        [aButton1 setSelected:NO];
        [aButton setSelected:NO];
        type=@"Couple";
    }
}


-(void)back
{
    
    [[self navigationController] popViewControllerAnimated:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    datePicker.minimumDate=[NSDate date];
   datePicker1.minimumDate=[NSDate date];
    [super viewDidLoad];
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    datePicker1.minimumDate=datePicker.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
	fromd.text = [NSString stringWithFormat:@"%@",
                  [df stringFromDate:datePicker.date]];
	[df release];
    datePicker.minimumDate=[NSDate date];
    datePicker1.minimumDate=[NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:setTimePicker.date];
    tim.text=timetofill;
    
    
   
    
    v.hidden=YES;
    v1.hidden=YES;
    v.userInteractionEnabled=NO;
    v1.userInteractionEnabled=NO;
    _TimeArray=[[NSMutableArray alloc]init];
    _onceTime=[[NSMutableArray alloc]init];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.editing=YES;
    
    myTable1.backgroundColor = [UIColor clearColor];
    myTable1.editing=YES;
    self.view.userInteractionEnabled=YES;
    
    type=@"";
    k= [[NSUserDefaults standardUserDefaults]
        integerForKey:@"select"];
    share1=NO;
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@"Back.png"]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString *documentsDirectory = [paths objectAtIndex:0];
	

    
NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"pet_%d.png",[[recordDict objectForKey:@"pk"] intValue]]];
    
 NSData *imageData = [NSData dataWithContentsOfFile:path];
    
UIImage *buttonImage1 = [UIImage imageWithData:imageData];
    
    
    
 buttonImage1 = [buttonImage resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(85, 76) interpolationQuality:kCGInterpolationHigh];
    
    UIImageWriteToSavedPhotosAlbum(buttonImage,self,nil,nil);
    [iButton setImage:buttonImage forState:UIControlStateNormal];

    
    
    
    
    UIImage *noteImage=[UIImage imageNamed:@"Notes1.png"];
    UIButton*Notes = [UIButton buttonWithType:UIButtonTypeCustom];
	[Notes setImage:noteImage forState:UIControlStateNormal];
	Notes.frame = CGRectMake(175.0, 550.0, 140, 54);
	[Notes addTarget:self action:@selector(Notes) forControlEvents:UIControlEventTouchUpInside];
    //  [self.view addSubview:Notes];
    
    UIImage *AudioImage=[UIImage imageNamed:@"Audio1.png"];
    UIButton*Audio = [UIButton buttonWithType:UIButtonTypeCustom];
	[Audio setImage:AudioImage forState:UIControlStateNormal];
	Audio.frame = CGRectMake(480, 550.0, 140, 54);
	[Audio addTarget:self action:@selector(Audio) forControlEvents:UIControlEventTouchUpInside];
    //   [self.view addSubview:Audio];
    
    
    
	self.dobPicker = [[UIDatePicker alloc] init];
	[self.dobPicker setDatePickerMode:UIDatePickerModeDate];
	[self.dobPicker addTarget:self action:@selector(updateDate) forControlEvents:UIControlEventValueChanged];
    
	
    
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    
    
    
    
    
    
    
    
    
	instance = [AppSharedInstance sharedInstance];
	if ([recordDict count]>0) {
		[self populateField];
        [self.navigationController.navigationBar viewWithTag:121].hidden=NO;
        //	self.title = @"Medication Info         ";
        
        ////NSLog(@"%@",recordDict);
        label.text = NSLocalizedString(@"Medication Info", @"");
	}
	else {
		recordDict = [[NSMutableDictionary alloc] init];
        [self.navigationController.navigationBar viewWithTag:121].hidden=YES;
		//self.title = @"Add Medication ";
        label.text = NSLocalizedString(@"Add Medication", @"");
	}
    
    
    
    
    if ([recordDict count]>0)
    {
        
        
        NSString *str=[recordDict objectForKey:@"name"];
        
        NSString *str1=[recordDict objectForKey:@"type"];
        
        type=[recordDict objectForKey:@"type"];
        NSMutableArray*m=[[NSUserDefaults standardUserDefaults]objectForKey:str];
        
        // _TimeArray=[m copy];
        _TimeArray=[[NSMutableArray alloc]initWithArray:m];
        
        NSString *str11=[NSString stringWithFormat:@"once%@",[recordDict objectForKey:@"name"]];
        //NSLog(@"SRTR!!:%@",str11);
        
        NSMutableArray*m1=[[NSUserDefaults standardUserDefaults]objectForKey:str11];
        _onceTime=[[NSMutableArray alloc]initWithArray:m1];
        SVSegmentedControl*  redSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Once", @"Daily", nil]];
        
        redSC.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 264);
        redSC.crossFadeLabelsOnDrag = YES;
        
        redSC.thumb.tintColor = [UIColor redColor];
        redSC.thumb.textShadowColor = [UIColor colorWithWhite:1 alpha:0.5];
        redSC.thumb.textShadowOffset = CGSizeMake(0, 1);
        redSC. font = [UIFont boldSystemFontOfSize:20];
        redSC.height=50;
        [redSC addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        // redSC.selectedIndex=1;
        [self.view addSubview:redSC];
        redSC.center = CGPointMake(384, 380);
        redSC.tag = 2;
        
    }
    else
    {
        
             _TimeArray=[[NSMutableArray alloc]init];
        _onceTime=[[NSMutableArray alloc]init];
        type=@"Once";
        [[self.view viewWithTag:2] removeFromSuperview];
        SVSegmentedControl*  redSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Once", @"Daily", nil]];
        
        redSC.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 264);
        redSC.crossFadeLabelsOnDrag = YES;
        
        redSC.thumb.tintColor =[UIColor redColor];
        redSC.thumb.textShadowColor = [UIColor colorWithWhite:1 alpha:0.5];
        redSC.thumb.textShadowOffset = CGSizeMake(0, 1);
        redSC. font = [UIFont boldSystemFontOfSize:20];
        redSC.height=50;
        
        // redSC.selectedIndex=1;
        [self.view addSubview:redSC];
        redSC.center = CGPointMake(384, 380);
        redSC.tag = 2;
        [redSC addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        
        v.hidden=NO;
        v.userInteractionEnabled=YES;
    }
    self.navigationItem.titleView = label;
    [label sizeToFit];
	
    
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveImage = [UIImage imageNamed:@"Save.png"]  ;
    [save setBackgroundImage:saveImage forState:UIControlStateNormal];
    [save addTarget:self action:@selector(savePet)
   forControlEvents:UIControlEventTouchUpInside];
    save.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc]
                                    initWithCustomView:save] autorelease];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
	[pageScroll setContentSize:CGSizeMake(320, 600)];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSDate *today = [NSDate date];
    
    
    
    int savedValue = [[NSUserDefaults standardUserDefaults]
                      integerForKey:@"ApptType"];
    if(savedValue==5)
    {
        [self share];
    }
    
    
    
	
	if ([dob.text isEqualToString:@""]) {
		[formatter setDateFormat:@"MMMM dd, yyyy"];
		NSString *dateStr = [formatter stringFromDate:today];
		dob.text = dateStr;
		[formatter setDateFormat:@"MM/dd/yyyy"];
		[recordDict setValue:[formatter stringFromDate:today] forKey:@"tod"];
		[formatter release];
		[self updateDate];
	}
    
    
    
    
    
}


-(void)Notes
{
    NoteViewController *noteViewController = [[NoteViewController alloc] initWithNibName:@"NoteView" bundle:nil];
	noteViewController.recordDict = recordDict;
    noteViewController.recordDict = [recordDict objectForKey:@"pk"];
	[self.navigationController pushViewController:noteViewController animated:YES];
	[noteViewController release];
}
- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl
{
    [(UITextField*)[self.view viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:6] resignFirstResponder];
    if(segmentedControl.selectedIndex==0)
    {
        
        type=@"Once";
        
        v.hidden=NO;
        v.userInteractionEnabled=YES;
        v1.userInteractionEnabled=NO;
        v1.hidden=YES;
        
    }
    else if(segmentedControl.selectedIndex==1)
    {
        type=@"Daily";
        
        v.hidden=YES;
        v.userInteractionEnabled=NO;
        v1.userInteractionEnabled=YES;
        v1.hidden=NO;
    }
    
    
}
-(void)Audio
{
    AudioFilesCOntroller *noteViewController = [[AudioFilesCOntroller alloc] initWithNibName:@"AudioFilesCOntroller" bundle:nil];
	noteViewController.recordDict = recordDict;
    noteViewController.recordDict = [recordDict objectForKey:@"pk"];
	[self.navigationController pushViewController:noteViewController animated:YES];
	[noteViewController release];
}
-(void)share
{
	share1=YES;
	UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:@"Share"
                            delegate:self
                            cancelButtonTitle:@"Cancel"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"Facebook", @"Twitter", nil];
	sheet.delegate=self;
	
	[sheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[sheet showInView:[self view]];
	[sheet release];
	
	
}

- (void)populateField
{
    
    
    NSString *s=[recordDict objectForKey:@"type"];
    
    
	name.text = [recordDict objectForKey:@"name"];
    self.title = name.text;
    if([type isEqualToString:@"Once"])
    {
        
        NSDate* now = [NSDate date];
        NSString *n=[NSString stringWithFormat:@"%@",now];
        
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"d:MM:yyy"];
        
        NSString *timetofill = [outputFormatter stringFromDate:now];
        n=timetofill;
        fromd.text=n;
        tod.text=@"ToDate";
        tim.text=@"SetTime";
    }
    else
    {
        
        fromd.text = [recordDict objectForKey:@"fromd"];
        tod.text = [recordDict objectForKey:@"tod"];
        tim.text = [recordDict objectForKey:@"notes"];
    }
    
    
    if([s isEqualToString:@"Once"])
    {
        
        v.hidden=NO;
        v1.hidden=YES;
        
        v.userInteractionEnabled=YES;
        v1.userInteractionEnabled=NO;
    }
    else if([s isEqualToString:@"Daily"])
    {
        
        v1.hidden=NO;
        v.hidden=YES;
        
        v.userInteractionEnabled=NO;
        v1.userInteractionEnabled=YES;
    }
    
    
	akc.text = [recordDict objectForKey:@"akc"];
	notes.text = [recordDict objectForKey:@"notes"];
}

- (NSString *)calculateAge {
	NSDate *startDate = self.dobPicker.date;
	NSDate *endDate = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	unsigned int unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate options:0];
	int month = [components month];
	int years= [components year];
	[gregorian release];
	
	NSString *ageStr=@"";
	if (years > 0)
		ageStr = [NSString stringWithFormat:@"%d years ",years];
	ageStr = [ageStr stringByAppendingString:[NSString stringWithFormat:@"%d months",month]];
	return ageStr;
}

- (void)updateDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd/yyyy"];
	[recordDict setObject:[formatter stringFromDate:self.dobPicker.date] forKey:@"tod"];
	[formatter setDateFormat:@"MMM dd, yyyy"];
	dob.text = [formatter stringFromDate:self.dobPicker.date];
	[formatter release];
	age.text = [self calculateAge];
}



-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    
    
    
    
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&medicinename=%@&medicinedirection=%@&%@=%@",firstEntity,value1,name.text,akc.text,secondEntity,value2];
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/medicineresponce.php?service=medinsert"];
    
    
    
    //////NSLog(post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
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



-(void)setLocalNotifi
{
    
    for(int i=0; i<[_TimeArray count];i++)
    {
        ////NSLog(@"RAJAREmain");
        NSString *dateString = [NSString stringWithFormat:@"%@",[_TimeArray objectAtIndex:i]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd  hh:mm"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:dateString];
        [dateFormatter release];
        
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        localNotif.fireDate = dateFromString;
        localNotif.timeZone = [NSTimeZone systemTimeZone];
        localNotif.alertBody = [NSString stringWithFormat:@"%@",name.text ];
        localNotif.alertAction = @"View";
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber = 0;
        NSString*s=[NSString stringWithFormat:@"%@",type];
        if([s isEqualToString:@"Daily"])
        {
            localNotif.repeatInterval = NSDayCalendarUnit;
        }
        else
        {
            localNotif.repeatInterval = 0;
        }
        
  
        UIApplication* app = [UIApplication sharedApplication];
                // this will schedule the notification to fire at the fire date
                [app scheduleLocalNotification:localNotif];
        [localNotif release];
    }
    
}

- (void)savePet {
    
    [self saveImage:buttonImage];

    
       [recordDict setObject:type forKey:@"type"];
    //[self saveImage:buttonImage];
      
    NSString *str=name.text;
    [[NSUserDefaults standardUserDefaults]setObject:_TimeArray forKey:str];
    
    NSString *str1=[NSString stringWithFormat:@"once%@",name.text];
    //NSLog(@"ONCEKK:%@",str1);
    [[NSUserDefaults standardUserDefaults]setObject:_onceTime forKey:str1];
    
    
    NSMutableArray*m=[[NSUserDefaults standardUserDefaults]objectForKey:str];
    [recordDict setObject:fromd.text forKey:@"fromd"];
    [recordDict setObject:tod.text forKey:@"tod"];
    [recordDict setObject:tim.text forKey:@"notes"];
    // }
    
    //[self saveImage:buttonImage];

    
    
    
    ////NSLog(@"DGD");
    
    
	[self dismissKeyboard];
	if ([self checkField])
    {
		if ([[recordDict objectForKey:@"pk"] intValue] > 0)
        {
			[instance updatePet:recordDict];
            ////NSLog(@"updateraja:%i",[[recordDict objectForKey:@"pk"] intValue]);
            [self.navigationController popViewControllerAnimated:YES];
        }
		else
        {
            
            
            NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
            
            NSString *resultResponse=[self HttpPostEntityFirst:@"userid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
            
           
            
            NSError *error;
            
            SBJSON *json = [[SBJSON new] autorelease];
            NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
            
         
            if (luckyNumbers == nil)
            {
                
                ////NSLog(@"RAJA");
                
            }
            else
            {
                
                NSDictionary* menu = [luckyNumbers objectForKey:@"serviceresponse"];
        
                
                
                
                if ([[menu objectForKey:@"servicename"] isEqualToString:@"Medicine Details"])
                {
                    if ([[menu objectForKey:@"message"] isEqualToString:@"Already Exist"])
                    {
                        
                        
                        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Medicine Already Exist."];
                        
                        [alert setDestructiveButtonWithTitle:@"x" block:nil];
                        [alert show];

                    }
                    else
                    {
                        
                    }
                }
            }
            
            
            
            
            [instance insertPet:recordDict];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
	}
	
}










-(BOOL)checkField {
    NSString *msg=@"";
	if ([name.text length] == 0)
		msg = @"Medicine name cannot be empty";
	
    if ([msg length] > 0) {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Medicine Name cannot be Empty."];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];

        return NO;
    }
    else
        return YES;
    
}

- (BOOL) textFieldShouldBeginEditing: (UITextField*) textField  {
	
	if (textField.tag == 3) {
		[currentField resignFirstResponder];
		[self showDatePicker];
		return NO;
	} else
		if (textField.tag == 4)
			return NO;
		else
			[self dismissDatePicker];
	return YES;
	
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	currentField=textField;
	[self moveUp:textField];
}

// when DONE key on keyboard is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
	if (textField.tag == 1)
		[recordDict setObject:textField.text forKey:@"name"];
	else
		if (textField.tag == 2)
			[recordDict setObject:textField.text forKey:@"fromd"];
		else
			if (textField.tag == 3)
				[recordDict setObject:textField.text forKey:@"tod"];
			else
				if (textField.tag == 5)
					//[recordDict setObject:textField.text forKey:@"type"];
                    NSLog(@"");
				else
					if (textField.tag == 6)
						[recordDict setObject:textField.text forKey:@"akc"];
    
    [recordDict setObject:type forKey:@"type"];
    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    [recordDict setObject:UserId forKey:@"patid"];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
	currentField=textView;
	[self moveUp2:textView];
}

// when user end edit the text field, move the textview down and header down
- (void)textViewDidEndEditing:(UITextView *)textView {
	[recordDict setObject:textView.text forKey:@"notes"];
}

- (void)moveUp:(UITextField *)textField {
	UIScrollView *v = pageScroll;
	
	CGRect rc = [textField bounds];
	
    rc = [textField convertRect:rc toView:v];
	
	rc.origin.x = 0 ;
	rc.origin.y -= 50 ;
	
	rc.size.height = 300;
	[pageScroll scrollRectToVisible:rc animated:YES];
}

- (void)moveUp2:(UITextView *)textView {
	UIScrollView *v = pageScroll;
	
	CGRect rc = [textView bounds];
	
    rc = [textView convertRect:rc toView:v];
	
	rc.origin.x = 0 ;
	rc.origin.y -= 50 ;
	
	rc.size.height = 300;
	[pageScroll scrollRectToVisible:rc animated:YES];
}

- (void) showDatePicker {
	[self.view addSubview:self.dobPicker];
	CGRect frames = self.dobPicker.frame;
	frames.origin.y = CGRectGetMaxY(self.view.bounds);
	self.dobPicker.frame = frames;
	[UIView beginAnimations:nil context:nil];
	frames.origin.y -= CGRectGetHeight(self.dobPicker.bounds);
	self.dobPicker.frame = frames;
	[UIView commitAnimations];
}

- (void) dismissDatePicker {
	CGRect frames = self.dobPicker.frame;
	[UIView beginAnimations:nil context:nil];
	
	// Set the callback to remove the view when animated away
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(removeDatePickerFromParent)];
	
	frames.origin.y = CGRectGetMaxY(self.view.bounds);
	self.dobPicker.frame = frames;
	[UIView commitAnimations];
	
}

// remove the date picker from superview when animation is done
- (void) removeDatePickerFromParent {
	[self.dobPicker removeFromSuperview];
}

- (IBAction) dismissKeyboard {
	[currentField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
    
    [super dealloc];
}


@end


