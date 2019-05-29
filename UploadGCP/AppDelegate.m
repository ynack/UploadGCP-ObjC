//
//  AppDelegate.m
//  UploadGCP
//
//  Created by yosuke on 2019/03/14.
//  Copyright © 2019 yosuke.nakayama. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    /*  設定ファイル GCP.prefを読み込んで配列に格納  */
    NSString *prf_name = [[NSBundle mainBundle] pathForResource:@"GCP" ofType:@"pref"];
    NSError *prfError;
    NSString *prfStr = [NSString stringWithContentsOfFile:prf_name encoding:NSUTF8StringEncoding error:&prfError];
    NSArray *prf = [prfStr componentsSeparatedByString:@"\n"];
    
    /*  設定をUIに反映さえる */
    [_SrcText setStringValue:prf[0]];
    [_DstText setStringValue:prf[1]];
    [_UsrText setStringValue:prf[2]];
    [_InsText setStringValue:prf[3]];
    [_PrtText setStringValue:prf[4]];
    
    /*  間違って変更しないよう、重要な設定をロック   */
    /*  チェックボックスにチェックを入れて、テキストフィールドをDisenableにする   */
    [_DstLockBtn setState:YES];
    [_DstText setEnabled:NO];
    [_UsrLockBtn setState:YES];
    [_UsrText setEnabled:NO];
    [_InsLockBtn setState:YES];
    [_InsText setEnabled:NO];
    [_PrtLockBtn setState:YES];
    [_PrtText setEnabled:NO];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    //Closeボタンでアプリを終了させる
    return YES;
}

- (IBAction)DisLock:(id)sender {
    /* チェックボックスのオンオフでテキストフィールドの状態を切り替え  */
    if(_DstLockBtn.state == YES)
    {
        /*  入力不可    */
        _DstText.enabled = NO;
    }
    else
    {
        /*  入力可  */
        _DstText.enabled = YES;
    }
}

- (IBAction)UsrLock:(id)sender {
    /* チェックボックスのオンオフでテキストフィールドの状態を切り替え  */
    if(_UsrLockBtn.state == YES)
    {
        /*  入力不可    */
        _UsrText.enabled = NO;
    }
    else
    {
        /*  入力可  */
        _UsrText.enabled = YES;
    }
}

- (IBAction)InsLock:(id)sender {
    /* チェックボックスのオンオフでテキストフィールドの状態を切り替え  */
    if(_InsLockBtn.state == YES)
    {
        /*  入力不可    */
        _InsText.enabled = NO;
    }
    else
    {
        /*  入力可  */
        _InsText.enabled = YES;
    }
}

- (IBAction)PrtLock:(id)sender {
    /* チェックボックスのオンオフでテキストフィールドの状態を切り替え  */
    if(_PrtLockBtn.state == YES)
    {
        /*  入力不可    */
        _PrtText.enabled = NO;
    }
    else
    {
        /*  入力可  */
        _PrtText.enabled = YES;
    }
}

- (IBAction)SlctJS:(id)sender {
}

- (IBAction)SlctCSS:(id)sender {
}

- (IBAction)SlctIMG:(id)sender {
}

- (IBAction)SlctFldr:(id)sender {
}

- (IBAction)Send:(id)sender {
    
    if([_SrcText.stringValue length] == 0)
    {
        /* 送信ファイルの入力がなければアラートを出す    */
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"ファイルが選択されていません"];
        [alert setInformativeText:@"送信するファイルを選択してください"];
        [alert addButtonWithTitle:@"OK"];
        [alert runModal];
        
        return;
    }
    
    NSString *source = _SrcText.stringValue;
    NSString *dist = _DstText.stringValue;
    NSString *port = _PrtText.stringValue;
    NSString *user = _UsrText.stringValue;
    NSString *instance = _InsText.stringValue;
    
    char SendCmd[256];
    
    const char *c_src = (char *)[source UTF8String];
    const char *c_dst = (char *)[dist UTF8String];
    const char *c_prt = (char *)[port UTF8String];
    const char *c_ins = (char *)[instance UTF8String];
    const char *c_usr = (char *)[user UTF8String];
    
    sprintf(SendCmd,"/usr/local/google-cloud-sdk/bin/gcloud compute scp %s %s@%s:%s --port=%s",c_src,c_usr,c_ins,c_dst,c_prt);
    NSLog(@"%s",SendCmd);
    system(SendCmd);
}
@end
