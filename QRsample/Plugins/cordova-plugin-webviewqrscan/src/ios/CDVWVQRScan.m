//
//  CDVWVQRScan.m
//  CustomQRScan
//
//  Created by Rener-Mac on 4/28/16.
//
//

#import "CDVWVQRScan.h"
#import "ZBarImageScanner.h"
#import "ZBarScanViewController.h"

@implementation CDVWVQRScan
ZBarScanViewController *scanViewController;

- (void)setQrReader:(CDVInvokedUrlCommand*)command
{    
    /*if (self.sessionManager != nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Camera already started!"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }*/
    
    if (command.arguments.count > 3) {
        CGFloat x = (CGFloat)[command.arguments[0] floatValue] + self.webView.frame.origin.x;
        CGFloat y = (CGFloat)[command.arguments[1] floatValue] + self.webView.frame.origin.y;
        CGFloat width = (CGFloat)[command.arguments[2] floatValue];
        CGFloat height = (CGFloat)[command.arguments[3] floatValue];
        
        // Create the session manager
        //self.sessionManager = [[CameraSessionManager alloc] init];
        
        //render controller setup
        if(scanViewController == nil) {
            
            scanViewController = [[ZBarScanViewController alloc] init];
            [self.viewController addChildViewController:scanViewController];
            //display the camera bellow the webview
        
            [self.viewController.view addSubview:scanViewController.view];
        
            [scanViewController init_camera];
            [scanViewController setSize: CGRectMake(x, y, width, height)];
        }
        
        [scanViewController setCommand:command manager:self];
        
        // Setup session
        //self.sessionManager.delegate = self.cameraRenderController;
        //[self.sessionManager setupSession:defaultCamera];
        
    } else {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid number of parameters"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)close:(CDVInvokedUrlCommand*)command
{
    if (scanViewController != nil) {
        [scanViewController.view removeFromSuperview];
        [scanViewController removeFromParentViewController];
        scanViewController = nil;
    }
}

- (void)returnResult:(NSString *)data command:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:data];
    NSLog(@"SSSSSSS");
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
