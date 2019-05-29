//
//  AppDelegate.m
//  UploadGCP
//
//  Created by yosuke on 2019/03/14.
//  Copyright © 2019 yosuke.nakayama. All rights reserved.
//

#import "AppDelegate.h"
#import "STPrivilegedTask.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    /*  cmnd.txtを読み込んんでUIのコマンドフィールドに表示  
    NSString *gcp_cmnd = [[NSBundle mainBundle] pathForResource:@"cmnd" ofType:@"txt"];
    NSError *cmndError;
    NSString *cmdStr = [NSString stringWithContentsOfFile:gcp_cmnd encoding:NSUTF8StringEncoding error:&cmndError];
    [self.GcpCmnd setStringValue:cmdStr];
    
    //GpcCmndフィールドをロック
    [self.GcpCmnd setEnabled:false];*/
    
    /*  設定ファイル GCP.prefを読み込んで配列に格納  */
    NSString *prf_name = [[NSBundle mainBundle] pathForResource:@"GCP" ofType:@"pref"];
    NSError *prfError;
    NSString *prfStr = [NSString stringWithContentsOfFile:prf_name encoding:NSUTF8StringEncoding error:&prfError];
    NSArray *prf = [prfStr componentsSeparatedByString:@"\n"];
    
    /*  設定をUIに反映さえる */
    [self.SrcText setStringValue:prf[0]];
    [self.DstText setStringValue:prf[1]];
    [self.UsrText setStringValue:prf[2]];
    [self.InsText setStringValue:prf[3]];
    [self.PrtText setStringValue:prf[4]];

    /*  間違って変更しないよう、重要な設定をロック   */
    /*  チェックボックスにチェックを入れて、テキストフィールドをDisenableにする   */
    [self.DstLockBtn setState:YES];
    [self.DstText setEnabled:NO];
    [self.UsrLockBtn setState:YES];
    [self.UsrText setEnabled:NO];
    [self.InsLockBtn setState:YES];
    [self.InsText setEnabled:NO];
    [self.PrtLockBtn setState:YES];
    [self.PrtText setEnabled:NO];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    //Closeボタンでアプリを終了させる
    return YES;
}

- (BOOL)gcpCmnd:(NSString *)cmd {
    NSLog(@"%@",cmd);
    if ([[NSFileManager defaultManager] isExecutableFileAtPath:cmd] ) {
        return YES;
    }
    
    return NO;
}

- (IBAction)DisLock:(id)sender {
    /* チェックボックスのオンオフでテキストフィールドの状態を切り替え  */
    if(self.DstLockBtn.state == YES)
    {
        /*  入力不可    */
        self.DstText.enabled = NO;
    }
    else
    {
        /*  入力可  */
        self.DstText.enabled = YES;
    }
}

- (IBAction)UsrLock:(id)sender {
    /* チェックボックスのオンオフでテキストフィールドの状態を切り替え  */
    if(self.UsrLockBtn.state == YES)
    {
        /*  入力不可    */
        self.UsrText.enabled = NO;
    }
    else
    {
        /*  入力可  */
        self.UsrText.enabled = YES;
    }
}

- (IBAction)InsLock:(id)sender {
    /* チェックボックスのオンオフでテキストフィールドの状態を切り替え  */
    if(self.InsLockBtn.state == YES)
    {
        /*  入力不可    */
        self.InsText.enabled = NO;
    }
    else
    {
        /*  入力可  */
        self.InsText.enabled = YES;
    }
}

- (IBAction)PrtLock:(id)sender {
    /* チェックボックスのオンオフでテキストフィールドの状態を切り替え  */
    if(self.PrtLockBtn.state == YES)
    {
        /*  入力不可    */
        self.PrtText.enabled = NO;
    }
    else
    {
        /*  入力可  */
        self.PrtText.enabled = YES;
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
    
    if([self.SrcText.stringValue length] == 0)
    {
        /* 送信ファイルの入力がなければアラートを出す    */
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"ファイルが選択されていません"];
        [alert setInformativeText:@"送信するファイルを選択してください"];
        [alert addButtonWithTitle:@"OK"];
        [alert runModal];
        
        return;
    }
    
    NSString *source = self.SrcText.stringValue;
    NSString *dist = self.DstText.stringValue;
    NSString *port = self.PrtText.stringValue;
    NSString *user = self.UsrText.stringValue;
    NSString *instance = self.InsText.stringValue;
    /*
    char SendCmd[256];
    
    const char *c_src = (char *)[source UTF8String];
    const char *c_dst = (char *)[dist UTF8String];
    const char *c_prt = (char *)[port UTF8String];
    const char *c_ins = (char *)[instance UTF8String];
    const char *c_usr = (char *)[user UTF8String];
    
    sprintf(SendCmd,"/usr/local/google-cloud-sdk/bin/gcloud compute scp %s %s@%s:%s --port=%s",c_src,c_usr,c_ins,c_dst,c_prt);
    NSLog(@"%s",SendCmd);
    system(SendCmd);
    
    
    STPrivilegedTask *task = [[STPrivilegedTask alloc] init];
    [task setLaunchPath:@"/usr/bin/sudo"];
    [task setArguments:[NSArray arrayWithObjects:@"-s",@"/usr/local/google-cloud-sdk/bin/gcloud",@"compute",@"scp",source,user,instance,dist,port, nil]];
    
    [task launch];
    */
    
    
    NSString *cmd = [self.GcpCmnd stringValue];
    
    if ([self gcpCmnd:cmd] == NO) {
        NSBeep();
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Invalid shell command"];
        [alert setInformativeText:@"Command must start with path to executable file"];
        [alert runModal];
        return;
    }
    
    STPrivilegedTask *privilegedTask = [[STPrivilegedTask alloc] init];
    
    NSString *ins_dist = [NSString stringWithFormat:@"%@@%@:%@",user,instance,dist];
    NSString *port_num = [NSString stringWithFormat:@"--port=%@",port];
    
    //NSLog(@"%@",ins_usr);
    //NSLog(@"%@",port_num);
    //NSMutableArray *components = [[[self.GcpCmnd stringValue] componentsSeparatedByString:@" "] mutableCopy];
    //NSString *launchPath = components[0];
    //[components removeObjectAtIndex:0];
    NSArray *components = [NSArray arrayWithObjects:@"compute",@"scp",source,ins_dist,port_num, nil];


    [privilegedTask setLaunchPath:cmd];
    [privilegedTask setArguments:components];
    //[privilegedTask setCurrentDirectoryPath:[[NSBundle mainBundle] resourcePath]];
    
    //set it off
    
    OSStatus err = [privilegedTask launch];
    if (err != errAuthorizationSuccess) {
        if (err == errAuthorizationCanceled) {
            NSLog(@"User cancelled");
            return;
        }  else {
            NSLog(@"Something went wrong: %d", (int)err);
            // For error codes, see http://www.opensource.apple.com/source/libsecurity_authorization/libsecurity_authorization-36329/lib/Authorization.h
        }
    }
    
    [privilegedTask waitUntilExit];
    
    // Success!  Now, start monitoring output file handle for data
    NSFileHandle *readHandle = [privilegedTask outputFileHandle];
    NSData *outputData = [readHandle readDataToEndOfFile];
    NSString *outputString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
    [self.output setString:outputString];
    /*
    NSString *exitStr = [NSString stringWithFormat:@"Exit status: %d", privilegedTask.terminationStatus];
    [self.exitStatusTextField setStringValue:exitStr];*/
}
@end
