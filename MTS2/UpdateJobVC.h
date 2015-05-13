//
//  UpdateJobVC.h
//  MTS2
//
//  Created by Pritesh-Mac on 4/29/14.
//  Copyright (c) 2014 Pritesh-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AUTH_URL @"http://mtsservice.showdemonow.com/JobmobileService.svc/ValidateJobByAuthenticationCode"
#define UPDATE_JOB_URL @"http://mtsservice.showdemonow.com/JobmobileService.svc/UpdateJobDetail"
#define SEND_MAIL @"http://mtsservice.showdemonow.com/JobmobileService.svc/SendForemenNotification"
#define MSG_ERROR @"An Error occured while processing your request!"
#define MSG_INVALIAD_AUTH_CODE @"Invalid authentication code"
#define MSG_INTERNET @"Please check your internet connection!"

#define JOB_EXIST @"Transaction has already been entered for the day."

@interface UpdateJobVC : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>{


}
@property (weak, nonatomic)  NSMutableDictionary *updatejob;
@property (weak, nonatomic) IBOutlet UILabel *lblJobSite;
@property (weak, nonatomic) IBOutlet UILabel *lblTrcukCompany;
@property (weak, nonatomic) IBOutlet UILabel *lblTruckSupplier;
@property (weak, nonatomic) IBOutlet UILabel *lblJobType;
@property (weak, nonatomic) IBOutlet UILabel *lblStart;
@property (weak, nonatomic) IBOutlet UILabel *lblEnd;
@property (weak, nonatomic) IBOutlet UILabel *lblLunch;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblJobTypeText;
@property (weak, nonatomic) IBOutlet UILabel *lblDriver;
@property (weak, nonatomic) IBOutlet UILabel *lblEquipment;
@property (weak, nonatomic) IBOutlet UILabel *lblMaterial;
@property (weak, nonatomic) IBOutlet UILabel *lblTruck;
@property (weak, nonatomic) IBOutlet UITextField *txtAuthCode;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

- (IBAction)OnConfirmClick:(id)sender;
- (IBAction)OnBackClick:(id)sender;

@end
