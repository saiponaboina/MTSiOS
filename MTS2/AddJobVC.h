//
//  AddJobVC.h
//  MTS2
//
//  Created by Pritesh-Mac on 4/25/14.
//  Copyright (c) 2014 Pritesh-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"


#define MSG_INCORRECT_END_TIME @"End-Time must be after Start Time"
#define MSG_INCORRECT_LUNCHY_TIME @"Difference of Start Time and End Time must be greater than lunch time"

#define MSG_INTERNET @"Please check your internet connection!"

#define MSG_ERROR @"An Error occured while processing your request!"
#define JOB_LIST_REQUEST_URL @"http://mtswebservice.showmydemo.net/JobmobileService.svc/GetJobModesList" 
//#define ADD_JOB_REQUEST_URL @"http://mtswebservice.showmydemo.net/JobmobileService.svc/AddJobDetail"
#define ADD_JOB_REQUEST_URL @"http://mtsservice.showdemonow.com/JobmobileService.svc/AddJobDetail"
#define GET_EQUIPMENT_TYPE @"http://mtsservice.showdemonow.com/JobMobileService.svc/GetEquipmentTypeList"
#define GET_MATERIAL_TYPE @"http://mtsservice.showdemonow.com/JobMobileService.svc/GetMaterialTypeList"
#define CHECK_JOB_EXISTING @"http://mtsservice.showdemonow.com/JobMobileService.svc/IsJobTransaxnExist"
#define GET_JOB_MODE @"http://mtsservice.showdemonow.com/JobmobileService.svc/GetJobModesList"

@interface AddJobVC : UIViewController <BSKeyboardControlsDelegate,UIActionSheetDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{

}

@property (strong, nonatomic)  NSMutableDictionary *job;
@property (weak, nonatomic) IBOutlet UILabel *lblJobsite;
@property (weak, nonatomic) IBOutlet UILabel *lblTruckCompnay;
@property (weak, nonatomic) IBOutlet UILabel *lblTruckSupplier;

@property (weak, nonatomic) IBOutlet UITextField *txtStartHour;
@property (weak, nonatomic) IBOutlet UITextField *txtJobType;
@property (weak, nonatomic) IBOutlet UITextField *txtEndHour;
@property (weak, nonatomic) IBOutlet UITextField *txtLunchHour;
@property (weak, nonatomic) IBOutlet UITextField *txtTotalHour;
@property (weak, nonatomic) IBOutlet UITextField *txtDriverName;
@property (weak, nonatomic) IBOutlet UITextField *txtTruck;
@property (weak, nonatomic) IBOutlet UITextField *txtEquipment;
@property (weak, nonatomic) IBOutlet UITextField *txtMaterial;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UILabel *lblJobType;

- (IBAction)OnBackClick:(id)sender;
- (IBAction)OnSubmitClick:(id)sender;


@end
