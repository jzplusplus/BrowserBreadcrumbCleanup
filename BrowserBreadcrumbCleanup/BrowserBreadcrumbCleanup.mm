#line 1 "/Users/jzplusplus/Documents/jailbreak/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup.xm"




id mController;

#include <logos/logos.h>
#include <substrate.h>
@class UIStatusBarBreadcrumbItemView; @class MainController; @class BrowserController; 
static id (*_logos_orig$_ungrouped$MainController$init)(MainController*, SEL); static id _logos_method$_ungrouped$MainController$init(MainController*, SEL); static void (*_logos_orig$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$)(UIStatusBarBreadcrumbItemView*, SEL, id); static void _logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$(UIStatusBarBreadcrumbItemView*, SEL, id); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$BrowserController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("BrowserController"); } return _klass; }
#line 7 "/Users/jzplusplus/Documents/jailbreak/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup.xm"

static id _logos_method$_ungrouped$MainController$init(MainController* self, SEL _cmd) {
    mController = _logos_orig$_ungrouped$MainController$init(self, _cmd);
    return mController;
}





static void _logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$(UIStatusBarBreadcrumbItemView* self, SEL _cmd, id originalArgument) {
    if( [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.google.chrome.ios"])
    {
        [[[mController mainTabModel] currentTab] close];
    }
    else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.mobilesafari"])
    {
        [[[[_logos_static_class_lookup$BrowserController() sharedBrowserController] tabController] activeTabDocument] _closeTabDocumentAnimated: true];
    }

	_logos_orig$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$(self, _cmd, originalArgument);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$MainController = objc_getClass("MainController"); MSHookMessageEx(_logos_class$_ungrouped$MainController, @selector(init), (IMP)&_logos_method$_ungrouped$MainController$init, (IMP*)&_logos_orig$_ungrouped$MainController$init);Class _logos_class$_ungrouped$UIStatusBarBreadcrumbItemView = objc_getClass("UIStatusBarBreadcrumbItemView"); MSHookMessageEx(_logos_class$_ungrouped$UIStatusBarBreadcrumbItemView, @selector(userDidActivateButton:), (IMP)&_logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$, (IMP*)&_logos_orig$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$);} }
#line 31 "/Users/jzplusplus/Documents/jailbreak/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup.xm"
