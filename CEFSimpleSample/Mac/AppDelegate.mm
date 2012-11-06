/************************************************************************************************
Copyright (c) 2012 Álan Crístoffer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
************************************************************************************************/

#import "AppDelegate.h"

#import "include/cef_app.h"
#import "include/cef_application_mac.h"
#import "include/cef_base.h"
#import "include/cef_browser.h"
#import "include/cef_client.h"
#import "include/cef_command_line.h"
#import "include/cef_frame.h"
#import "include/cef_runnable.h"
#import "include/cef_web_plugin.h"
#import "include/cef_web_urlrequest.h"

#import "ClientHandler.h"

#include <iostream>

@implementation AppDelegate

@synthesize window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{   
    CefSettings appSettings;
    CefBrowserSettings browserSettings;
    
    CefRefPtr<CefApp> cefApplication;
    CefRefPtr<CefClient> client(new ClientHandler());
    
    CefWindowInfo info;
    info.SetAsChild([window contentView], 0, 0, [[window contentView] frame].size.width, [[window contentView] frame].size.height);
    
    CefInitialize(appSettings, cefApplication);
    
    std::string path = [[[NSBundle mainBundle] resourcePath] cStringUsingEncoding:NSUTF8StringEncoding];
    path = "file://" + path + "/html/index.html";
    
    CefBrowser::CreateBrowser(info, client, path, browserSettings);
    
    CefRunMessageLoop();
}

@end
