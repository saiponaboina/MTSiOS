//
//  AddJobVC.m
//  MTS2
//
//  Created by Pritesh-Mac on 4/25/14.
//  Copyright (c) 2014 Pritesh-Mac. All rights reserved.
//



#import "AddJobVC.h"
#import "UpdateJobVC.h"
#import "BSKeyboardControls.h"
#import "iRoidHelper.h"
#define IOS_NEWER_THAN(x) ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] > x )
#define IOS_OLDER_THAN_(x) ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] < x )
#define IOS_NEWER_OR_EQUAL_TO_(x) ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= x )

@interface AddJobVC () {
    int ACTIVE_SELECTION ;
    NSDate *start, *end;
    NSArray *arrLunch,*arrEquipMent,*arrMaterial;
    UIPickerView *pkrLunchtime,*pkrJobType,*pkrEquipMent,*pkrMaterial;
    UIActionSheet *menu;
    NSMutableArray *arrJobType,*arrJobTypeServer;
    int last_selection ;
    int equipMentVal,materialVal;
}

@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

@end

@implementation AddJobVC {
    
}

@synthesize txtDriverName,txtEndHour,txtStartHour,txtTotalHour,txtTruck,txtLunchHour,txtJobType,lblJobsite,lblJobType,lblTruckCompnay,lblTruckSupplier,job,view1,view2,scrollview,txtEquipment,txtMaterial;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) initPickers{
    
    pkrLunchtime = [[UIPickerView alloc] init];
    [pkrLunchtime setDelegate:self];
    [pkrLunchtime setDataSource:self];
    [pkrLunchtime setTag : 1];
    [pkrLunchtime setShowsSelectionIndicator:YES];
    [pkrLunchtime selectRow:0 inComponent:0 animated:YES];
    if(IOS_NEWER_OR_EQUAL_TO_(7.0))
        pkrLunchtime.frame = CGRectMake(0, 40, self.view.frame.size.width, 180);
    else
        pkrLunchtime.frame = CGRectMake(10, 40, self.view.frame.size.width, 180);
    [pkrLunchtime setBackgroundColor:[UIColor whiteColor]];
    [pkrLunchtime selectRow:0 inComponent:0 animated:NO];
    
    pkrJobType = [[UIPickerView alloc] init];
    [pkrJobType setDelegate:self];
    [pkrJobType setDataSource:self];
    [pkrJobType setTag : 2];
    [pkrJobType setShowsSelectionIndicator:YES];
    if(IOS_NEWER_OR_EQUAL_TO_(7.0))
        pkrJobType.frame = CGRectMake(0, 40, self.view.frame.size.width, 216);
    else
        pkrJobType.frame = CGRectMake(10, 40, self.view.frame.size.width, 216);
    [pkrJobType setBackgroundColor:[UIColor whiteColor]];
    [pkrJobType selectRow:1 inComponent:0 animated:YES];
    
    
    pkrEquipMent = [[UIPickerView alloc] init];
    [pkrEquipMent setDelegate:self];
    [pkrEquipMent setDataSource:self];
    [pkrEquipMent setTag : 3];
    [pkrEquipMent setShowsSelectionIndicator:YES];
    [pkrEquipMent selectRow:0 inComponent:0 animated:YES];
    if(IOS_NEWER_OR_EQUAL_TO_(7.0))
        pkrEquipMent.frame = CGRectMake(0, 40, self.view.frame.size.width, 216);
    else
        pkrEquipMent.frame = CGRectMake(10, 40, self.view.frame.size.width, 216);
    [pkrEquipMent setBackgroundColor:[UIColor whiteColor]];
    [pkrEquipMent selectRow:0 inComponent:0 animated:NO];
    
    pkrMaterial = [[UIPickerView alloc] init];
    [pkrMaterial setDelegate:self];
    [pkrMaterial setDataSource:self];
    [pkrMaterial setTag : 4];
    [pkrMaterial setShowsSelectionIndicator:YES];
    [pkrMaterial selectRow:0 inComponent:0 animated:YES];
    if(IOS_NEWER_OR_EQUAL_TO_(7.0))
        pkrMaterial.frame = CGRectMake(0, 40, self.view.frame.size.width, 216);
    else
        pkrMaterial.frame = CGRectMake(10, 40, self.view.frame.size.width, 216);
    [pkrMaterial setBackgroundColor:[UIColor whiteColor]];
    [pkrMaterial selectRow:0 inComponent:0 animated:NO];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [txtStartHour setDelegate:self];
    [txtEndHour setDelegate:self];
    [txtLunchHour setDelegate:self];
    txtTotalHour.enabled=NO;
    equipMentVal=1;
    materialVal=2;
    arrLunch = [NSArray arrayWithObjects:@"0:30 Hour",@"1:00 Hour",@"1:30 Hour",@"2:00 Hour",@"2:30 Hour",@"3:00 Hour" , nil];
   // arrJobType = [NSMutableArray arrayWithObjects:@"Number of Hours", @"Total Loads", @"Total Trips",@"Total Tons" , nil];

//    arrEquipMent=[NSArray arrayWithObjects:@"Tandem truck",@"Tri-axle tandem truck",@"End-dump trailer",@"Belly dump",@"Flat-bed trailer",@"High Capacity Demo Trailer",@"Low-boy trailer",@"Crane",@"Dozer",@"Loader",@"Trackhoe",@"General Laborer", nil];
    
    
    
    ACTIVE_SELECTION = 1 ;
    last_selection = 0;
    start = [NSDate date];
    end = [NSDate date];
    
    self.navigationController.navigationBarHidden  = YES;
    lblJobsite.text = [job valueForKey:@"JobSiteName"];
    lblTruckCompnay.text = [job valueForKey:@"TruckSupplierCompany"];
    lblTruckSupplier.text = [job valueForKey:@"TruckSupplierName"];
    
    scrollview.contentSize = CGSizeMake(320, 600);
    scrollview.showsVerticalScrollIndicator = NO;
    
    NSArray *fields = @[txtTotalHour,txtDriverName,txtTruck,txtEquipment];
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_0) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    [self initPickers];
    [self getEquipmenttypefromServer];
    [self getMaterialtypefromServer];
    [self getJobModefromServer];
    // [self postDataToUrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)OnBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)OnSubmitClick:(id)sender {
    
    
    if(![iRoidHelper IsInternetConnected])
    {
        [iRoidHelper ShowToast:MSG_INTERNET];
        return;
    }
    
    
    NSString *starthour = txtStartHour.text;
    NSString *endhour = txtEndHour.text;
    NSString *total = txtTotalHour.text;
    NSString *driver = txtDriverName.text;
    NSString *truck = txtTruck.text;
   
    NSString *error = @"";
    
    
    [self IsSelectedTimesAreCorrect];
    
    if([pkrJobType selectedRowInComponent:0]==1)
    {
        if(!starthour || [starthour isEqualToString:@""]){
            error = [error stringByAppendingString:@"-Please select Starting hour\n"];
        }
        if(!endhour || [endhour isEqualToString:@""]){
            error = [error stringByAppendingString:@"-Please select Ending hour\n"];
        }
    }
    
    if(!total || [total isEqualToString:@""]){
        error = [error stringByAppendingString: [NSString stringWithFormat:@"-Please enter %@\n", [arrJobType objectAtIndex:[pkrJobType selectedRowInComponent:0]]]];
    }
    
    if(!driver || [driver isEqualToString:@""]){
        error = [error stringByAppendingString:@"-Please enter Driver name\n"];
    }
    if(!truck || [truck isEqualToString:@""]){
        error = [error stringByAppendingString:@"-Please enter Truck\n"];
    }
    
    if([error isEqualToString:@""]){
        [iRoidHelper ShowLoading:self];
        [self performSelector:@selector(AddJob) withObject:nil afterDelay:0.1];
    }
    else{
        [iRoidHelper ShowToast :error];
    }
    
}


