//
//  UpdateJobVC.m
//  MTS2
//
//  Created by Pritesh-Mac on 4/29/14.
//  Copyright (c) 2014 Pritesh-Mac. All rights reserved.
//

#import "UpdateJobVC.h"
#import "iRoidHelper.h"

@interface UpdateJobVC ()

@end


@implementation UpdateJobVC

@synthesize lblTruckSupplier,lblDriver,lblEnd,lblJobSite,lblJobType,lblJobTypeText,lblLunch,lblStart,lblTotal,lblTrcukCompany,lblEquipment,lblMaterial,lblTruck,txtAuthCode,updatejob,scroller,view1,view2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
	lblJobSite.text = [updatejob valueForKey:@"DisplayJobsite"];
    lblTrcukCompany.text = [updatejob valueForKey:@"DisplayTruckCompany"];
    lblTruckSupplier.text = [updatejob valueForKey:@"DisplayTruckSupplier"];
    lblJobTypeText.text = [NSString stringWithFormat:@"%@ : ",[updatejob valueForKey:@"DisplayJobType"]];
    lblJobType.text = [updatejob valueForKey:@"DisplayJobType"];
    lblStart.text = [updatejob valueForKey:@"DisplayStartHour"];
    lblEnd.text = [updatejob valueForKey:@"DisplayEndHour"];
    lblLunch.text = [updatejob valueForKey:@"DisplayLunchHour"];
    lblTotal.text = [updatejob valueForKey:@"DisplayTotalHour"];
    lblDriver.text = [updatejob valueForKey:@"DisplayDriveName"];
    lblEquipment.text=[updatejob valueForKey:@"EquipmentTypeName"];
    lblMaterial.text=[updatejob valueForKey:@"MaterialTypeName"];
    lblTruck.text = [updatejob valueForKey:@"DisplayTruck"];
   
    [txtAuthCode setDelegate:self];
    [scroller setContentSize:CGSizeMake(320, 400)];
    
    if([[updatejob valueForKey:@"JobModeId"] integerValue] >1 ) {
        view1.hidden = YES;
        CGRect frame = view2.frame;
        frame.origin.y = 116;
        view2.frame = frame;
    }
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_0) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OnConfirmClick:(id)sender {
    
    if(![iRoidHelper IsInternetConnected])
    {
        [iRoidHelper ShowToast:MSG_INTERNET];
        return;
    }
    
    
    NSString *code = txtAuthCode.text;
    if(!code || [code isEqualToString:@""]){
        [iRoidHelper ShowToast:@"Please enter Authentication code !"];
    }
    else
    {
        [iRoidHelper ShowLoading:self];
        [self performSelector:@selector(ValidateJobByAuthenticationCode:) withObject:code afterDelay:0.1];
    }
}

- (IBAction)OnBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) ValidateJobByAuthenticationCode :(NSString *)AuthCode
{
    @try
    {
        NSString *request = [NSString stringWithFormat: @"%@/%@",AUTH_URL,AuthCode];
        NSURL *URL = [NSURL URLWithString:
                      [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:URL options:NSDataReadingUncached error:&error];
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(!error && responseString && ![responseString isEqualToString:@""])
        {
            if([responseString isEqualToString:@"true"]){
                [self UpdateJobTask:@"true"];
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:@"Wrong authentication code entered, do you want to continue?"
                                                               delegate:self
                                                      cancelButtonTitle:@"No"
                                                      otherButtonTitles:@"Yes",nil];
                [alert show];
                
                //[iRoidHelper ShowToast:MSG_INVALIAD_AUTH_CODE];
                
            }
        }
        else{
            [iRoidHelper HideLoading]; //EOW3ADRS
            [iRoidHelper ShowToast:MSG_ERROR];
        }
    }
    @catch (NSException *e) {
        [iRoidHelper HideLoading];
        [iRoidHelper ShowToast:MSG_ERROR];
    }
    
}

