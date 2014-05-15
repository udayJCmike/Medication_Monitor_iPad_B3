//
//  RootViewController.m
//  PetLove
//
//  Created by CS Soon on 4/17/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//

#import "RootViewController.h"
#import "AppSharedInstance.h"
#import "ListCell.h"
#import "AboutmeViewController.h"
#import "ADLivelyTableView.h"
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


@implementation UINavigationBar (CustomImage)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"Top_Panel.png"];
    [image drawInRect:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height)];
}

@end
@implementation RootViewController
@synthesize petArray;
@synthesize recordDict;
@synthesize countval;
AppSharedInstance *instance;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    
    UIImageView *i=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BG.jpg"]];
    
    
    [mediload setImage:[UIImage imageNamed:@"Medications2.png"]forState:UIControlStateNormal];
    
    [super viewDidLoad];
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
    ADLivelyTableView * livelyTableView = (ADLivelyTableView *)myTable;
    livelyTableView.initialCellTransformBlock = ADLivelyTransformFan;
   

    share1=NO;
	  // self.title = @"Medication Monitor";
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Medications", @"");
    [label sizeToFit];
    
    
	myTable.rowHeight=110;
	myTable.separatorColor = [UIColor clearColor];
	instance = [AppSharedInstance sharedInstance];
	
     savedValue = [[NSUserDefaults standardUserDefaults]
                      integerForKey:@"ApptType"];
    
    savedValue=1;
    if(savedValue!=5)
    {
        

    
    UIButton *save1 = [UIButton buttonWithType:UIButtonTypeCustom];  
          save1.frame = CGRectMake(0, 0, 135, 40);
    UIImage *saveImage1 = [UIImage imageNamed:@"addmedicationnew.png"]  ;
    [save1 setBackgroundImage:saveImage1 forState:UIControlStateNormal];  
    [save1 addTarget:self action:@selector(addPet)  
   forControlEvents:UIControlEventTouchUpInside];  
  
    UIBarButtonItem *saveButton1 = [[[UIBarButtonItem alloc]  
                                    initWithCustomView:save1] autorelease];  
     
    self.navigationItem.rightBarButtonItem = saveButton1;
    }
    
    
    
    
    
	
}
//To Display TAB BARS in viewcontrollers

-(IBAction)meditohome
{				
    
     Welcome* new = [[Welcome alloc] initWithNibName:@"Welcome" bundle:nil];
    new.first=0;
    [self.navigationController pushViewController:new animated:NO];
    [Welcome release];
    
}
-(IBAction)meditorem
{
    
    Cremainder*new = [[Cremainder alloc] initWithNibName:@"Cremainder" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Cremainder release];
}
-(IBAction)meditoass
{
    
    Assessment*new = [[Assessment alloc] initWithNibName:@"Assessment" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Assessment release];
}
-(IBAction)meditoapp
{
    
    Appoinment*new = [[Appoinment alloc] initWithNibName:@"Appoinment" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Appoinment release];
}
-(IBAction)meditocom
{
    
    Communicate*new = [[Communicate alloc] initWithNibName:@"Communicate" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Communicate release];
}
-(IBAction)meditoset
{
    
    NewViewController*new = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [NewViewController release];
}

-(void)back
{
   
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [[self.navigationController.navigationBar viewWithTag:121]removeFromSuperview];
      [self.navigationController.navigationBar viewWithTag:111].hidden=NO;
	self.petArray = [instance getPet];
   //    NSLog(@"self.petarray in medication:%@",self.petArray);
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
    countval=[petArray count];
    
	[myTable reloadData];
	if ([petArray count] > 0){
		noPet.hidden=YES;
		bgImage.image = [UIImage imageNamed:@"Background.jpg"];
	}
	else{
		noPet.hidden=NO;
		//bgImage.image = [UIImage imageNamed:@"firstbg.png"];
	}
    
    
    
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"pet_%d.png",[[recordDict objectForKey:@"pk"] intValue]]];			

    
    
    
    
    
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

- (void)addPet {
    
    
        AboutmeViewController *aboutmeViewController = [[AboutmeViewController alloc] initWithNibName:@"AddMedi" bundle:nil];
        [self.navigationController pushViewController:aboutmeViewController animated:YES];
        [aboutmeViewController release];	
   
   
    
 		
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[ListCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	[cell setData:[petArray objectAtIndex:indexPath.section]];
	// Configure the cell.
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
   
    
    AboutmeViewController *aboutmeViewController = [[AboutmeViewController alloc] initWithNibName:@"AddMedi" bundle:nil];
	aboutmeViewController.recordDict=recordDict;
    aboutmeViewController.recordDict = [petArray objectAtIndex:indexPath.section];
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.section forKey:@"select"];
	[self.navigationController pushViewController:aboutmeViewController animated:YES];
	[aboutmeViewController release];
  
    if(savedValue==5)
    {
        [self share];
         self.recordDict=recordDict;
        self.recordDict=[petArray objectAtIndex:indexPath.section];
    }

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[instance deletePet:[petArray objectAtIndex:indexPath.section]];
		self.petArray = [instance getPet];
		[myTable reloadData];
        [self viewWillAppear:YES];
		if ([petArray count] > 0){
			noPet.hidden=YES;
			bgImage.image = [UIImage imageNamed:@"bg.png"];
		}
		else{
			noPet.hidden=NO;
			//bgImage.image = [UIImage imageNamed:@"firstbg.png"];
		}
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







- (void)dealloc {
	[petArray release];
	[super dealloc];
}





@end

