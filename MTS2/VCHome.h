//
//  VCHome.h
//  MTS2
//
//  Created by Pritesh-Mac on 4/24/14.
//  Copyright (c) 2014 Pritesh-Mac. All rights reserved.
//


#define MSG_INTERNET @"Please check your internet connection!"
#define MSG_ENTER_CODE @"Please enter job code!"
#define MSG_INVALID_CODE @"Invalid job code!"
#define MSG_ERROR @"An Error occured while processing your request!"
//#define REQUEST_URL @"http://mtswebservice.showmydemo.net/JobMobileService.svc/GetJobSearchByJobCode/"
#define REQUEST_URL @"http://mtsservice.showdemonow.com/JobmobileService.svc/GetJobSearchByJobCode/"
#import <UIKit/UIKit.h>

@interface VCHome : UIViewController <UITextFieldDelegate>
{
  
}
- (IBAction)OnGoClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtCode;

@end
