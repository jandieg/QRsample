//
//  CDVWVQRScan.h
//  CustomQRScan
//
//  Created by Rener-Mac on 4/28/16.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "ZBarSDK.h"

@interface CDVWVQRScan : CDVPlugin
- (void)setQrReader:(CDVInvokedUrlCommand*)command;
- (void)close:(CDVInvokedUrlCommand*)command;
- (void)returnResult:(NSString *)data command:(CDVInvokedUrlCommand*)command;
@end
