//
//  ZBarScanViewController.m
//  CustomQRScan
//
//  Created by Rener-Mac on 4/28/16.
//
//

#import <GLKit/GLKit.h>
#import <AVFoundation/AVFoundation.h>

#import "ZBarScanViewController.h"
#import "ZBarImageScanner.h"

@implementation ZBarScanViewController
@synthesize context = _context;

- (void) init_camera
{
    _reader = [ZBarReaderView new];
    ZBarImageScanner * scanner = [ZBarImageScanner new];
    [scanner setSymbology:ZBAR_PARTIAL config:0 to:0];
    [_reader initWithImageScanner:scanner];
    //[scanner release];
    _reader.readerDelegate = self;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    _reader.frame = self.view.frame;
    _reader.backgroundColor = [UIColor redColor];
    _reader.torchMode = AVCaptureTorchModeOff;
    [_reader start];
    
    [self.view addSubview: _reader];
    //[reader release];
}

-(void) setSize:(CGRect) rect
{
    _reader.frame = rect;
}

-(void) setCommand:(CDVInvokedUrlCommand *) command manager:(CDVWVQRScan *) manager
{
    _command = command;
    _scanManager = manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    [_scanManager returnResult:symbol.data command:_command];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    //[reader dismissModalViewControllerAnimated: YES];
}

- (void) readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    for(symbol in symbols)
        // EXAMPLE: just grab the first barcode
        break;
    
    [_scanManager returnResult:symbol.data command:_command];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
