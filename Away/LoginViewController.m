//
//  LoginViewController.m
//  Away
//
//  Created by Wesley Ide on 27/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "LoginViewController.h"
#import "Session.h"
#import "HTTPRequest.h"

@interface LoginViewController () <HTTPRequestDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:TRUE];

    // Create a FBLoginView to log the user in with basic, email and likes permissions
    // You should ALWAYS ask for basic permissions (basic_info) when logging the user in
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"email", @"user_likes"]];
    
    // Set this loginUIViewController to be the loginView button's delegate
    loginView.delegate = self;
    
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 5);
    
    // Align the button in the center vertically
    loginView.center = self.view.center;
    
    // Add the button to the view
    [self.view addSubview:loginView];
}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSString *accessToken = [[[FBSession activeSession] accessTokenData] accessToken];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:3000/api/user/login?provider=facebook&token=%@",accessToken]];
    HTTPRequest *request = [[HTTPRequest alloc] initWithRequest:[NSURLRequest requestWithURL:url] andDelegate:self];
    [request executeRequestParsingData:RawHTTPDataTypeJSON asynch:NO];
    NSLog(@"%@", accessToken);
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    Session *session = [Session sharedSession];
    CLLocation *location = [session.locationManager location];
    
    NSLog(@"Coordinates: %f %f",location.coordinate.longitude, location.coordinate.latitude);
    
    [session.user.location insertObject:[NSNumber numberWithFloat:location.coordinate.latitude] atIndex:0];
    [session.user.location insertObject:[NSNumber numberWithFloat:location.coordinate.longitude] atIndex:1];
    
    [self performSegueWithIdentifier:@"doLogin" sender:self];
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}


# pragma mark - HTTPRequest Delegate

- (void)request:(HTTPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error");
}

- (void)request:(HTTPRequest *)request didFinishWithResponseObject:(HTTPResponseObject *)responseObject
{
//    NSLog(@"%@",responseObject.data);
    Session *session = [Session sharedSession];
    session.user = [[User alloc] initWithDictionary:responseObject.data];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemory");
}

@end
