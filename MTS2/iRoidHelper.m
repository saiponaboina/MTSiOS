#import "iRoidHelper.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>
#include "iToast.h"
@implementation iRoidHelper{
    Reachability *internetReachableFoo;
}
MBProgressHUD *HUD;
+(void)ShowAlert:(NSString*)msg{
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alert show];
}

+(void)ShowToast:(NSString*)msg{
    iToast *toastMessage=[[iToast alloc]initWithText:msg];
    [toastMessage show];
}

+(BOOL)IsInternetConnected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

+(void)ShowLoading : (UIViewController*) vc
{
	HUD = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
	HUD.dimBackground = YES;
	//HUD.delegate = self;
	HUD.labelText = @"Please wait...";
    [HUD show:YES];
}

+(void)HideLoading
{
    [HUD hide:YES];
}


@end
