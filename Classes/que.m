
#import "que.h"
#import "AppSharedInstance.h"
#import "SpeakHereViewController.h"
#import "BlockAlertView.h"
#import "Assessment.h"
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1
@implementation que
@synthesize recordDict;

@synthesize _assQues;
@synthesize _assAns;
@synthesize pastdate;

AppSharedInstance *instance;


#pragma mark - AVAudioPlayerDelegate


#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
{
    
        // your actions here
    
}

- (IBAction)playAudioClicked:(id)sender {
    
    if (audioPlayer) {
        if (audioPlayer.isPlaying) [audioPlayer stop];
        else [audioPlayer play];
        
        return;
    }
    
    ////NSLog(@"play");
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Track1" ofType: @"m4a"];
    
    
    NSURL *url = [NSURL fileURLWithPath: path];
    
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: url error: &error];
    [audioPlayer setNumberOfLoops:0];
    [audioPlayer play];
}

- (IBAction)startRecordClicked:(id)sender {
    
    
    
    rec.hidden=NO;
    recording.hidden=NO;
    checked=YES;
    
    record.width=0.01;
    stop.width=0;
    [audioRecorder release];
    audioRecorder = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if (recordEncoding == ENC_PCM) {
        [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM]  forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0]              forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt:2]                      forKey:AVNumberOfChannelsKey];
        
        [recordSetting setValue:[NSNumber numberWithInt:16]                     forKey:AVLinearPCMBitDepthKey];
        [recordSetting setValue:[NSNumber numberWithBool:NO]                    forKey:AVLinearPCMIsBigEndianKey];
        [recordSetting setValue:[NSNumber numberWithBool:NO]                    forKey:AVLinearPCMIsFloatKey];
    } else {
        
        NSNumber *formatObject;
        
        switch (recordEncoding) {
            case ENC_AAC:
                formatObject = [NSNumber numberWithInt:kAudioFormatMPEG4AAC];
                break;
                
            case ENC_ALAC:
                formatObject = [NSNumber numberWithInt:kAudioFormatAppleLossless];
                break;
                
            case ENC_IMA4:
                formatObject = [NSNumber numberWithInt:kAudioFormatAppleIMA4];
                break;
                
            case ENC_ILBC:
                formatObject = [NSNumber numberWithInt:kAudioFormatiLBC];
                break;
                
            case ENC_ULAW:
                formatObject = [NSNumber numberWithInt:kAudioFormatULaw];
                break;
                
            default:
                formatObject = [NSNumber numberWithInt:kAudioFormatAppleIMA4];
                break;
        }
        
        [recordSetting setValue:formatObject forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0]forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt:2]forKey:AVNumberOfChannelsKey];
        [recordSetting setValue:[NSNumber numberWithInt:12800]forKey:AVEncoderBitRateKey];
        [recordSetting setValue:[NSNumber numberWithInt:16]forKey:AVLinearPCMBitDepthKey];
        [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
        
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    int i=0+arc4random()%1000;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%irecordTest.caf", recDir,i]];
    
    filenew=[[NSString alloc]init];
    filenew=[NSString stringWithFormat:@"%irecordTest.caf", i];
    ////NSLog(@"FileNew:%@",filenew);
    curentAudio=url;
    //////NSLog(@"URLNNNNN:%@,    %@",url,curentAudio);
    
   
    
    NSError *error = nil;
    audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&error];
    [audioRecorder setMeteringEnabled:YES];
    int channels = audioPlayerRecord.numberOfChannels;
    ////NSLog(@"Channels:%i",channels);
    [audioRecorder updateMeters];
    audioPlayer.delegate = self;
    
    BOOL audioHWAvailable = audioSession.inputIsAvailable;
    if (! audioHWAvailable) {
               BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Warning!" message:@"Audio input hardware not available."];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
        
        [alert release];
        
        return;
    }
    
    
    if ([audioRecorder prepareToRecord]) {
        [audioRecorder record];
        if (!playerTimer)
        {
            playerTimer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                           target:self selector:@selector(monitorAudioPlayer)
                                                         userInfo:nil
                                                          repeats:YES];
        }
        
        //////NSLog(@"recording");
    } else {
            }
    
    
    
}


-(void) monitorAudioPlayer
{
   }

- (IBAction)stopRecordClicked:(id)sender {
    
    rec.hidden=YES;
    recording.hidden=YES;
    stop.width=0.01;
    record.width=0;
    [audioRecorder stop];
    
    if (audioPlayer) [audioPlayer stop];
    
    if (audioPlayerRecord) {
        if (audioPlayerRecord.isPlaying)
            [audioPlayerRecord stop];
        else [audioPlayerRecord play];
        
        return;
    }
    
   
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    
    
    
    NSDate* now = [NSDate date];
    NSString *n=[NSString stringWithFormat:@"%@",now];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"d:MM:yyyh:mma"];
    
    NSString *timetofill = [outputFormatter stringFromDate:now];
    n=timetofill;
    
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    
	
    NSURL *url = curentAudio;
    
    
        CCC=[NSString stringWithFormat:@"%@",url];
        [recordDict setObject:CCC forKey:@"name"];
    
    
}


-(NSString *)applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
    
}

