//
//  RootViewController.h
//  PetLove
//
//  Created by CS Soon on 4/17/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"

@interface Appoinment : UIViewController<UIActionSheetDelegate> {
	NSArray *petArray;
	IBOutlet UITableView *myTable;

	IBOutlet UIImageView *bgImage;
    int i;
    IBOutlet UILabel *nolab;
  IBOutlet UIButton * appload;
    BOOL share1;
    int savedValue;
    NSString*appoFile;
    NSString*appoNFile;
    NSMutableArray *_AppDArr;
    NSMutableArray *_AppNArr;
  
}


-(IBAction)apptomedi;
-(IBAction)apptorem;
-(IBAction)apptoass;
-(IBAction)apptohome;
-(IBAction)apptocom;
-(IBAction)apptoset;


@end
