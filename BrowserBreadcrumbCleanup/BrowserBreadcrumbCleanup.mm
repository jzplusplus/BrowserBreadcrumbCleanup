#line 1 "/Users/jzplusplus/Documents/jailbreak/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup.xm"




#import <UIKit/UIKit.h>;

id openedTab;
BOOL shouldCloseTab = YES;

#include <logos/logos.h>
#include <substrate.h>
@class BrowserController; @class UIStatusBarBreadcrumbItemView; @class Application; @class MainApplicationDelegate; 
static void (*_logos_orig$_ungrouped$MainApplicationDelegate$applicationDidBecomeActive$)(MainApplicationDelegate*, SEL, id); static void _logos_method$_ungrouped$MainApplicationDelegate$applicationDidBecomeActive$(MainApplicationDelegate*, SEL, id); static void (*_logos_orig$_ungrouped$Application$applicationOpenURL$)(Application*, SEL, id); static void _logos_method$_ungrouped$Application$applicationOpenURL$(Application*, SEL, id); static void (*_logos_orig$_ungrouped$UIStatusBarBreadcrumbItemView$setDestinationText$)(UIStatusBarBreadcrumbItemView*, SEL, id); static void _logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$setDestinationText$(UIStatusBarBreadcrumbItemView*, SEL, id); static void (*_logos_orig$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$)(UIStatusBarBreadcrumbItemView*, SEL, id); static void _logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$(UIStatusBarBreadcrumbItemView*, SEL, id); static void _logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$handleBtnLongPressgesture$(UIStatusBarBreadcrumbItemView*, SEL, UILongPressGestureRecognizer *); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$Application(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("Application"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$MainApplicationDelegate(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("MainApplicationDelegate"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$BrowserController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("BrowserController"); } return _klass; }
#line 10 "/Users/jzplusplus/Documents/jailbreak/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup.xm"


static void _logos_method$_ungrouped$MainApplicationDelegate$applicationDidBecomeActive$(MainApplicationDelegate* self, SEL _cmd, id app) {
    _logos_orig$_ungrouped$MainApplicationDelegate$applicationDidBecomeActive$(self, _cmd, app);
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        openedTab = [[[_logos_static_class_lookup$MainApplicationDelegate() sharedMainController] mainTabModel] currentTab];
        shouldCloseTab = YES;
    });
}




static void _logos_method$_ungrouped$Application$applicationOpenURL$(Application* self, SEL _cmd, id url) {
    _logos_orig$_ungrouped$Application$applicationOpenURL$(self, _cmd, url);
    
    
    if([self respondsToSelector:@selector(browserControllers)])
    {
        openedTab = [[[self browserControllers][0] tabController] activeTabDocument];
    }
    else
    {
        openedTab = [[[_logos_static_class_lookup$BrowserController() sharedBrowserController] tabController] activeTabDocument];
    }
        
    shouldCloseTab = YES;
}




static void _logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$setDestinationText$(UIStatusBarBreadcrumbItemView* self, SEL _cmd, id arg) {
    _logos_orig$_ungrouped$UIStatusBarBreadcrumbItemView$setDestinationText$(self, _cmd, arg);
    
    UILongPressGestureRecognizer *btn_LongPress_gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleBtnLongPressgesture:)];
    [[self button] addGestureRecognizer:btn_LongPress_gesture];
    shouldCloseTab = YES;
}


static void _logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$(UIStatusBarBreadcrumbItemView* self, SEL _cmd, id arg) {
    if(shouldCloseTab)
    {
        if( [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.google.chrome.ios"])
        {
            
            if( [[[_logos_static_class_lookup$MainApplicationDelegate() sharedMainController] mainTabModel] currentTab] == openedTab )
            {
                [openedTab close];
            }
        }
        else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.mobilesafari"])
        {
            
            id currentTab;
            if([[_logos_static_class_lookup$Application() sharedApplication] respondsToSelector:@selector(browserControllers)])
            {
                currentTab = [[[[_logos_static_class_lookup$Application() sharedApplication] browserControllers][0] tabController] activeTabDocument];
            }
            else
            {
                currentTab = [[[_logos_static_class_lookup$BrowserController() sharedBrowserController] tabController] activeTabDocument];
            }
            
            if( currentTab == openedTab )
            {
                [openedTab _closeTabDocumentAnimated: true];
            }
        }
    }
    
    _logos_orig$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$(self, _cmd, arg);
}



static void _logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$handleBtnLongPressgesture$(UIStatusBarBreadcrumbItemView* self, SEL _cmd, UILongPressGestureRecognizer * recognizer) {
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        shouldCloseTab = NO;
    }
    
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        [[self button] sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$MainApplicationDelegate = objc_getClass("MainApplicationDelegate"); MSHookMessageEx(_logos_class$_ungrouped$MainApplicationDelegate, @selector(applicationDidBecomeActive:), (IMP)&_logos_method$_ungrouped$MainApplicationDelegate$applicationDidBecomeActive$, (IMP*)&_logos_orig$_ungrouped$MainApplicationDelegate$applicationDidBecomeActive$);Class _logos_class$_ungrouped$Application = objc_getClass("Application"); MSHookMessageEx(_logos_class$_ungrouped$Application, @selector(applicationOpenURL:), (IMP)&_logos_method$_ungrouped$Application$applicationOpenURL$, (IMP*)&_logos_orig$_ungrouped$Application$applicationOpenURL$);Class _logos_class$_ungrouped$UIStatusBarBreadcrumbItemView = objc_getClass("UIStatusBarBreadcrumbItemView"); MSHookMessageEx(_logos_class$_ungrouped$UIStatusBarBreadcrumbItemView, @selector(setDestinationText:), (IMP)&_logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$setDestinationText$, (IMP*)&_logos_orig$_ungrouped$UIStatusBarBreadcrumbItemView$setDestinationText$);MSHookMessageEx(_logos_class$_ungrouped$UIStatusBarBreadcrumbItemView, @selector(userDidActivateButton:), (IMP)&_logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$, (IMP*)&_logos_orig$_ungrouped$UIStatusBarBreadcrumbItemView$userDidActivateButton$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UILongPressGestureRecognizer *), strlen(@encode(UILongPressGestureRecognizer *))); i += strlen(@encode(UILongPressGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UIStatusBarBreadcrumbItemView, @selector(handleBtnLongPressgesture:), (IMP)&_logos_method$_ungrouped$UIStatusBarBreadcrumbItemView$handleBtnLongPressgesture$, _typeEncoding); }} }
#line 102 "/Users/jzplusplus/Documents/jailbreak/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup/BrowserBreadcrumbCleanup.xm"
