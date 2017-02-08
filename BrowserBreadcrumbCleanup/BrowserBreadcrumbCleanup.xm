
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>;

id openedTab;
BOOL shouldCloseTab = YES;

%hook MainApplicationDelegate
-(void)applicationDidBecomeActive:(id)app
{
    %orig(app);
    
    //NSLog(@"**********CHROME url open");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        openedTab = [[[%c(MainApplicationDelegate) sharedMainController] mainTabModel] currentTab];
        shouldCloseTab = YES;
    });
}
%end

%hook Application
-(void)applicationOpenURL:(id)url
{
    %orig(url);
    
    //NSLog(@"**********SAFARI url open");
    if([self respondsToSelector:@selector(browserControllers)])
    {
        openedTab = [[[self browserControllers][0] tabController] activeTabDocument];
    }
    else
    {
        openedTab = [[[%c(BrowserController) sharedBrowserController] tabController] activeTabDocument];
    }
        
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
            //NSLog(@"**********CHROME");
            if( [[[%c(MainApplicationDelegate) sharedMainController] mainTabModel] currentTab] == openedTab )
            {
                [openedTab close];
            }
        }
        else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.mobilesafari"])
        {
            //NSLog(@"**********SAFARI");
            id currentTab;
            if([[%c(Application) sharedApplication] respondsToSelector:@selector(browserControllers)])
            {
                currentTab = [[[[%c(Application) sharedApplication] browserControllers][0] tabController] activeTabDocument];
            }
            else
            {
                currentTab = [[[%c(BrowserController) sharedBrowserController] tabController] activeTabDocument];
            }
            
            if( currentTab == openedTab )
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
