
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>;

id mController;
id openedTab;
BOOL shouldCloseTab = YES;

%hook MainController
-(void)applicationDidBecomeActive:(id)app
{
    %orig(app);
    mController = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        openedTab = [[self mainTabModel] currentTab];
        shouldCloseTab = YES;
    });
}
%end

%hook Application
-(void)applicationOpenURL:(id)url
{
    %orig(url);
    
    openedTab = [[[%c(BrowserController) sharedBrowserController] tabController] activeTabDocument];
    shouldCloseTab = YES;
}
%end

%hook UIStatusBarBreadcrumbItemView

- (void)setDestinationText:(id)arg {
    %orig(arg);
    
    UILongPressGestureRecognizer *btn_LongPress_gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleBtnLongPressgesture:)];
    [[self button] addGestureRecognizer:btn_LongPress_gesture];
    shouldCloseTab = YES;
}

- (void)userDidActivateButton:(id)arg
{
    if(shouldCloseTab)
    {
        if( [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.google.chrome.ios"])
        {
            if( [[mController mainTabModel] currentTab] == openedTab )
            {
                [openedTab close];
            }
        }
        else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.mobilesafari"])
        {
            if( [[[%c(BrowserController) sharedBrowserController] tabController] activeTabDocument] == openedTab )
            {
                [openedTab _closeTabDocumentAnimated: true];
            }
        }
    }
    
    %orig(arg);
}

%new
- (void)handleBtnLongPressgesture:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        shouldCloseTab = NO;
    }
    
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        [[self button] sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

%end
