
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

id mController;

%hook MainController
-(id)init {
    mController = %orig;
    return mController;
}
%end

%hook UIStatusBarBreadcrumbItemView

- (void)userDidActivateButton:(id)originalArgument
{
    if( [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.google.chrome.ios"])
    {
        [[[mController mainTabModel] currentTab] close];
    }
    else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.mobilesafari"])
    {
        [[[[%c(BrowserController) sharedBrowserController] tabController] activeTabDocument] _closeTabDocumentAnimated: true];
    }

	%orig(originalArgument);
}

%end