-(BOOL)validateJob_For_Today : (NSDictionary*)ParamDict
{
    //    SERVICE : http://mtsservice.showdemonow.com/JobMobileService.svc/IsJobTransaxnExist
    //
    //PARAMS:
    //    {"DriverName":"MAXXP","IsJobTransaxnExist":false,"JobAssignedId":67,"JobModeId":2,"TruckNumber":"DF5888D"}
    //
    //    Return Value : True/False. True - already present. so system should NOT allow to save the transaction. it should display "Transaction has already been entered for the day"
    
    NSDictionary *properties=[[NSDictionary alloc]initWithObjectsAndKeys:[ParamDict valueForKey:@"DriverName"],@"DriverName",@"false",@"IsJobTransaxnExist",[ParamDict valueForKey:@"JobAssignedId"],@"JobAssignedId",[ParamDict valueForKey:@"JobModeId"],@"JobModeId",[ParamDict valueForKey:@"TruckNumber"],@"TruckNumber", nil];
    
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:properties options:0 error:nil];
    NSString *jsonRequest=[[NSString alloc]initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:CHECK_JOB_EXISTING];
    
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
    
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:NSJSONReadingMutableContainers
                          error:&error];
    if(![responseString boolValue])
    {
        return YES;
    }
    else {
        [iRoidHelper ShowToast:MSG_ERROR];
    }
    
    return NO;
    
}