-(void)save1
{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    NSDate* now = [NSDate date];
    NSString *n=[NSString stringWithFormat:@"%@",now];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@" d:MM:yyy    h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:now];
    n=timetofill;
    [recordDict setObject:n forKey:@"date"];
    
    
    int a=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
    if(a==50)
    {
        NSString*str=@"Daily Questionnaire";
        [recordDict setObject:str forKey:@"type"];
    }
    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    [recordDict setObject:UserId forKey:@"patid"];
    [instance insertAudio:recordDict];
    
    
    
    
    NSMutableArray *ar=[instance getAudio];
    
    
    NSString*str=[[ar lastObject]objectForKey:@"pk" ];
    NSString*Astr=[NSString stringWithFormat:@"A%@",[[ar lastObject]objectForKey:@"pk" ]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
     NSString*p=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,str];
    NSString*pa=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,Astr];
   
    [_QuestionArray writeToFile:p atomically:YES];
    [_AnswerArray writeToFile:pa atomically:YES];
    
    
    
    
    NSString *newString = CCC;
    NSString *newString1 = [newString stringByReplacingOccurrencesOfString:@"file://localhost" withString:@""];
   
    
    
    NSString *result;
    NSData *responseData;
    

    
    UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    
    
    
    
    
    
    NSString *filePath5 = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:newString1];
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    if ([fileManager fileExistsAtPath:newString1])
    {
     
        
    }
    else
    {
      
    }
    
    NSData *userImageData = [[NSData alloc] initWithContentsOfFile:newString1];
    
    
    
    @try {
        NSURL *url = [[NSURL alloc] initWithString:@"http://www.medsmonit.com/Service/patassessresponce.php?service=assessinsert"];
        NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
        [req setHTTPMethod:@"POST"];
        
        [req setValue:@"multipart/form-data; boundary=*****" forHTTPHeaderField:@"Content-Type"];//
        
        NSMutableData *postBody = [NSMutableData data];
        NSString *stringBoundary = [NSString stringWithString:@"*****"];
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"insertImage\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"true"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"patid\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",UserId] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        xmlFile=[NSString stringWithFormat:@"<Result><Question>%@,,%@</Question><Answer>%@,,%@</Answer></Result>",[_QuestionArray objectAtIndex:0],[_QuestionArray objectAtIndex:1],[_AnswerArray objectAtIndex:0],[_AnswerArray objectAtIndex:1]];
        
               
        
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"assessxml\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",xmlFile] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        
        
        int type=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
        
        NSString* myNewString = [NSString stringWithFormat:@"%i", type];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"assessid\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",myNewString] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"patientaudio\"; filename=\"Record.caf\"\r\nContent-Type: audio/caf\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[NSData dataWithData:userImageData]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        [req setHTTPBody: postBody];//putParams];
        
        NSHTTPURLResponse* response = nil;
        NSError* error = [[[NSError alloc] init] autorelease];
        
        responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        
        [url release];
        [req release];
        
        
    }
    @catch (NSException* ex) {
        ////NSLog(@"Error: %@",ex);
    }
    
       
    
    [_QuestionArray addObject:@""];
    [_AnswerArray   addObject:@""];
    
    
        
    
    [[self navigationController] popViewControllerAnimated:YES];
   
}
- (IBAction)save:(id)sender
{
    
    if(checked == YES)
        
    {
        NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
        [sharedDefaults setObject:[NSDate date] forKey:@"nowold"];
     
        [sharedDefaults synchronize];
        [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"daily"];

        HUD.delegate = self;
        
        [HUD show:YES];
        HUD.labelText = @"Processing....";
      
        [HUD hide:YES afterDelay:2.6];
        [self performSelector:@selector(save1) withObject:nil afterDelay:0.2];
    }
    else
    {
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oh Snap!" message:@"Please Record Your Opinion"];
        
  
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
    }
    
    
    
}
- (IBAction)playRecordClicked:(id)sender {
    
    if (audioPlayerRecord)
    {
        if (audioPlayerRecord.isPlaying)
            [audioPlayerRecord stop];
        else [audioPlayerRecord play];
        
        return;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    
	
    NSURL *url = curentAudio;
    
    

    CCC=[NSString stringWithFormat:@"%@",url];

    [recordDict setObject:CCC forKey:@"name"];
        NSError *error;
    audioPlayerRecord = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayerRecord.delegate=self;
    [audioPlayerRecord play];
    

}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (player == audioPlayerRecord) {
        audioPlayerRecord = nil;
    }
}

-(void)back
{
    /* Line added to avoid the overlapping of back button with Questionnarie? in Navigation controller*/
    [[self.navigationController.navigationBar viewWithTag:111]removeFromSuperview];
    
    Assessment*new = [[Assessment alloc] initWithNibName:@"Assessment" bundle:nil];
    [self.navigationController pushViewController:new animated:NO];
    [Assessment release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (void)viewDidLoad
{
    
    checked=NO;
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    
    _QuestionArray=[[NSMutableArray alloc]init];
    _AnswerArray=[[NSMutableArray alloc]init];
    recordEncoding = ENC_PCM;
    stop.width=0.01;
    [super viewDidLoad];
    ret=1;
    ret1=0;
    set=1;
    set1=0;
    monthindex=0;
    weekindex=0;
    
    daily=[[NSUserDefaults standardUserDefaults]integerForKey:@"daily"];
    ////NSLog(@"Daily:%i",daily);
    
    
    _assArray=[[NSMutableArray alloc]init];
    lables=[[NSMutableArray alloc]init];
    number=0;
    
    instance = [AppSharedInstance sharedInstance];
    self._assQues=[instance getAssQue];
    self._assAns=[instance getAssAnswer];
    
    
    
    buttonsToRemove = [[NSMutableArray alloc]init];
    //  [self speak];
   NSLog(@"SELF>_ASSQues::::%@",self._assQues);
     NSLog(@"SELF>_ASSAns::::%@",self._assAns);
    if ([recordDict count]>0)
    {
        
	}
	else {
        recordDict = [[NSMutableDictionary alloc] init];
        
	}
    
    
    
    if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top_Panel.png"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Questionnaire?", @"");
    [label sizeToFit];
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@"Back.png"]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
}



