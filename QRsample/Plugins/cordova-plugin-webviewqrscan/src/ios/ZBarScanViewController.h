//
//  ZBarScanViewController.h
//  CustomQRScan
//
//  Created by Rener-Mac on 4/28/16.
//
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>

#import "ZBarSDK.h"
#import "CDVWVQRScan.h"

@interface ZBarScanViewController : UIViewController <ZBarReaderViewDelegate>
{
    GLuint _renderBuffer;
    ZBarReaderView * _reader;
    
    CDVWVQRScan * _scanManager;
    CDVInvokedUrlCommand * _command;
}

- (void) init_camera;
- (void) setSize:(CGRect) rect;
- (void) setCommand:(CDVInvokedUrlCommand *) command manager:(CDVWVQRScan *) manager;

@property (nonatomic) EAGLContext *context;

@end