-(void)getEquipmenttypefromServer
{
    @try
    {
        NSString *request = [NSString stringWithFormat: @"%@",GET_EQUIPMENT_TYPE];
        NSURL *URL = [NSURL URLWithString:
                      [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:URL options:NSDataReadingUncached error:&error];
        if(!error)
        {
            NSArray *json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
          
            if([json count]>0)
            {
                arrEquipMent=[NSArray arrayWithArray:json];
            }
            else
            {
                [iRoidHelper ShowToast:@"No Equipment!"];
            }
        }
        
        
        //        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:REQUEST_URL]];
        //        [request setHTTPMethod:@"POST"];
        //        [request setHTTPBody:[JobCode dataUsingEncoding:NSUTF8StringEncoding]];
        //
        //        // generates an autoreleased NSURLConnection
        //        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    @catch (NSException *e) {
        [iRoidHelper ShowToast:MSG_ERROR];
    }
    @finally {
        [iRoidHelper HideLoading];
    }
}

-(void)getJobModefromServer
{
    @try
    {
        NSString *request = [NSString stringWithFormat: @"%@",GET_JOB_MODE];
        NSURL *URL = [NSURL URLWithString:
                      [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:URL options:NSDataReadingUncached error:&error];
        if(!error)
        {
            NSArray *json = [NSJSONSerialization
                             JSONObjectWithData:data
                             options:NSJSONReadingMutableContainers
                             error:&error];
            
            if([json count]>0)
            {
                arrJobTypeServer=[NSMutableArray arrayWithArray:json];
                arrJobType=[arrJobTypeServer mutableCopy];
            }
            else
            {
                [iRoidHelper ShowToast:@"No Equipment!"];
            }
        }
        
        
        //        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:REQUEST_URL]];
        //        [request setHTTPMethod:@"POST"];
        //        [request setHTTPBody:[JobCode dataUsingEncoding:NSUTF8StringEncoding]];
        //
        //        // generates an autoreleased NSURLConnection
        //        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    @catch (NSException *e) {
        [iRoidHelper ShowToast:MSG_ERROR];
    }
    @finally {
        [iRoidHelper HideLoading];
    }
}


-(void)getMaterialtypefromServer
{
    @try
    {
        NSString *request = [NSString stringWithFormat: @"%@",GET_MATERIAL_TYPE];
        NSURL *URL = [NSURL URLWithString:
                      [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:URL options:NSDataReadingUncached error:&error];
        if(!error)
        {
            NSArray *json = [NSJSONSerialization
                             JSONObjectWithData:data
                             options:NSJSONReadingMutableContainers
                             error:&error];
            
            if([json count]>0)
            {
                arrMaterial=[NSArray arrayWithArray:json];
            }
            else
            {
                [iRoidHelper ShowToast:@"No Material!"];
            }
        }
        
        
        //        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:REQUEST_URL]];
        //        [request setHTTPMethod:@"POST"];
        //        [request setHTTPBody:[JobCode dataUsingEncoding:NSUTF8StringEncoding]];
        //
        //        // generates an autoreleased NSURLConnection
        //        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    @catch (NSException *e) {
        [iRoidHelper ShowToast:MSG_ERROR];
    }
    @finally {
        [iRoidHelper HideLoading];
    }
}


- (void)ShowPicker :(int) tag {
//    menu = [[UIActionSheet alloc] initWithTitle:@""
//                                       delegate:self
//                              cancelButtonTitle:nil
//                         destructiveButtonTitle:nil
//                              otherButtonTitles:nil];
//    
//    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
//    closeButton.momentary = YES;
//    closeButton.frame = CGRectMake(275, 6.0f, 50.0f, 30.0f);
//    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
//    closeButton.tintColor = [UIColor blackColor];
//    [closeButton addTarget:self action:@selector(DoneButtonPressed) forControlEvents:UIControlEventValueChanged];
//    [menu addSubview:closeButton];
    if(tag ==1)
    {
        //[menu addSubview :pkrLunchtime];
        //self.txtLunchHour.inputView=pkrLunchtime;
        [self createAndShowlunchPicker];
    }
    else if(tag ==2){
        //[menu addSubview :pkrJobType];
        
        [self createAndShowjobTypePicker];
    }
    else if(tag== 3)
    {
        [self createAndShowequipMentPicker];
    }
    else
    {
        [self createAndShowMaterialPicker];
    }
    //[menu showInView:self.view.superview];
    //[menu setBounds:CGRectMake(0, 0, 345, 380)];
    //menu.frame = CGRectMake(0, self.view.frame.size.height - 280, self.view.frame.size.width, 280);
    //[menu setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(void)createAndShowlunchPicker
{
    txtLunchHour.inputView = pkrLunchtime ;
    txtLunchHour.delegate = self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    [toolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneButtonPressed)];
    
    [barItems addObject:doneBtn];
    [toolbar setItems:barItems animated:YES];
    
    txtLunchHour.inputAccessoryView = toolbar;
}

-(void)createAndShowjobTypePicker
{
    txtJobType.inputView = pkrJobType ;
    txtJobType.delegate = self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    [toolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneButtonPressed)];
    [barItems addObject:doneBtn];
    [toolbar setItems:barItems animated:YES];
    
    txtJobType.inputAccessoryView = toolbar;
}

-(void)createAndShowMaterialPicker
{
    txtMaterial.inputView = pkrMaterial ;
    txtMaterial.delegate = self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    [toolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneButtonPressed)];
    [barItems addObject:doneBtn];
    [toolbar setItems:barItems animated:YES];
    
    txtMaterial.inputAccessoryView = toolbar;
}

-(void)createAndShowequipMentPicker
{
    txtEquipment.inputView = pkrEquipMent ;
    txtEquipment.delegate = self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    [toolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneButtonPressed)];
    [barItems addObject:doneBtn];
    [toolbar setItems:barItems animated:YES];
    
    txtEquipment.inputAccessoryView = toolbar;
}