-(void)monthans
{
    int x=0;
    for (id anUpdate in self._assAns)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        
        NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
        int theValue1 = [num1 intValue];
        int okok=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
        if(theValue1==okok)
        {
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            int theValue = [num intValue];
            //  [num release];
            
            if(theValue==questionid)
            {
                
                NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"answer"];
                NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"ansid"];
                
                
                NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                
                
                
                
                NSNumber *numid = [(NSDictionary*)anUpdate objectForKey:@"ansid"];
                int nextID = [numid intValue];
                
                
                ////NSLog(@"YES");
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self
                           action:@selector(checkMethod1:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setSelected:NO];
                [button setTitle:@"OK"  forState:UIControlStateNormal];
                button.frame = CGRectMake(40.0, 210.0, 42, 38);
                button.center=CGPointMake(134, 300+x);
                [button setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
                [self.view addSubview:button];
                button.tag=x;
                
                [buttonsToRemove addObject:button];
                
                UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont boldSystemFontOfSize:20.0];
                label.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
                label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
                label.center=CGPointMake(384, 308+x);
                label.textAlignment = UITextAlignmentCenter;
                label.textColor = [UIColor whiteColor]; // change this color
                [lables addObject:label];
                label.text =[(NSDictionary*)anUpdate objectForKey:@"answer"];
                
                [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
                [label sizeToFit];
                label.tag=x;
                [self.view addSubview:label];
                x=x+60;
                
                
            }
            
        }
    }
    
}

-(void)saveMonth
{
        
}


-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
       int type=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@  &%@=%@  &assessid=%d  &assessxml=%@",firstEntity,value1,secondEntity,value2,type,xmlFile];
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/patassessresponce.php?service=assessinsert"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    return data;
    
}




