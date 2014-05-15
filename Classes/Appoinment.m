//
//  RootViewController.m
//  PetLove
//
//  Created by CS Soon on 4/17/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//

#import "Appoinment.h"
#import "AppSharedInstance.h"
#import "ListCell.h"
#import "AboutmeViewController.h"
#import "ADLivelyTableView.h"
#import "Addremainder.h"
#import "fileMngr.h"
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
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1

@implementation UINavigationBar (CustomImage)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"Top_Panel.png"];
    [image drawInRect:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height)];
}

@end
@implementation Appoinment




AppSharedInstance *instance;


#pragma mark -
#pragma mark View lifecycle



-(IBAction)Addremainder
{
    
}
- (void)viewDidLoad {
    
    UIImageView *i=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BG.jpg"]];
   
    [super viewDidLoad];
    [appload setImage:[UIImage imageNamed:@"Appointments2.png"]forState:UIControlStateNormal];
    
    
       if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top_Panel.png"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    ADLivelyTableView * livelyTableView = (ADLivelyTableView *)myTable;
    livelyTableView.initialCellTransformBlock = ADLivelyTransformFan;
   
    share1=NO;
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Appointments", @"");
    [label sizeToFit];
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@" "]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
   
    
      myTable.backgroundColor = [UIColor clearColor];
    self.parentViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.2 blue:0.5 alpha:0.7];
    
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
    
    
        if([_AppDArr count]>0)
    {
        NSLog(@"in DidLoad text wont print %d",[_AppDArr count]);
        nolab.hidden=YES;
        nolab.text=@" ";
    }
    else
    {
        NSLog(@"in didload text print %d",[_AppDArr count]);
        nolab.hidden=NO;
        nolab.text=@"You Can View Your Appointments Here.";
    }
   	myTable.rowHeight=100;
	myTable.separatorColor = [UIColor clearColor];
	
    
	[myTable reloadData];
    }

- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl 
{
    if(segmentedControl.selectedIndex==0)
    {
         }
    else if(segmentedControl.selectedIndex==1)
    {
              
    }
       
    
}

-(IBAction)apptomedi
{
    
    RootViewController*new = [[RootViewController alloc] initWithNibName:@"roor" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [RootViewController release];
    
}
-(IBAction)apptorem
{
    
    Cremainder*new = [[Cremainder alloc] initWithNibName:@"Cremainder" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Cremainder release];
}
-(IBAction)apptoass
{
    
    Assessment*new = [[Assessment alloc] initWithNibName:@"Assessment" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Assessment release];
}
-(IBAction)apptohome
{
    
    Welcome*new = [[Welcome alloc] initWithNibName:@"Welcome" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Welcome release];
}
-(IBAction)apptocom
{
    
    Communicate*new = [[Communicate alloc] initWithNibName:@"Communicate" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Communicate release];
}
-(IBAction)apptoset
{
    
    NewViewController*new = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [NewViewController release];
}

-(void)back
{
    
}

- (void)edit_Clicked {
	if (myTable.editing) 
    {
		myTable.editing=NO;
                
        UIImage *buttonImage = [UIImage imageNamed:@"Edit.png"];
          [(UIButton*)[self.navigationController.navigationBar viewWithTag:111] setImage:buttonImage forState:UIControlStateNormal];
        
        
	}		
	else {
		myTable.editing=YES;
        UIImage *buttonImage = [UIImage imageNamed:@"Done.png"];
    
        [(UIButton*)[self.navigationController.navigationBar viewWithTag:111] setImage:buttonImage forState:UIControlStateNormal];
		
	}
	[myTable reloadData];
}



- (void)viewWillAppear:(BOOL)animated {
   
    [super viewWillAppear:animated];
    
    	
    
    
    
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

    
    
    
      
    
    

     [[self.navigationController.navigationBar viewWithTag:121]removeFromSuperview];
      [self.navigationController.navigationBar viewWithTag:111].hidden=NO;
	if([_AppDArr count]>0)
    {
        NSLog(@"in view will appear textwont print %d",[_AppDArr count]);
        nolab.hidden=YES;
        nolab.text=@" ";
    }
    else
    {
        NSLog(@"view will appear text print %d",[_AppDArr count]);
        nolab.hidden=NO;
        nolab.text=@"You Can View Your Appointments Here.";
    }
    
	[myTable reloadData];
   

    
    

        
    
    
}





#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	i=_AppDArr;
    return [_AppDArr count];
    
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
		topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]+2];
        
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
	
    
    

    
    bottomLabel.text=[_AppDArr objectAtIndex:indexPath.row];
     topLabel.text=[_AppNArr objectAtIndex:indexPath.row];
    
	
	
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [_AppNArr removeObjectAtIndex:indexPath.row];
        [_AppDArr removeObjectAtIndex:indexPath.row];
        [fileMngr saveDatapath:appoNFile  contentarray:_AppNArr];
        
        [fileMngr saveDatapath:appoFile contentarray:_AppDArr];
     
        [myTable reloadData];
        [self viewWillAppear:YES];
      
        
        if(([_AppDArr count]>0)||([_AppNArr count]>0))
        {
            nolab.hidden=YES;
            nolab.text=@" ";
        }
        else
        {
            nolab.hidden=NO;
            nolab.text=@"You Can View Your Appointments Here.";
		}
    }
    else{
		
    }
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
      
    if(savedValue==5)
    {
       
        [self share];
        
      
    }

}




#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
} 







- (void)dealloc {
	[petArray release];
	[super dealloc];
}





@end

