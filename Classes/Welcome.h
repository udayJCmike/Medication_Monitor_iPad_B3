//
//  Welcome.h
//  MediMoni
//
//  Created by hsa1 on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface Welcome : UIViewController<MBProgressHUDDelegate>
{
    NSDictionary *tableContents;
	NSArray *sortedKeys;
    MBProgressHUD *HUD;
    NSString*appoFile;
    NSString*appoNFile;
    NSMutableDictionary *recordDict;
    NSMutableArray *_AppDArr;
    NSMutableArray *_AppNArr;
    NSMutableArray *petArray;
    IBOutlet UIButton*syn;
    NSArray *_assQues;
    NSArray *_assAns;
    UIBarButtonItem *saveButton;
    int first;
    
    IBOutlet UITableView *myTable;
    IBOutlet UILabel *welcome;
    IBOutlet UIButton *homeload;
    
    NSMutableArray *reminderarray;
    NSArray *assesment;
    int Add;
    int choose;
    BOOL isConnect;
    BOOL select;
    NSArray *newArray;
    
    
}
-(IBAction)back1;
-(IBAction)sunc:(id)sender;
-(IBAction)Hometomedi;
-(IBAction)Hometorem;
-(IBAction)Hometoass;
-(IBAction)Hometoapp;
-(IBAction)Hometocom;
-(IBAction)Hometoset;
-(IBAction)signout;
@property (retain,nonatomic) NSMutableArray *petArray;
@property (nonatomic,retain) NSDictionary *tableContents;
@property (nonatomic,retain) NSArray *sortedKeys;
@property (retain,nonatomic) NSArray *_assQues;
@property (retain,nonatomic) NSArray *_assAns;
@property (retain,nonatomic) NSArray *assesment;
@property (retain, nonatomic) NSMutableDictionary *recordDict;
@property(assign)int first;

@end
