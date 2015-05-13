//
//  VCHome.m
//  MTS2
//
//  Created by Pritesh-Mac on 4/24/14.
//  Copyright (c) 2014 Pritesh-Mac. All rights reserved.
//

#import "VCHome.h"
#import "iRoidHelper.h"
#import "AddJobVC.h"



@interface VCHome ()

@end


@implementation VCHome {
    NSMutableDictionary *dict;
}
@synthesize txtCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
	[txtCode setDelegate:self];
    //txtCode.text=@"Testing";
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_0) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
//    txtCode.layer.borderColor = [UIColor colorWithRed:78/255.f green:129/255.f blue:142/255.f alpha:1].CGColor;
//    txtCode.layer.cornerRadius = 6;
//    txtCode.layer.borderWidth=1.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)OnGoClick:(id)sender {
    
    if([iRoidHelper IsInternetConnected])
    {
        NSString *code = [txtCode.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        if([code length]==0) {
            [iRoidHelper ShowToast:MSG_ENTER_CODE];
        }
        else
        {
            [txtCode resignFirstResponder];
            [iRoidHelper ShowLoading:self];
            [self performSelector:@selector(GetData:) withObject:code afterDelay:0.1];
            //[self GetData:code];
        }
    }
    else
    {
        [iRoidHelper ShowToast:MSG_INTERNET];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == txtCode) {
        [textField resignFirstResponder];
    }
    return NO;
}


-(void) GetData :(NSString *)JobCode
{    
    @try
    {
        NSString *request = [NSString stringWithFormat: @"%@%@",REQUEST_URL,JobCode];
        NSURL *URL = [NSURL URLWithString:
                      [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:URL options:NSDataReadingUncached error:&error];
        if(!error)
        {
            NSDictionary *json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            dict = [json objectForKey:@"GetJobSearchByJobCodeResult"];
            if([dict valueForKey:@"JobSiteId"]  != [NSNull null])
            {
                 [self performSegueWithIdentifier:@"segToAddJob" sender:nil];
            }
            else
            {
                [iRoidHelper ShowToast:MSG_INVALID_CODE];
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

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    NSLog(@"%@",response.description);
//}
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segToAddJob"]) {
        AddJobVC *viewController = [segue destinationViewController];
        viewController.job = dict;
    }
}

@end
