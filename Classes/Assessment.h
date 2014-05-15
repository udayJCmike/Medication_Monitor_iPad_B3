#import <UIKit/UIKit.h>
#import "AppSharedInstance.h"
#import "SVSegmentedControl.h"
#import <AVFoundation/AVFoundation.h>
@interface Assessment : UIViewController<UIWebViewDelegate,UIActionSheetDelegate,AVAudioPlayerDelegate, AVAudioRecorderDelegate> {
    NSArray *_assQues;
    NSArray *_assAns;
    NSMutableDictionary *recordDict;
    int number;
    int questionid;
    IBOutlet UITableView*myTable;
    IBOutlet UILabel*question;
    int reu;
    NSMutableArray *_assArray;
    AVAudioPlayer *audioPlayerRecord;
 
    
    	IBOutlet UITableView*Audio;
    NSMutableArray *photoArray;
    NSString*questiontype;
    IBOutlet UIButton*assload;
	
   
}

-(IBAction)asstohome;
-(IBAction)asstomedi;
-(IBAction)asstorem;
-(IBAction)asstoapp;
-(IBAction)asstocom;
-(IBAction)asstoset;
@property(assign)int reu;
@property (nonatomic) int currentPage;
@property (retain,nonatomic) NSArray *_assQues;
@property (retain,nonatomic) NSArray *_assAns;
@property (retain, nonatomic) NSMutableDictionary *recordDict;

- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl;
@end