-(void)DoneButtonPressed
{
    if([txtJobType.text isEqualToString:@"Total Hours"])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm a"];
        
        //NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *selectedDate = (ACTIVE_SELECTION==1) ? start : end;
       // NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:selectedDate];
        //NSInteger hour = [components hour];
        //NSInteger minute = [components minute];
        
        if(ACTIVE_SELECTION==1)
            txtStartHour.text = [dateFormatter stringFromDate:selectedDate];
        else
            txtEndHour.text = [dateFormatter stringFromDate:selectedDate];
        
        
        [self IsSelectedTimesAreCorrect];
    }
    [scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    [txtEquipment resignFirstResponder];
    [txtMaterial resignFirstResponder];
    [txtJobType resignFirstResponder];
    [txtLunchHour resignFirstResponder];
    [txtEndHour resignFirstResponder];
    [txtStartHour resignFirstResponder];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1)
    {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm a"];
        
      //  NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *selectedDate = (ACTIVE_SELECTION==1) ? start : end;
        //NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:selectedDate];
       // NSInteger hour = [components hour];
        //NSInteger minute = [components minute];
        if(ACTIVE_SELECTION==1)
            txtStartHour.text = [dateFormatter stringFromDate:selectedDate];
        else
            txtEndHour.text = [dateFormatter stringFromDate:selectedDate];
        
        [self IsSelectedTimesAreCorrect];
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == txtStartHour || textField == txtEndHour)
    {
        ACTIVE_SELECTION = [textField tag];
        [self OpenDatePicker : (ACTIVE_SELECTION==1) ? start : end];
       // return FALSE;
    }
    else if(textField == txtLunchHour){
        [self ShowPicker : 1];
        //return FALSE;
    }
    else if(textField == txtJobType){
        [self ShowPicker : 2];
       // return FALSE;
    }
    else if (textField==txtEquipment)
    {
        [self ShowPicker:3];
    }
    else if (textField==txtMaterial)
    {
        [self ShowPicker:4];
    }
    
    return TRUE;
}

