#import <UIKit/UIKit.h>
#import "AppSharedInstance.h"
#import "MBProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
@interface que : UIViewController<MBProgressHUDDelegate,UIWebViewDelegate,UIActionSheetDelegate,AVAudioPlayerDelegate, AVAudioRecorderDelegate> {
    NSArray *_assQues;
    NSArray *_assAns;
    NSMutableDictionary *recordDict;
    int number;
    int questionid;
    BOOL checked;
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *audioPlayerRecord;
    AVAudioRecorder *audioRecorder;
    
    IBOutlet UILabel*question;
    IBOutlet UIScrollView*scrollview;
    NSMutableArray *_assArray;
    int hh;
    BOOL check;
    NSMutableArray *buttonsToRemove;
    int daily;
    
    NSMutableArray*AVA;
    NSMutableArray *lables;
   
    NSString *urlNew;
    int recordEncoding;
    NSURL *curentAudio;
    NSString *CCC;
    
    enum
    {
        ENC_AAC = 1,
        ENC_ALAC = 2,
        ENC_IMA4 = 3,
        ENC_ILBC = 4,
        ENC_ULAW = 5,
        ENC_PCM = 6,
    } encodingTypes;
    
    IBOutlet UIToolbar*toolbar;
    IBOutlet UIBarButtonItem*record;
     IBOutlet UIBarButtonItem*stop;
    
  //  IBOutlet AQLevelMeter*lvlMeter_in;
  
    int monthindex,weekindex;
    int ret,ret1;
    int set,set1;
    IBOutlet UILabel*recording;
    IBOutlet UIActivityIndicatorView*rec;
    NSTimer *playerTimer;
    NSDate *pastdate;
    NSString *xmlFile;;
    NSMutableArray *_QuestionArray;
    NSMutableArray *_AnswerArray;
    NSString*SelectAns;
    NSString *filenew;
    MBProgressHUD *HUD;
    
}
- (IBAction)playRecordClicked:(id)sender ;
- (IBAction)save:(id)sender ;
- (IBAction)startRecordClicked:(id)sender;
- (IBAction)stopRecordClicked:(id)sender;

@property (retain,nonatomic) NSArray *_assQues;
@property (retain,nonatomic) NSArray *_assAns;
@property (retain, nonatomic) NSMutableDictionary *recordDict;
@property(retain,nonatomic)NSMutableArray*AVA;
@property(retain,nonatomic)NSDate *pastdate;
@end
