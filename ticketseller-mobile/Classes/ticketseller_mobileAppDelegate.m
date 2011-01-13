//
//  ticketseller_mobileAppDelegate.m
//  ticketseller-mobile
//
//  Created by Craig Plummer on 12/01/2011.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "ticketseller_mobileAppDelegate.h"
#import "PhoneGapViewController.h"

@implementation ticketseller_mobileAppDelegate

- (id) init
{	
	/** If you need to do any extra app-specific initialization, you can do it here
	 *  -jm
	 **/
    return [super init];
}

- (BOOL)application:(UIApplication*)application  
didFinishLaunchingWithOptions:(NSDictionary*)launchOptions  
{  
	// Register for alert notifications  
	[application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge];  
	
	// Add the view controller's view to the window and display.  
	[window addSubview:viewController.view];  
	[window makeKeyAndVisible];  
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions]; 
	return YES;
}  

- (void)application:(UIApplication*)application  
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken  
{  
	// Convert the token to a hex string and make sure it's all caps  
	NSMutableString *tokenString = [NSMutableString stringWithString:[[deviceToken description] uppercaseString]];  
	[tokenString replaceOccurrencesOfString:@"<" withString:@"" options:0 range:NSMakeRange(0, tokenString.length)];  
	[tokenString replaceOccurrencesOfString:@">" withString:@"" options:0 range:NSMakeRange(0, tokenString.length)];  
	[tokenString replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, tokenString.length)];  
	
	// Create the NSURL for the request  
	NSString *urlFormat = @"https://go.urbanairship.com/api/device_tokens/%@";  
	NSURL *registrationURL = [NSURL URLWithString:[NSString stringWithFormat:  
												   urlFormat, tokenString]]; 
	// Create the registration request  
	NSMutableURLRequest *registrationRequest = [[NSMutableURLRequest alloc]  
												initWithURL:registrationURL];  
	[registrationRequest setHTTPMethod:@"PUT"];  
	
	// And fire it off  
	NSURLConnection *connection = [NSURLConnection connectionWithRequest:registrationRequest  
																delegate:self];  
	[connection start];  
	
	NSLog(@"We successfully registered for push notifications");  
}  

- (void)application:(UIApplication*)application  
didFailToRegisterForRemoteNotificationsWithError:(NSError*)error  
{  
	// Inform the user that registration failed  
	NSString* failureMessage = @"There was an error while trying to register for push notifications.";  
	UIAlertView* failureAlert = [[UIAlertView alloc] initWithTitle:@"Error"  
														   message:failureMessage  
														  delegate:nil  
												 cancelButtonTitle:@"OK"  
												 otherButtonTitles:nil];  
	[failureAlert show];  
	[failureAlert release];  
}  

- (void)connection:(NSURLConnection *)connection  
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge  
{  
	// Check for previous failures  
	if ([challenge previousFailureCount] > 0)  
	{  
		// We've already tried - something is wrong with our credentials  
		NSLog(@"Urban Airship credentials invalid");  
		return;  
	}  
	
	// Send our Urban Airship credentials  
	NSURLCredential *airshipCredentials = [NSURLCredential credentialWithUser:@"eoXkGUN2QjypmZq5PaPLcw"  
																	 password:@"LFmH1D3pRxagycdD5KGknw"  
																  persistence:NSURLCredentialPersistenceNone];  
	[[challenge sender] useCredential:airshipCredentials  
		   forAuthenticationChallenge:challenge];  
}  

-(id) getCommandInstance:(NSString*)className
{
	/** You can catch your own commands here, if you wanted to extend the gap: protocol, or add your
	 *  own app specific protocol to it. -jm
	 **/
	return [super getCommandInstance:className];
}

/**
 Called when the webview finishes loading.  This stops the activity view and closes the imageview
 */
- (void)webViewDidFinishLoad:(UIWebView *)theWebView 
{
	return [ super webViewDidFinishLoad:theWebView ];
}

- (void)webViewDidStartLoad:(UIWebView *)theWebView 
{
	return [ super webViewDidStartLoad:theWebView ];
}

/**
 * Fail Loading With Error
 * Error - If the webpage failed to load display an error with the reson.
 */
- (void)webView:(UIWebView *)theWebView didFailLoadWithError:(NSError *)error 
{
	return [ super webView:theWebView didFailLoadWithError:error ];
}

/**
 * Start Loading Request
 * This is where most of the magic happens... We take the request(s) and process the response.
 * From here we can re direct links and other protocalls to different internal methods.
 */
- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	return [ super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType ];
}


- (BOOL) execute:(InvokedUrlCommand*)command
{
	return [ super execute:command];
}

- (void)dealloc
{
	[ super dealloc ];
}

@end