-(void)mothly
{
    
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(rem)   forControlEvents:UIControlEventTouchUpInside];
    UIImage*btnImage = [UIImage imageNamed:@"NExt.png"];
    [button setImage:btnImage forState:UIControlStateNormal];
    button.backgroundColor=[UIColor clearColor];
    
    button.frame = CGRectMake(80.0, 210.0, 120, 44);
    button.center=CGPointMake(384, 704);
    [self.view addSubview:button];
    button.hidden=YES;
    button.tag=2048;
    
    
    
    
    
    int okok=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
        
    
    for (id anUpdate in self._assQues)
    {
        
        
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assid"];
       
        
        NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
        int theValue1 = [num1 intValue];
        
        if(theValue1==okok)
        {
            
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
            int theValue = [num intValue];
            
            if(theValue==number)
            {
                
                NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                               question.text=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                
                question.numberOfLines = 0; 
                                
                NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                questionid = [num intValue];
                //     [num release];
                
                ret1++;
                if(ret==ret1)
                {
                    ret=ret1+1;
                     ret1=0;
                    [self monthans];
                    return;
                }
                else if(ret==13)
                {
                    question.text=@"Thank you for completing this questionnaire.";
                                       
                    xmlFile=[NSString stringWithFormat:@"<Result><Question>%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@</Question><Answer>%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@</Answer></Result>",[_QuestionArray objectAtIndex:0],[_QuestionArray objectAtIndex:1],[_QuestionArray objectAtIndex:2],[_QuestionArray objectAtIndex:3],[_QuestionArray objectAtIndex:4],[_QuestionArray objectAtIndex:5],[_QuestionArray objectAtIndex:6],[_QuestionArray objectAtIndex:7],[_QuestionArray objectAtIndex:8],[_QuestionArray objectAtIndex:9],[_QuestionArray objectAtIndex:10],[_QuestionArray objectAtIndex:11],[_AnswerArray objectAtIndex:0],[_AnswerArray objectAtIndex:1],[_AnswerArray objectAtIndex:2],[_AnswerArray objectAtIndex:3],[_AnswerArray objectAtIndex:4],[_AnswerArray objectAtIndex:5],[_AnswerArray objectAtIndex:6],[_AnswerArray objectAtIndex:7],[_AnswerArray objectAtIndex:8],[_AnswerArray objectAtIndex:9],[_AnswerArray objectAtIndex:10],[_AnswerArray objectAtIndex:11]];
                    
                    NSDate* now = [NSDate date];
                    NSString *n=[NSString stringWithFormat:@"%@",now];
                    
                    
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    [outputFormatter setDateFormat:@" d:MM:yyy    h:mm a"];
                    
                    NSString *timetofill = [outputFormatter stringFromDate:now];
                    n=timetofill;
                    [recordDict setObject:n forKey:@"date"];
                    
                    
                    int a=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
                    //NSLog(@"asstype:%i",a);
                    if(a==50)
                    {
                        NSString*str=@"Daily Questionnaire";
                        [recordDict setObject:str forKey:@"type"];
                    }
                    else if(a==3)
                    {
                        NSString*str=@"Monthly Questionnaire";
                        [recordDict setObject:str forKey:@"type"];
                        NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
                        [sharedDefaults setObject:[NSDate date] forKey:@"nowoldmonth"];
                      
                        [sharedDefaults synchronize];

                    }
                    [recordDict setObject:@"" forKey:@"name"];
                    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
                    [recordDict setObject:UserId forKey:@"patid"];
                    [instance insertAudio:recordDict];
                    
                    NSMutableArray *ar=[instance getAudio];
                    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
                    NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
                   
                    question.numberOfLines = 0;
                    
                    
                    NSString*str=[[ar lastObject]objectForKey:@"pk" ];
                    NSString*Astr=[NSString stringWithFormat:@"A%@",[[ar lastObject]objectForKey:@"pk" ]];
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *recDir = [paths objectAtIndex:0];
                    
                    NSString*p=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,str];
                    NSString*pa=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,Astr];
                 
                    [_QuestionArray writeToFile:p atomically:YES];
                    [_AnswerArray writeToFile:pa atomically:YES];
                    
                    return;
                    
                    
                }
                
                
               
                
            }
            else
            {
                
                            }
        }
        
        
        
    }
    
        
    
    
    
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    
    NSDate* now = [NSDate date];
 NSDate*old=[[NSUserDefaults standardUserDefaults]objectForKey:@"nowold"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init] ;
    [dateFormat setDateFormat:@"dd-MM-YYYY"];
    NSString *currentdate = [dateFormat stringFromDate:now];
     NSString *pastdate1 = [dateFormat stringFromDate:old];
    NSLog(@"current date %@",currentdate);
    NSLog(@"past date %@",pastdate1);
    
    if ([currentdate compare:pastdate1] == NSOrderedDescending)
    {
       NSLog(@"now is later than date2");
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"daily"];
        
    }
    else if ([currentdate compare:pastdate1] == NSOrderedAscending)
    {
     NSLog(@"date1 is earlier than date2");
        
    }
    else {
     NSLog(@"dates are the same");
        [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"daily"];
        
    }

    
    
    NSDate *nextday = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:old];
   NSString *nextdate = [dateFormat stringFromDate:nextday];
    
    daily=[[NSUserDefaults standardUserDefaults]integerForKey:@"daily"];
    int okok=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
    NSLog(@"okok value %i",okok);
    NSString *text=@"You have already answer your daily assessment. Your next daily assessment will be on ";
    NSString *Tt=[text stringByAppendingString:nextdate];
    
    if(okok==50 && daily==1 )
    {
        
        question.text =Tt;
                
        question.numberOfLines = 0;
        
        return;
    }
    
    instance = [AppSharedInstance sharedInstance];
    self._assQues=[instance getAssQue];
    self._assAns=[instance getAssAnswer];
    buttonsToRemove = [[NSMutableArray alloc]init];
    if ([recordDict count]>0) {
        
	}
	else {
        recordDict = [[NSMutableDictionary alloc] init];
        
	}
    
    NSDate *nowdate=[NSDate date];
    NSString *type=[[NSUserDefaults standardUserDefaults]objectForKey:@"questionType"];
    NSDate*oldmonth=[[NSUserDefaults standardUserDefaults]objectForKey:@"nowoldmonth"];
    NSDate *nextmonth = [NSDate dateWithTimeInterval:(31*24*60*60) sinceDate:oldmonth];
    NSLog(@"Next Month Date %@",nextmonth);
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init] ;
    [dateFormat1 setDateFormat:@"dd-MM-YYYY"];
    NSString *afterdays= [dateFormat1 stringFromDate:nextmonth];
    NSString *currentaccess = [dateFormat stringFromDate:nowdate];
    NSLog(@"Last accessed month date %@",oldmonth);
    NSLog(@" allowable date for next month %@",afterdays);
    NSLog(@"current date in month calculation %@",currentaccess);
    if([type isEqualToString:@"Monthly Questionnaire"])
    {
        if ([currentaccess compare:afterdays] == NSOrderedDescending)
        {
            NSLog(@"currentaccess > next month date ");
            [self mothly];
            return;
        }
        else if([currentaccess compare:afterdays]==NSOrderedAscending)
        {
            NSLog(@"Current date < next month date");
            NSString *te=@"You have already answer your monthly assessment. Your next monthly assessment will be on ";
            NSString *title=[te stringByAppendingString:afterdays];
            
            question.text =title;
            //   question.textAlignment = NSTextAlignmentJustified;
            
            question.numberOfLines = 0;
            
            return;
        }
        else
        {
            [self mothly];
            return;
        }
    }
    

    
    NSDate*oldweek=[[NSUserDefaults standardUserDefaults]objectForKey:@"nowoldweek"];
    NSDate *nextweek = [NSDate dateWithTimeInterval:(7*24*60*60) sinceDate:oldweek];
    NSLog(@"Next Week Date %@",nextweek);
    NSDateFormatter *dateFormat11 = [[NSDateFormatter alloc] init] ;
    [dateFormat11 setDateFormat:@"dd-MM-YYYY"];
    NSString *afterdays1= [dateFormat11 stringFromDate:nextweek];
    NSString *currentaccess1 = [dateFormat stringFromDate:nowdate];
    NSLog(@"Last accessed week date %@",oldweek);
    NSLog(@" allowable date for next week %@",afterdays1);
    NSLog(@"current date in week calculation %@",currentaccess1);
