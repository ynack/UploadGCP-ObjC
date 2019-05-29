//
//  AppDelegate.h
//  UploadGCP
//
//  Created by yosuke on 2019/03/14.
//  Copyright © 2019 yosuke.nakayama. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DragDrop.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{/*
    char c_src[256];
    char c_dst[256];
    char c_usr[256];
    char c_prt[256];
  */
}

@property (weak) IBOutlet NSTextField *SrcText;
@property (weak) IBOutlet NSTextField *DstText;

@property (weak) IBOutlet NSTextField *GcpCmnd;
@property (weak) IBOutlet NSTextField *UsrText;
@property (weak) IBOutlet NSTextField *InsText;
@property (weak) IBOutlet NSTextField *PrtText;

@property (weak) IBOutlet NSButton *DstLockBtn;
@property (weak) IBOutlet NSButton *UsrLockBtn;
@property (weak) IBOutlet NSButton *InsLockBtn;
@property (weak) IBOutlet NSButton *PrtLockBtn;

@property (weak) IBOutlet NSButton *SlctJSBtn;
@property (weak) IBOutlet NSButton *SlctCSSBtn;
@property (weak) IBOutlet NSButton *SlctIMGBtn;
@property (weak) IBOutlet NSButton *SlctFldrBtn;

@property (weak) IBOutlet NSTextField *FldrText;
@property (weak) IBOutlet NSTextField *RsText;
@property (unsafe_unretained) IBOutlet NSTextView *output;

@property (weak) IBOutlet NSButton *SndBtn;

- (IBAction)DisLock:(id)sender;
- (IBAction)UsrLock:(id)sender;
- (IBAction)InsLock:(id)sender;
- (IBAction)PrtLock:(id)sender;

- (IBAction)SlctJS:(id)sender;
- (IBAction)SlctCSS:(id)sender;
- (IBAction)SlctIMG:(id)sender;
- (IBAction)SlctFldr:(id)sender;

- (IBAction)Send:(id)sender;

@end

