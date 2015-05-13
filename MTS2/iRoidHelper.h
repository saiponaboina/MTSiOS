//
//  SAhelper.h
//  Chaxter
//
//  Created by Stral on 3/3/14.
//  Copyright (c) 2014 Chaxter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface iRoidHelper : NSObject <MBProgressHUDDelegate>{
  
}

+(void)ShowAlert:(NSString*)msg;
+(void)ShowToast:(NSString*)msg;
+(BOOL)IsInternetConnected;
+(void)ShowLoading : (UIViewController*) vc;
+(void)HideLoading;

@end