- (void) OpenDatePicker :(NSDate*) date{
    
   /* menu = [[UIActionSheet alloc] initWithTitle:nil
                                       delegate:self
                              cancelButtonTitle:nil
                         destructiveButtonTitle:@"Cancel"
                              otherButtonTitles:@"Select",nil];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    datePicker.datePickerMode = UIDatePickerModeTime;
    [datePicker setDate :date];
    
    menu.delegate=self;
    [menu addSubview:datePicker];
    [menu showInView:self.view];
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_0) {
        menu.frame = CGRectMake(0, self.view.frame.size.height - 280, self.view.frame.size.width, 280);
        datePicker.frame = CGRectMake(0, 80, self.view.frame.size.width, 280);
    }
    else{
        menu.frame = CGRectMake(0, self.view.frame.size.height - 325, self.view.frame.size.width, 325);
        datePicker.frame = CGRectMake(0, 125, self.view.frame.size.width, 325);
    }
    
    
    [menu setBackgroundColor:[UIColor whiteColor]];*/
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    datePicker.datePickerMode = UIDatePickerModeTime;
    [datePicker setDate :date];
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_0) {
        menu.frame = CGRectMake(0, self.view.frame.size.height - 280, self.view.frame.size.width, 280);
        datePicker.frame = CGRectMake(0, 80, self.view.frame.size.width, 280);
    }
    else{
        menu.frame = CGRectMake(0, self.view.frame.size.height - 325, self.view.frame.size.width, 325);
        datePicker.frame = CGRectMake(0, 125, self.view.frame.size.width, 325);
    }
    
    [datePicker setBackgroundColor:[UIColor whiteColor]];
    
    txtStartHour.inputView=datePicker;
    txtStartHour.delegate=self;
    
    txtEndHour.inputView=datePicker;
    txtEndHour.delegate=self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    [toolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneButtonPressed)];
    [barItems addObject:doneBtn];
    [toolbar setItems:barItems animated:YES];
    
    txtStartHour.inputAccessoryView = toolbar;
    txtEndHour.inputAccessoryView=toolbar;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [keyboardControls.activeField resignFirstResponder];
    [scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([txtJobType.text isEqualToString:@"Total Hours"])
    {
        if(txtStartHour==textField)
            [scrollview setContentOffset:CGPointMake(0, 70) animated:YES];
        else if(txtEndHour==textField)
            [scrollview setContentOffset:CGPointMake(0, 100) animated:YES];
        else if(txtTotalHour==textField)
            [scrollview setContentOffset:CGPointMake(0, 200) animated:YES];
        else if(txtDriverName==textField)
            [scrollview setContentOffset:CGPointMake(0, 245) animated:YES];
        else if(txtLunchHour==textField)
            [scrollview setContentOffset:CGPointMake(0, 140) animated:YES];
        else if (txtTruck==textField)
            [scrollview setContentOffset:CGPointMake(0, 335) animated:YES];
    }
    else{
        if(txtStartHour==textField)
            [scrollview setContentOffset:CGPointMake(0, 70 - 140) animated:YES];
       else if(txtEndHour==textField)
            [scrollview setContentOffset:CGPointMake(0, 100) animated:YES];
        else if(txtTotalHour==textField)
            [scrollview setContentOffset:CGPointMake(0, 200 - 140) animated:YES];
        else if(txtDriverName==textField)
            [scrollview setContentOffset:CGPointMake(0, 245 - 130) animated:YES];
        else if(txtLunchHour==textField )
            [scrollview setContentOffset:CGPointMake(0, 140 - 140) animated:YES];
        else if (txtTruck==textField)
            [scrollview setContentOffset:CGPointMake(0, 335 - 140) animated:YES];
    }
    [self.keyboardControls setActiveField:textField];
}

