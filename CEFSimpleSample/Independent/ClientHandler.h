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

#ifndef __CEFSimpleSample__ClientHandler__
#define __CEFSimpleSample__ClientHandler__

#include "include/cef_client.h"

// I implement the same class as the CEFClient, but won't get into the implementation of methods
// The idea here is to keep it minimal, if you want details, check ou CEFClient
class ClientHandler : public CefClient, public CefLifeSpanHandler, public CefPrintHandler, public CefV8ContextHandler, public CefV8Handler {

public:
    ClientHandler();

    CefRefPtr<CefBrowser> GetBrowser() { return m_Browser; }
    CefWindowHandle GetBrowserHwnd() { return m_BrowserHwnd; }
    
    // CefClient methods
    virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler() OVERRIDE {
        return this;
    }

    virtual CefRefPtr<CefPrintHandler> GetPrintHandler() OVERRIDE {
        return this;
    }
    
    virtual CefRefPtr<CefV8ContextHandler> GetV8ContextHandler() OVERRIDE {
        return this;
    }

    // Virutal on CefLifeSpanHandler
    virtual bool DoClose(CefRefPtr<CefBrowser> browser) OVERRIDE;
    virtual bool OnBeforePopup(CefRefPtr<CefBrowser> parentBrowser, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, const CefString& url, CefRefPtr<CefClient>& client, CefBrowserSettings& settings) OVERRIDE;
    virtual void OnAfterCreated(CefRefPtr<CefBrowser> browser) OVERRIDE;
    virtual void OnBeforeClose(CefRefPtr<CefBrowser> browser) OVERRIDE;
        
    // Virutal on CefV8ContextHandler
    void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) OVERRIDE;
    void OnContextReleased(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) OVERRIDE;
    
    // Virutal on CefV8Handler
    bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, CefRefPtr<CefV8Value>& retval, CefString& exception) OVERRIDE;

protected:
    // The child browser window
    CefRefPtr<CefBrowser> m_Browser;
    
    // The child browser window handle
    CefWindowHandle m_BrowserHwnd;
    
    ///
    // Macro that provides a reference counting implementation for classes extending
    // CefBase.
    ///
    IMPLEMENT_REFCOUNTING(ClientHandler);
};

#endif /* defined(__CEFSimpleSample__ClientHandler__) */
