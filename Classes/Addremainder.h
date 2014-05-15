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

@interface Addremainder : UIViewController<UIActionSheetDelegate> {
	NSArray *petArray;
    IBOutlet UILabel *noPet;
	IBOutlet UIImageView *bgImage;
    NSMutableDictionary *recordDict;
    BOOL share1;
    
    int savedValue;
    IBOutlet UITextField*name;
    UISegmentedControl *scheduleControl;
    NSString*reminderFile;
    NSMutableArray *_RemaindersArray;
    
    NSMutableArray *dictionary;
    NSString *dicfile;
    NSMutableArray *dictionaryArray;
    UILocalNotification *notiff;
    NSString *theString;
    NSString *name1;
    UIDatePicker *datePicker;
    IBOutlet UIButton*once;
    IBOutlet UIButton*setdate;
    IBOutlet UILabel*dateLabel;
    IBOutlet UIImageView*mask;
    
    IBOutlet UIDatePicker *timePicker;
    IBOutlet UIButton*daily;
    IBOutlet UIButton*settime;
    IBOutlet UILabel*timeLabel;
    IBOutlet UIImageView*maskDaily;
    int alertType;
    BOOL opt;
    int row1;
    IBOutlet UITextField *selected1;
    int clicked;
    int index;
    NSString *notifname;
    NSDate *notifdate;
    int timeset;
    int dateset;
}
- (IBAction)changeTimeInLabel:(id)sender;
-(IBAction)once:(id)sender;
-(IBAction)setDate;
-(IBAction)setTime;
- (IBAction)changeDateInLabel:(id)sender;
@property (nonatomic,retain) IBOutlet UISegmentedControl *scheduleControl;
@property (nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property (retain,nonatomic) NSArray *petArray;
@property (retain, nonatomic) NSMutableDictionary *recordDict;
@property(nonatomic)int clicked;
@property(nonatomic)int index;
@property(nonatomic,retain)IBOutlet NSString*notifname;
@property(nonatomic,retain)NSDate *notifdate;
@property(nonatomic)int timeset;
@property(nonatomic)int dateset;


@end
