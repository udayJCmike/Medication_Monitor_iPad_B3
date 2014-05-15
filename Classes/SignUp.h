//
//  SignUp.h
//  MediMoni
//
//  Created by hsa1 on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface SignUp : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    IBOutlet UITextField *email;
    IBOutlet UITextField *skype;
    IBOutlet UITextField *face;
    IBOutlet UITextField *mobile;
    IBOutlet UITextField *name;
    IBOutlet UITextField *pass;
    IBOutlet UITextField *cpass;
    IBOutlet UITextField *firstname;
    IBOutlet UITextField *lastname;
    IBOutlet UIButton*male,*female;
    NSString *sex;
    BOOL isConnect;
    UIImage *img;
    int a,b,c1,d,e,f,g,h;
    IBOutlet UIButton*agebut;
    IBOutlet UIButton*countrybut;
    IBOutlet UIPickerView *pickerView;
    IBOutlet UIPickerView *pickerCountry;
    IBOutlet UILabel*agebutt;
    IBOutlet UILabel*countrybutt;
    NSMutableArray *arrayNo;
    NSMutableArray *countryname;
    IBOutlet UIImageView*us;
    IBOutlet UIImageView*pa;
    IBOutlet UIImageView*copa;
    IBOutlet UIImageView*eid;
    IBOutlet UIImageView *age;
    IBOutlet UIImageView *mobileval;
    int visit,visit1,visit2;
    
}
@property (retain, nonatomic) IBOutlet UIPickerView *pickerCountry;
- (IBAction)countrybut:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *countrybutt;

- (IBAction)agebut:(id)sender;
@property (nonatomic, retain)IBOutlet UILabel *agebutt;
@property(nonatomic,retain)IBOutlet UIPickerView *pickerView;

- (IBAction)checkboxButton:(UIButton *)button;
//-(IBAction)clearbutton:(UIButton *)clearbutton;
-(IBAction)SingnUp;
-(BOOL)validateEmail:(NSString*)candidate;
-(BOOL)validateMobile:(NSString*)mobilenumber;
-(BOOL)validateNames:(NSString*)country1;
-(BOOL)validateUsername:(NSString*)user;
-(BOOL)validateZip:(NSString*)zipnumber;
@end