if([type isEqualToString:@"Weekly Questionnaire"])
{
    if ([currentaccess1 compare:afterdays1] == NSOrderedDescending)
{
    NSLog(@"currentaccess > next week date ");
    [self weekly];
    return;
}
else if([currentaccess1 compare:afterdays1]==NSOrderedAscending)
{
    NSLog(@"Current date < next month date");
    NSString *te=@"You have already answer your weekly assessment. Your next weekly assessment will be on ";
    NSString *title=[te stringByAppendingString:afterdays1];
    
    question.text =title;
    //   question.textAlignment = NSTextAlignmentJustified;
    
    question.numberOfLines = 0;
    
    return;
}
else
{
    [self weekly];
    return;
}
    }
    
    
    
    
    
    for (id anUpdate in self._assQues)
    {
        
        
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assid"];
  
        
        NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
        int theValue1 = [num1 intValue];
        
        if(theValue1==okok)
        {
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
            int theValue = [num intValue];
            [num release];
            if(theValue==number)
            {
                NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
           
                question.text=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                question.numberOfLines = 0;
                          
                NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                questionid = [num intValue];
                [num release];
             
            }
        }
    }
    
   
    
    
    int x=0;
    for (id anUpdate in self._assAns)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        
        NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
        int theValue1 = [num1 intValue];
        
        if(theValue1==okok)
        {
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            int theValue = [num intValue];
     
            
            if(theValue==questionid)
            {
                
                
           
                NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"answer"];
                NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"ansid"];
         
                NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                
                
                
                
                NSNumber *numid = [(NSDictionary*)anUpdate objectForKey:@"ansid"];
                int nextID = [numid intValue];
                
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button addTarget:self
                           action:@selector(aMethod:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
                button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
                button.center=CGPointMake(384, 304+x);
                button.tag= nextID;
                [buttonsToRemove addObject:button];
                NSDictionary *assname=[(NSDictionary*)anUpdate objectForKey:@"assname"];
                
                NSString *s=[NSString stringWithFormat:@"%@",[(NSDictionary*)anUpdate objectForKey:@"assname"]];
                
                if([s isEqualToString:@"Daily Questionnaire"])
                {
                    [self.view addSubview:button];
                }
                else
                {
                    [scrollview addSubview:button];
                }
                
                
                x=x+60;
             
                
            }
            
        }
    }
    
    
    
    
    
}

-(void)weekans
{
    int x=0;
    for (id anUpdate in self._assAns)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        
        NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
        int theValue1 = [num1 intValue];
        int okok=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
        if(theValue1==okok)
        {
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            int theValue = [num intValue];
            //  [num release];
            
            if(theValue==questionid)
            {
                
                NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"answer"];
                NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"ansid"];
                
                
                NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                
                
                
                
                NSNumber *numid = [(NSDictionary*)anUpdate objectForKey:@"ansid"];
                int nextID = [numid intValue];
                
                
                ////NSLog(@"YES");
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self
                           action:@selector(checkMethod1:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setSelected:NO];
                [button setTitle:@"OK"  forState:UIControlStateNormal];
                button.frame = CGRectMake(40.0, 210.0, 42, 38);
                button.center=CGPointMake(134, 300+x);
                [button setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
                [self.view addSubview:button];
                button.tag=x;
                
                [buttonsToRemove addObject:button];
                
                UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont boldSystemFontOfSize:20.0];
                label.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
                label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
                label.center=CGPointMake(384, 308+x);
                label.textAlignment = UITextAlignmentCenter;
                label.textColor = [UIColor whiteColor]; // change this color
                [lables addObject:label];
                label.text =[(NSDictionary*)anUpdate objectForKey:@"answer"];
                
                [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
                [label sizeToFit];
                label.tag=x;
                [self.view addSubview:label];
                x=x+60;
                
                
            }
            
        }
    }
    
}