-(void) sendMail :(NSString *)jobDetailId
{
    @try
    {
        NSString *request = [NSString stringWithFormat: @"%@/%@",SEND_MAIL,jobDetailId];
        NSURL *URL = [NSURL URLWithString:
                      [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:URL options:NSDataReadingUncached error:&error];
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(!error && responseString && ![responseString isEqualToString:@""])
        {
            if([responseString isEqualToString:@"true"]){
                
            }
            else {
                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
//                                                                message:@"Wrong authentication code entered, do you want to continue?"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"No"
//                                                      otherButtonTitles:@"Yes",nil];
//                [alert show];
                
                //[iRoidHelper ShowToast:MSG_INVALIAD_AUTH_CODE];
                
            }
        }
        else{
            [iRoidHelper HideLoading]; //EOW3ADRS
            [iRoidHelper ShowToast:MSG_ERROR];
        }
    }
    @catch (NSException *e) {
        [iRoidHelper HideLoading];
        [iRoidHelper ShowToast:MSG_ERROR];
    }
    
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
         [self UpdateJobTask:@"false"];
    }
    else{
        [iRoidHelper HideLoading];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [scroller setContentOffset:CGPointMake(0, 220) animated:YES];
    return  YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [scroller setContentOffset:CGPointMake(0, 0) animated:YES];
    return  YES;
}

-(void) UpdateJobTask :(NSString*) IsForemanAuthorised
{
    NSArray *propertyNames = [NSArray arrayWithObjects:@"CreatedDateTime", @"DriverName",@"MaterialTypeId",@"EquipmentTypeId",@"IsDelegated", @"IsForemanAuthorised",@"JobAssignedId",@"JobEndDate",@"JobModeId",@"JobStartDate",@"JobTransactionDetailId",@"LunchTime",@"NumberOfHours",@"NumberOfTons",@"NumberOfLoad",@"NumberOfTrip",@"TruckNumber",@"UpdatedDateTime",@"AuthenticationText", nil];
    
   // NSArray *propertyNames = [NSArray arrayWithObjects:@"CreatedDateTime", @"DriverName", @"IsForemanAuthorised",@"JobDetailId",@"JobEndDate",@"JobId",@"JobModeId",@"JobStartDate",@"NumberOfHours",@"NumberOfLoad",@"NumberOfTrip",@"TruckId",@"TruckNumber",@"UpdatedDateTime", nil];

    
    NSArray *propertyValues = [NSArray arrayWithObjects: [updatejob valueForKey:@"CreatedDateTime"] , [updatejob valueForKey:@"DriverName"],[updatejob valueForKey:@"MaterialTypeId"],[updatejob valueForKey:@"EquipmentTypeId"],[NSNumber numberWithBool:YES] ,IsForemanAuthorised ,[updatejob valueForKey:@"JobAssignedId"],[updatejob valueForKey:@"JobEndDate"],[updatejob valueForKey:@"JobModeId"] ,[updatejob valueForKey:@"JobStartDate"] ,[updatejob valueForKey:@"JobTransactionDetailId"],[updatejob valueForKey:@"LunchTime"] ,[updatejob valueForKey:@"NumberOfHours"],[updatejob valueForKey:@"NumberOfTons"] ,[updatejob valueForKey:@"NumberOfLoad"] ,[updatejob valueForKey:@"NumberOfTrip"] ,[updatejob valueForKey:@"TruckNumber"] ,[updatejob valueForKey:@"UpdatedDateTime"],txtAuthCode.text, nil];
    
    NSDictionary *properties = [NSDictionary dictionaryWithObjects:propertyValues forKeys:propertyNames];
    
    
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:properties options:0 error:nil];
    NSString *jsonRequest=[[NSString alloc]initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:UPDATE_JOB_URL];
    
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url
                                                        cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLResponse* response;
    NSError* error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [iRoidHelper HideLoading];
    
    
    //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:NSJSONReadingMutableContainers
                          error:&error];
    if(json!=nil)
    {
        [iRoidHelper HideLoading];
        [iRoidHelper ShowToast:@"Job details updated successfully"];
        [self sendMail:[updatejob valueForKey:@"JobTransactionDetailId"]];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        [iRoidHelper ShowToast:MSG_ERROR];
    }
}


@end