-(void) dueDateChanged:(UIDatePicker *)sender {
    if(ACTIVE_SELECTION == 1)
    {
        start = sender.date;
    }
    else
    {
        end = sender.date;
    } [self IsSelectedTimesAreCorrect];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if([pickerView tag]==1)
    {
        txtLunchHour.text = [arrLunch objectAtIndex:[pickerView selectedRowInComponent:0]];
        //txtTotalHour.enabled = NO;
       // txtLunchHour.userInteractionEnabled = NO;
        [self IsSelectedTimesAreCorrect];
    }
    else if (pickerView.tag==3)
    {
        txtEquipment.text=[[arrEquipMent objectAtIndex:[pickerView selectedRowInComponent:0]] valueForKey:@"EquipmentTypeName"];
        equipMentVal=[[[arrEquipMent objectAtIndex:[pickerView selectedRowInComponent:0]] valueForKey:@"EquipmentTypeId"] intValue];
        if ([txtEquipment.text isEqualToString:@"General Laborer"]||[txtEquipment.text isEqualToString:@"Crane"])
        {
            txtMaterial.enabled=NO;
            txtTotalHour.enabled=NO;
            [arrJobType removeAllObjects];
            [arrJobType addObject: [arrJobTypeServer objectAtIndex:1]];
            txtJobType.text = [[arrJobType objectAtIndex:0]valueForKey:@"Mode"];
            lblJobType.text = [[arrJobType objectAtIndex:0]valueForKey:@"Mode"];
            
            view1.hidden = NO;
            CGRect frame = view2.frame;
            frame.origin.y = 357;
            view2.frame = frame;
        }
        else
        {
            txtMaterial.enabled=YES;
            [arrJobType removeAllObjects];
            arrJobType=[arrJobTypeServer mutableCopy];
        }
    }
    else if (pickerView.tag==4)
    {
        txtMaterial.text=[[arrMaterial objectAtIndex:[pickerView selectedRowInComponent:0]] valueForKey:@"MaterialTypeName"];
        materialVal=[[[arrMaterial objectAtIndex:[pickerView selectedRowInComponent:0]] valueForKey:@"MaterialTypeId"] intValue];
    }
    else {
        txtJobType.text = [[arrJobType objectAtIndex:[pickerView selectedRowInComponent:0]]valueForKey:@"Mode"];
        lblJobType.text = [[arrJobType objectAtIndex:[pickerView selectedRowInComponent:0]]valueForKey:@"Mode"];
        txtTotalHour.enabled = YES;
        txtLunchHour.userInteractionEnabled = YES;
        last_selection = row;
       
        if([txtJobType.text isEqualToString:@"Total Hours"])
        {
            txtTotalHour.enabled=NO;
            view1.hidden = NO;
            CGRect frame = view2.frame;
            frame.origin.y = 357;
            view2.frame = frame;
            txtTotalHour.text = @"";
        }
        else{
           
            view1.hidden = YES;
            CGRect frame = view2.frame;
            frame.origin.y = 225;
            view2.frame = frame;
            txtTotalHour.text = @"";
        }
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if([pickerView tag]==1)
    {
        return arrLunch.count;
    }
    else if([pickerView tag]==2){
        return arrJobType.count;
    }
    else if([pickerView tag]==3)
    {
        return arrEquipMent.count;
    }
    else
    {
        return arrMaterial.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag==1){
        return [arrLunch objectAtIndex: row];
    }
    else if(pickerView.tag==2) {
        return [[arrJobType objectAtIndex: row] valueForKey:@"Mode"];
    }
    else if(pickerView.tag==3)
    {
        return [[arrEquipMent objectAtIndex:row] valueForKey:@"EquipmentTypeName"];
    }
    else
    {
        return [[arrMaterial objectAtIndex:row] valueForKey:@"MaterialTypeName"];
    }
    return @"";
}

-(BOOL) IsSelectedTimesAreCorrect{
    
    NSString *starthour = txtStartHour.text;
    NSString *endhour = txtEndHour.text;
    
    
    if(![txtJobType.text isEqualToString:@"Total Hours"])
        return YES;
    
    if(starthour && endhour && ![starthour isEqualToString:@""] && ![endhour isEqualToString:@""]){
        
        @try {
            long end1 =  [end timeIntervalSince1970] ;
            long start1 = [start timeIntervalSince1970] ;
            
            if((end1 -start1)<=0){
                [iRoidHelper ShowToast: MSG_INCORRECT_END_TIME];
                return NO;
            }
            
            long lunch=0.0f;
            
            if ([[txtLunchHour.text stringByReplacingOccurrencesOfString:@" Hour" withString:@""] isEqualToString:@"0:30"]) {
                lunch = 0.30 * 60 * 60;
                
            }
            else if ([[txtLunchHour.text stringByReplacingOccurrencesOfString:@" Hour" withString:@""] isEqualToString:@"1:00"])
            {
                lunch = 1.00 * 60 * 60;
            }
            else if ([[txtLunchHour.text stringByReplacingOccurrencesOfString:@" Hour" withString:@""] isEqualToString:@"1:30"])
            {
                lunch = 1.30 * 60 * 60;
            }
            else if ([[txtLunchHour.text stringByReplacingOccurrencesOfString:@" Hour" withString:@""] isEqualToString:@"2:00"])
            {
                lunch = 2.00 * 60 * 60;
            }
            else if ([[txtLunchHour.text stringByReplacingOccurrencesOfString:@" Hour" withString:@""] isEqualToString:@"2:30"])
            {
                lunch = 2.30 * 60 * 60;
            }
            else
            {
                lunch = 3.00 * 60 * 60;
            }
            
            
            
            double diff = end1 - start1 - lunch;
            
            if(diff<=0){
                [iRoidHelper ShowToast: MSG_INCORRECT_LUNCHY_TIME];
                [pkrLunchtime selectRow:0 inComponent:0 animated:NO];
                txtLunchHour.text = [arrLunch objectAtIndex:0];
                return NO;
            }
            
            
            int minutes = (int) (((int)diff / ( 60)) % 60);
            if (minutes>12) {
                minutes=minutes-12;
            }
            
            int hours = (int) (((int)diff / ( 60 * 60)) % 24);
            
            NSString *minutesToShow = (minutes < 10) ? [NSString stringWithFormat:@"0%d",minutes] : [NSString stringWithFormat:@"%d",minutes];
            NSString *hoursToShow = (hours < 10) ? [NSString stringWithFormat:@"0%d",hours] : [NSString stringWithFormat:@"%d",hours];
            
            txtTotalHour.text = [NSString stringWithFormat:@"%@:%@",hoursToShow,minutesToShow];
            
            NSLog(@"%g",diff);
            
            return YES;
        }
        @catch (NSException *exception) {
            return NO;
        }
    }
    return  NO;
    
}

-(void)AddJob
{
    
//    {"CreatedDateTime":"\/Date(1421527239596+0530)\/","DriverName":"Mac De R","IsDelegated":false,"IsForemanAuthorised":false,"JobAssignedId":1,"JobEndDate":"\/Date(1421527239597+0530)\/","JobModeId":2,"JobStartDate":"\/Date(1421527239601+0530)\/","JobTransactionDetailId":0,"LunchTime":0,"NumberOfHours":2,"NumberOfLoad":3,"NumberOfTons":0,"NumberOfTrip":0,"TruckNumber":"XD 8F45","UpdatedDateTime":"\/Date(1421527239603+0530)\/"}
    
//    "NumberOfHours":5,
//    "LunchTime":0,
//    "NumberOfTons":0,
//    "JobModeId":4,
//    "JobEndDate":"\/Date(72720000+0530)\/",
//    "AuthenticationText":"",
//    "DriverName":"dilbar",
//    "TruckNumber":"truck",
//    "JobTransactionDetailId":0,
//    "NumberOfLoad":0,
//    "NumberOfTrip":0,
//    "JobStartDate":"\/Date(51120000+0530)\/",
//    "UpdatedDateTime":"\/Date(1424365971180+0530)\/",
//    "IsDelegated":false,
//    "CreatedDateTime":"\/Date(1424365970519+0530)\/",
//    "JobAssignedId":1,
//    "IsForemanAuthorised":false

    
    
    
    
    NSArray *propertyNames = [NSArray arrayWithObjects:@"CreatedDateTime", @"DriverName",@"EquipmentTypeId",@"MaterialTypeId",@"IsDelegated", @"IsForemanAuthorised",@"JobAssignedId",@"JobEndDate",@"JobModeId",@"JobStartDate",@"JobTransactionDetailId",@"LunchTime",@"NumberOfHours",@"NumberOfTons",@"NumberOfLoad",@"NumberOfTrip",@"TruckNumber",@"UpdatedDateTime",@"AuthenticationText", nil];
    
    //  NSArray *propertyValues = [NSArray arrayWithObjects:@"/Date(1396290465662+0530)/", @"Mac De R", @"false",[NSNumber numberWithInt:0],@"/Date(1396290465662+0530)/",[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],@"/Date(1396290465662+0530)/",[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:0],[NSNumber numberWithInt:3],@"XD 8F45",@"/Date(1396290465662+0530)/",  nil];
    
    NSString *driver = txtDriverName.text;
    NSString *truck = txtTruck.text;
    double NumberOfHours = 0;
    double NumberOfLoad = 0;
    double NumberOfTrip = 0;
    double NumberOfTons = 0;
    NSObject *stDate = [NSNull null],*enDate = [NSNull null];
    
   // NSString *equipMentType=txtEquipment.text;
    
//    int equipMentVal=[arrEquipMent indexOfObject:equipMentType];
//    equipMentVal=equipMentVal+1;
    NSString *equipMentID=[NSString stringWithFormat:@"%d",equipMentVal];
    NSString *materialTypeID=[NSString stringWithFormat:@"%d",materialVal];
    
    //NSString *TruckId = [job valueForKey:@"TruckSupplierId"];
    
    int JobMode =(int) [pkrJobType selectedRowInComponent:0];
    stDate=   [NSString stringWithFormat:@"/Date(%lld+0530)/",(long long)[start timeIntervalSince1970] * 1000];
    enDate=   [NSString stringWithFormat:@"/Date(%lld+0530)/",(long long)[end timeIntervalSince1970] * 1000];
    
    if([[[arrJobType objectAtIndex:JobMode]valueForKey:@"Mode"]isEqualToString:@"Number of Hours"]){
        NSArray *values = [[txtTotalHour text] componentsSeparatedByString:@":" ];
        NumberOfLoad = 0;
        NumberOfTrip = 0;
        NumberOfTons = 0;
        JobMode=3;
        NumberOfHours = [[values objectAtIndex:0] integerValue]*3600  +  [[values objectAtIndex:1] integerValue]*60;
       
    }
    else if([[[arrJobType objectAtIndex:JobMode]valueForKey:@"Mode"]isEqualToString:@"Number of Loads"]){
        NumberOfLoad = [[txtTotalHour text] doubleValue];
        NumberOfTrip = 0;
        NumberOfHours = 0;
        NumberOfTons = 0;
        JobMode=4;
    }
    else if([[[arrJobType objectAtIndex:JobMode]valueForKey:@"Mode"]isEqualToString:@"Number of Yards"]){
        NumberOfLoad = 0;
        NumberOfTrip = [[txtTotalHour text] doubleValue];
        NumberOfHours = 0;
        NumberOfTons = 0;
        JobMode=5;
    }
    else if([[[arrJobType objectAtIndex:JobMode]valueForKey:@"Mode"]isEqualToString:@"No of Tons"]){
        NumberOfLoad = 0;
        NumberOfTons = [[txtTotalHour text] doubleValue];
        NumberOfTrip =0;
        NumberOfHours = 0;
        JobMode=2;
    }
    
    int lunchTime=[[txtLunchHour text] floatValue]*60.0;
    
    
    NSArray *propertyValues = [NSArray arrayWithObjects:[NSString stringWithFormat:@"/Date(%lld+0530)/",(long long)[[NSDate date] timeIntervalSince1970] * 1000], driver,equipMentID,materialTypeID, @"false",@"false",[job valueForKey:@"JobAssignedId"],enDate,[NSNumber numberWithInt:JobMode],stDate,[NSNumber numberWithInt:0],[NSNumber numberWithInt:lunchTime],[NSNumber numberWithInt : NumberOfHours],[NSNumber numberWithInt : NumberOfTons],[NSNumber numberWithInt:NumberOfLoad],[NSNumber numberWithInt:NumberOfTrip],[NSString stringWithFormat:@"%@",truck] ,[NSString stringWithFormat:@"/Date(%lld+0530)/",(long long)[[NSDate date] timeIntervalSince1970] * 1000],@"",  nil];
    
    NSDictionary *properties = [NSDictionary dictionaryWithObjects:propertyValues forKeys:propertyNames];
    
    
    BOOL isJobExist=[self validateJob_For_Today:properties];
    
    
    if (isJobExist)
    {
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:properties options:0 error:nil];
        NSString *jsonRequest=[[NSString alloc]initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        NSURL *url=[NSURL URLWithString:ADD_JOB_REQUEST_URL];
        
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
        
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:NSJSONReadingMutableContainers
                              error:&error];
        if(json!=nil)
        {
            job = [json objectForKey:@"AddJobDetailResult"];
            [job setValue:lblJobsite.text forKey:@"DisplayJobsite"];
            [job setValue:lblTruckCompnay.text forKey:@"DisplayTruckCompany"];
            [job setValue:lblTruckSupplier.text forKey:@"DisplayTruckSupplier"];
            [job setValue:txtJobType.text forKey:@"DisplayJobType" ];
            [job setValue:txtStartHour.text forKey:@"DisplayStartHour" ];
            [job setValue:txtEndHour.text forKey:@"DisplayEndHour" ];
            [job setValue:txtLunchHour.text forKey:@"DisplayLunchHour"];
            
            NSLog(@"%@",txtTotalHour.text);
            [job setValue:txtEquipment.text forKey:@"EquipmentTypeName"];
            [job setValue:txtMaterial.text forKey:@"MaterialTypeName"];
            [job setValue:txtTotalHour.text forKey:@"DisplayTotalHour"];
            [job setValue:txtDriverName.text forKey:@"DisplayDriveName" ];
            [job setValue:txtTruck.text forKey:@"DisplayTruck" ];
            [self performSegueWithIdentifier:@"segToUpdateJob" sender:nil];
            NSLog(@"the final output is:%@",responseString);
        }
        else {
            [iRoidHelper ShowToast:MSG_ERROR];
        }
        
    }
    else
    {
        [iRoidHelper ShowToast:JOB_EXIST];
    }
    // return responseData;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segToUpdateJob"]) {
        UpdateJobVC *viewController = [segue destinationViewController];
        viewController.updatejob = job;
    }
}

@end