-(void)weekly
{
    
    
    // [self performSelector:@selector() withObject:nil afterDelay:0.3];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(rem1)   forControlEvents:UIControlEventTouchUpInside];
    UIImage*btnImage = [UIImage imageNamed:@"NExt.png"];
    [button setImage:btnImage forState:UIControlStateNormal];
    button.backgroundColor=[UIColor clearColor];
    //[button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 120, 44);
    button.center=CGPointMake(384, 704);
    [self.view addSubview:button];
    button.hidden=YES;
    button.tag=2048;
    
    
    
    
    
    int okok=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
    //  ////NSLog(@"[self._assQues objectAtIndex:0]:%@",[self._assQues objectAtIndex:0]);
    //  return;
    
    
    for (id anUpdate in self._assQues)
    {
        
        
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assid"];
        ////NSLog(@"assid:%@",arrayList);
        
        NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
        int theValue1 = [num1 intValue];
        
        if(theValue1==okok)
        {
            ////NSLog(@"OKOK:%i",okok);
            ////NSLog(@"theValue1:%i",theValue1);
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
            int theValue = [num intValue];
            //   [num release];
            //    ////NSLog(@"NUMBER:%i",number);
            if(theValue==number)
            {
                
                NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                //    ////NSLog(@"assquestion:%@",arrayList);
                question.text=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                //   question.textAlignment = NSTextAlignmentJustified;
                question.numberOfLines = 0;
                //   question.textAlignment = NSTextAlignmentJustified;
                /*  CGSize labelSize = [question.text sizeWithFont:question.font
                 constrainedToSize:question.frame.size
                 lineBreakMode:question.lineBreakMode];
                 question.frame = CGRectMake(
                 question.frame.origin.x, question.frame.origin.y,
                 question.frame.size.width, labelSize.height);*/
                
                NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                questionid = [num intValue];
                //     [num release];
                
                set1++;
                if(set==set1)
                {
                    set=set1+1;
                    NSLog(@"set:%i   set1!!:%i",set,set1);
                    NSLog(@"Q:%@",question.text);
                    set1=0;
                    [self weekans];
                    return;
                }
                else if(set==4)
                {
                    question.text=@"Thank you for completing this questionnaire.";
                    //   question.textAlignment = NSTextAlignmentJustified;
                    ////NSLog(@"_QuestionArrayP:%@",_QuestionArray);
                    ////NSLog(@"_QuestionArrayP:%@",_AnswerArray);
                    
                    xmlFile=[NSString stringWithFormat:@"<Result><Question>%@,,%@,,%@</Question><Answer>%@,,%@,,%@</Answer></Result>",[_QuestionArray objectAtIndex:0],[_QuestionArray objectAtIndex:1],[_QuestionArray objectAtIndex:2],[_AnswerArray objectAtIndex:0],[_AnswerArray objectAtIndex:1],[_AnswerArray objectAtIndex:2]];
                    
                    NSDate* now = [NSDate date];
                    NSString *n=[NSString stringWithFormat:@"%@",now];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:now forKey:@"nowoldweek"];
                    
                    
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    [outputFormatter setDateFormat:@" d:MM:yyy    h:mm a"];
                    
                    NSString *timetofill = [outputFormatter stringFromDate:now];
                    n=timetofill;
                    [recordDict setObject:n forKey:@"date"];
                    
                    
                    int a=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
                    NSLog(@"asstype:%i",a);
                /*    if(a==1)
                    {
                        NSString*str=@"Daily Questionnaire";
                        [recordDict setObject:str forKey:@"type"];
                    }
                    else if(a==3)
                    {
                        NSString*str=@"Monthly Questionnaire";
                        [recordDict setObject:str forKey:@"type"];
                    }
                    else */
                    if(a==49)
                    {
                        NSString*str=@"Weekly Questionnaire";
                        [recordDict setObject:str forKey:@"type"];
                        NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
                        [sharedDefaults setObject:[NSDate date] forKey:@"nowoldweek"];
                        
                        [sharedDefaults synchronize];
                    }
                    [recordDict setObject:@"" forKey:@"name"];
                    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
                    [recordDict setObject:UserId forKey:@"patid"];
                    [instance insertAudio:recordDict];
                    
                    NSMutableArray *ar=[instance getAudio];
                    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
                    NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
                    ////NSLog(@"UPDATED....:%@",resultResponse);
                    question.numberOfLines = 0;
                    
                    
                    NSString*str=[[ar lastObject]objectForKey:@"pk" ];
                    NSString*Astr=[NSString stringWithFormat:@"A%@",[[ar lastObject]objectForKey:@"pk" ]];
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *recDir = [paths objectAtIndex:0];
                    
                    NSString*p=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,str];
                    NSString*pa=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,Astr];
                    //NSLog(@"P:%@",p);
                    //NSLog(@"PAp:%@",pa);
                    [_QuestionArray writeToFile:p atomically:YES];
                    [_AnswerArray writeToFile:pa atomically:YES];
                    
                    return;
                    /*  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                     [button addTarget:self
                     action:@selector(saveMonth)   forControlEvents:UIControlEventTouchUpInside];
                     UIImage*btnImage = [UIImage imageNamed:@"NExt.png"];
                     [button setImage:btnImage forState:UIControlStateNormal];
                     button.backgroundColor=[UIColor clearColor];
                     //[button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
                     button.frame = CGRectMake(10.0, 210.0, 120, 44);
                     button.center=CGPointMake(314, 704);
                     [self.view addSubview:button];
                     // button.hidden=YES;
                     button.tag=2088;*/
                    
                }
                
                
                //  if(ret==1)
                //  {
                
                //    return;
                // }
                
            }
            else
            {
                
                //   ////NSLog(@"COMPLETE");
            }
        }
        
        
        
    }
    
    //  ////NSLog(@"_assAns:%@",self._assQues);
    
    
    
    
    
    
    
    
    
    
}


-(void)aMethod:(UIButton*)but
{
    
    [_QuestionArray addObject:question.text];
    
    [_AnswerArray addObject:but.titleLabel.text];
    number=but.tag;
    NSString*st=but.titleLabel.text;
        
    
    if([st isEqualToString:@"No"])
    {
        
        
        for (int i=0; i<=1; i++)
        {
            UIButton*but=[buttonsToRemove objectAtIndex:i];
            
            
            [but removeFromSuperview];
                   }
        [buttonsToRemove removeAllObjects];
        if([question.text isEqualToString:@"Do you have any other thoughts you would like to share about your new prescription?"])
        {
          
            [self complete1];
            return;
        }
        check=YES;
    }
    else
    {
       
        for (int i=0; i<=1; i++)
        {
            UIButton*but=[buttonsToRemove objectAtIndex:i];
            
            
            [but removeFromSuperview];
          
        }
        [buttonsToRemove removeAllObjects];
        check=NO;
        
    }
    
    
    if(check==YES)
    {
        [self explainRecord];
  
    }
    
    [self NextQuestion];
    
}


