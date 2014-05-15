//
//  RootViewController.h
//  PetLove
//
//  Created by CS Soon on 4/17/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//
#import <UIKit/UIKit.h>



#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController<UIActionSheetDelegate> {
	NSArray *petArray;
	IBOutlet UITableView *myTable;
	IBOutlet UILabel *noPet;
	IBOutlet UIImageView *bgImage;
    NSMutableDictionary *recordDict;
    BOOL share1;
    int savedValue;
    IBOutlet UIButton * mediload;
    int countval;


    
  
}
-(IBAction)meditohome;
-(IBAction)meditorem;
-(IBAction)meditoass;
-(IBAction)meditoapp;
-(IBAction)meditocom;
-(IBAction)meditoset;
@property (assign)int countval;

@property (retain,nonatomic) NSArray *petArray;
@property (retain, nonatomic) NSMutableDictionary *recordDict;
@end