-(void)explainRecord1
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.frame = CGRectMake(80.0, 510.0, 360.0, 40.0);
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.center=CGPointMake(204, 280);
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    
    label.text =@"Please explain by recording your answer.";
    [label sizeToFit];
    [self.view addSubview:label];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(record:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"Record"  forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
    button.center=CGPointMake(384, 800);
    
    toolbar.center=CGPointMake(384, 400);
    recording.center=CGPointMake(353,400 );
    rec.center=CGPointMake(278, 400);
    toolbar.hidden=NO;

    [buttonsToRemove addObject:button];
    
}



-(void)explainRecord
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.center=CGPointMake(204, 680);
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    
    label.text =@"Please explain by recording your answer.";
    [label sizeToFit];
    [self.view addSubview:label];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(record:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"Record"  forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
    button.center=CGPointMake(384, 800);
    
    toolbar.hidden=NO;
 
    [buttonsToRemove addObject:button];
    
}
-(void)record:(UIButton*)sender
{
    [sender removeFromSuperview];
    [self speak];
}
-(void)checkMethod:(UIButton*)but
{
    
    [_QuestionArray addObject:question.text];
    [_AnswerArray addObject:but.titleLabel.text];

    SelectAns=but.titleLabel.text;
    
    [self.view viewWithTag:2048].hidden=NO;

    for(int i=0;i< [buttonsToRemove count];i++)
    {
        UIButton*but=[buttonsToRemove objectAtIndex:i];
        if([but isSelected])
        {
            [but setSelected:NO];
            [but setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
        }
        
        
    }
    
    
    if([but isSelected])
    {
        [but setSelected:NO];
        [but setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    }
    else
    {
        [but setImage:[UIImage imageNamed:@"select1.png"] forState:UIControlStateNormal];
        [but setSelected:YES];
    }
    
    
    
    
}

-(void)rem
{
    [_QuestionArray addObject:question.text];
    [_AnswerArray addObject:SelectAns];
   
    
    
    [self.view viewWithTag:2048].hidden=YES;
    question.text=@"";
    for(int i=0;i< [buttonsToRemove count];i++)
    {
        UIButton*but=[buttonsToRemove objectAtIndex:i];
        [but removeFromSuperview];
        
        
    }
    [buttonsToRemove removeAllObjects];
    
    for(int i=0;i< [lables count];i++)
    {
        UILabel*but=[lables objectAtIndex:i];
        [but removeFromSuperview];
        
        
    }
    [lables removeAllObjects];
    
 
    [self mothly];
}
-(void)rem1
{
    [_QuestionArray addObject:question.text];
    [_AnswerArray addObject:SelectAns];
    
    
    
    [self.view viewWithTag:2048].hidden=YES;
    question.text=@"";
    for(int i=0;i< [buttonsToRemove count];i++)
    {
        UIButton*but=[buttonsToRemove objectAtIndex:i];
        [but removeFromSuperview];
        
        
    }
    [buttonsToRemove removeAllObjects];
    
    for(int i=0;i< [lables count];i++)
    {
        UILabel*but=[lables objectAtIndex:i];
        [but removeFromSuperview];
        
        
    }
    [lables removeAllObjects];
    
    
    [self weekly];
}

-(void)checkMethod1:(UIButton*)but
{
    

    
    
    SelectAns=but.titleLabel.text;
    
    [self.view viewWithTag:2048].hidden=NO;
  
    for(int i=0;i< [buttonsToRemove count];i++)
    {
        UIButton*but=[buttonsToRemove objectAtIndex:i];
        if([but isSelected])
        {
            [but setSelected:NO];
            [but setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
        }
        
        
    }
    
    if([but isSelected])
    {
        [but setSelected:NO];
        [but setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    }
    else
    {
        [but setImage:[UIImage imageNamed:@"select1.png"] forState:UIControlStateNormal];
        [but setSelected:YES];
    }
    
    
    
}







-(void)NextQuestion
{
    
    
    
    
    
    self._assQues=[instance getAssQue];
    self._assAns=[instance getAssAnswer];
   
    
    
    for (id anUpdate in self._assQues)
    {
        
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assparentquestionid"];

        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
        int theValue = [num intValue];
        [num release];

        if(theValue==number)
        {
            
            NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
   
            question.text=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
            question.numberOfLines = 0;
 
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            questionid = [num intValue];
            [num release];
    
            hh=1;
            break;
        }
        else
        {
            
            hh=0;
        
            
        }
    }
    
    
    int x=0;
    for (id anUpdate in self._assAns)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        
        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        int theValue = [num intValue];
        [num release];
        
        if(theValue==questionid)
        {
          
            NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"answer"];
            NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"ansid"];
            
            NSNumber *numid = [(NSDictionary*)anUpdate objectForKey:@"ansid"];
            int nextID = [numid intValue];
            
          
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            
            
            if(check==NO)
            {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button addTarget:self
                           action:@selector(aMethod:)
                 forControlEvents:UIControlEventTouchUpInside];
                
                [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
                button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
                button.center=CGPointMake(384, 304+x);
                button.tag= nextID;
                [self.view addSubview:button];
                [buttonsToRemove addObject:button];
                x=x+60;
            
            }
            else
            {
                
                
                
              
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self
                           action:@selector(checkMethod:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setSelected:NO];
                [button setTitle:@"OK"  forState:UIControlStateNormal];
                button.frame = CGRectMake(40.0, 210.0, 42, 38);
                button.center=CGPointMake(134, 300+x);
                [button setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
                [self.view addSubview:button];
                button.tag=x;
                [buttonsToRemove addObject:button];
                
                UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont boldSystemFontOfSize:20.0];
                label.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
                label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
                label.center=CGPointMake(384, 308+x);
                label.textAlignment = UITextAlignmentCenter;
                label.textColor = [UIColor whiteColor]; // change this color
                
                label.text =[(NSDictionary*)anUpdate objectForKey:@"answer"];
                [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
                [label sizeToFit];
                [self.view addSubview:label];
                x=x+60;
                
            }
            
       
            
        }
        
    }
    
    
    if(hh==0)
    {
      
        [self complete];
    }
    
}
-(void)complete
{
    
  
    if([buttonsToRemove count]!=0)
    {
        for (int i=0; i<[buttonsToRemove count]; i++)
        {
            UIButton*but=[buttonsToRemove objectAtIndex:i];
            
            
            [but removeFromSuperview];
            
        }
        [buttonsToRemove removeAllObjects];
    }
    
    question.text =@"Thank you for completing this questionnaire.";
    question.numberOfLines = 0;
    
  
    NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
    [sharedDefaults setObject:[NSDate date] forKey:@"nowold"];
    
    [sharedDefaults synchronize]; 
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"daily"];
    
    [self explainRecord1];

    
    
}

-(void)complete1
{
    
    if([buttonsToRemove count]!=0)
    {
        for (int i=0; i<[buttonsToRemove count]; i++)
        {
            UIButton*but=[buttonsToRemove objectAtIndex:i];
            
            
            [but removeFromSuperview];
          
        }
        [buttonsToRemove removeAllObjects];
    }
    
    question.text =@"Thank you for completing this questionnaire.";
    question.numberOfLines = 0;
    NSDate* now = [NSDate date];
    NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
    [sharedDefaults setObject:[NSDate date] forKey:@"nowold"];
    
    [sharedDefaults synchronize];
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"daily"];
    
    xmlFile=[NSString stringWithFormat:@"<Result><Question>%@,,%@,,%@</Question><Answer>%@,,%@,,%@</Answer></Result>",[_QuestionArray objectAtIndex:0],[_QuestionArray objectAtIndex:1],[_QuestionArray objectAtIndex:2],[_AnswerArray objectAtIndex:0],[_AnswerArray objectAtIndex:1],[_AnswerArray objectAtIndex:2]];
    
    
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
    
 
    NSString *n=[NSString stringWithFormat:@"%@",now];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@" d:MM:yyy    h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:now];
    n=timetofill;
    [recordDict setObject:n forKey:@"date"];
    
    
    int a=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
    NSLog(@"a value :%i",a);
    if(a==50)
    {
        NSString*str=@"Daily Questionnaire";
        [recordDict setObject:str forKey:@"type"];
    }
    else if(a==3)
    {
        NSString*str=@"Monthly Questionnaire";
        [recordDict setObject:str forKey:@"type"];
    }
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    [recordDict setObject:UserId forKey:@"patid"];
    [recordDict setObject:@"" forKey:@"name"];
    [instance insertAudio:recordDict];
    NSMutableArray *ar=[instance getAudio];
    NSString*str=[[ar lastObject]objectForKey:@"pk" ];
    NSString*Astr=[NSString stringWithFormat:@"A%@",[[ar lastObject]objectForKey:@"pk" ]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    
    NSString*p=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,str];
    NSString*pa=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,Astr];

    [_QuestionArray writeToFile:p atomically:YES];
    [_AnswerArray writeToFile:pa atomically:YES];
       
}




-(void)completeAfterRecord
{
    
    
    
    if([buttonsToRemove count]!=0)
    {
        for (int i=0; i<[buttonsToRemove count]; i++)
        {
            UIButton*but=[buttonsToRemove objectAtIndex:i];
            
            
            [but removeFromSuperview];
          
        }
        [buttonsToRemove removeAllObjects];
    }
    
    question.text =@"Thank you for completing this questionnaire.";
    question.numberOfLines = 0;
    
    [_QuestionArray addObject:@""];
    [_AnswerArray addObject:@""];
    xmlFile=[NSString stringWithFormat:@"<Result><Question>%@,,%@</Question><Answer>%@,,%@</Answer></Result>",[_QuestionArray objectAtIndex:0],[_QuestionArray objectAtIndex:1],[_AnswerArray objectAtIndex:0],[_AnswerArray objectAtIndex:1]];
    
    
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
 
    
    
}






-(void)speak
{
    SpeakHereViewController *newNoteController = [[SpeakHereViewController alloc] initWithNibName:@"AudioRecord" bundle:nil];
    
    newNoteController.recordDict = recordDict;
    [self.view addSubview:newNoteController.view];
    [newNoteController release];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}
- (void)dealloc {
    
    [audioPlayer release];
    [audioRecorder release];
    [audioPlayerRecord release];
    [super dealloc];
}

@end

