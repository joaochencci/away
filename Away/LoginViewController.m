//
//  LoginViewController.m
//  Away
//
//  Created by Wesley Ide on 27/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "LoginViewController.h"
#import "Session.h"

#define FBINTRODELAY 1.5f

@interface LoginViewController () <FBLoginViewDelegate> {
    FBLoginView *_fbLoginButton;
    BOOL _fbButtonOn;
    
    UIImageView *_balloonView;
    UIView *_balloonShadowView;
}

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;


@end

@implementation LoginViewController

# pragma mark -
# pragma mark - Initializations

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:TRUE];
    
    [self initializaFBLoginButton];
    
    _fbButtonOn = NO;
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:TRUE];
    
    
    //[self initializaFBLoginButton];
    if ([FBSession activeSession].isOpen) {
        NSLog(@"Is Open");
        [self goToNextScene];
    } else {
        NSLog(@"FB - Not Open: Show Login Button");
        [self animateFBLoginAppearing:YES andDelay:FBINTRODELAY];
    }
}

# pragma mark - Facebook Button Initialization and animation

- (void)initializaFBLoginButton
{
    // Create a FBLoginView to log the user in with basic, email
    // and likes permissions.
    // You should ALWAYS ask for basic permissions (basic_info)
    // when logging the user in.
    _fbLoginButton = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"email", @"user_likes"]];
    
    // Set this loginUIViewController to be the loginView button's delegate
    _fbLoginButton.delegate = self;
    
    // Align the button in the center horizontally
    CGFloat dx = (self.view.center.x - (_fbLoginButton.frame.size.width / 2));
    CGFloat dy = 5;
    _fbLoginButton.frame = CGRectOffset(_fbLoginButton.frame, dx, dy);
    
    // Align the button in the center vertically
    _fbLoginButton.center = self.view.center;
    
    // Hidding FBLogin Button
    _fbLoginButton.hidden = YES;
    _fbLoginButton.alpha = 0.0f;
    
    // Add the button to the view, behind logo.
    [self.view insertSubview:_fbLoginButton belowSubview:self.logo];
    //[self.view addSubview:_fbLoginButton];
}

- (void)animateFBLoginAppearing:(BOOL)appearing andDelay:(NSTimeInterval)delay
{
    // Animates logo and FBLogin Button
    
    NSTimeInterval duration = 0.2f;
    
    // Logo
    CGPoint newLogoCenter = self.logo.center;
    // FBButton
    CGPoint newFBButtonCenter = _fbLoginButton.center;
    
    CGFloat toAlpha;
    
    CGFloat dy = _fbLoginButton.frame.size.height;
    
    if (appearing) {
        //
        _fbLoginButton.hidden = NO;
        toAlpha = 1.0f;
        newLogoCenter.y -= dy;
        newFBButtonCenter.y += (2 * dy);
    } else {
        //
        toAlpha = 0.0f;
        newLogoCenter.y += dy;
        newFBButtonCenter.y -= (2 * dy);
        self.notificationLabel.hidden = YES;
    }
    
    [UIView animateWithDuration:duration
                          delay:delay
                        options:(UIViewAnimationOptionCurveEaseOut)
                     animations:^{
                         //
                         self.logo.center = newLogoCenter;
                         _fbLoginButton.center = newFBButtonCenter;
                         _fbLoginButton.alpha = toAlpha;
                     } completion:^(BOOL finished) {
                         if (!appearing) {
                             // Hides button when finished hidding animation
                             _fbLoginButton.hidden = YES;
                             _fbButtonOn = NO;
                         } else {
                             _fbButtonOn = YES;
                             self.notificationLabel.hidden = NO;
                             [self getLocation];
                         }
                     }];
    

}

# pragma mark -
# pragma mark - Preparing for transition
- (void)getLocation
{
    Session *session = [Session sharedSession];
    
    CLLocation *location = [session.locationManager location];
    
    NSLog(@"Coordinates: %f %f",location.coordinate.longitude, location.coordinate.latitude);
    
    [session.user.location insertObject:[NSNumber numberWithFloat:location.coordinate.latitude] atIndex:0];
    [session.user.location insertObject:[NSNumber numberWithFloat:location.coordinate.longitude] atIndex:1];
    
     //[self callSegueToNextScene];
}

- (void)goToNextScene
{
    [self preTransitionAnimationSetUp];
    [self loadFirstDestinations];
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
//    [self performSelector:@selector(simulatedDelay) withObject:nil afterDelay:8];
}

- (void)loadFirstDestinations
{
    Session *session = [Session sharedSession];
    for (Destination *d in session.destinations) {
        for (DestinationViewPoint *vp in d.viewPoints) {
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: vp.imageUrl]];
            vp.image = [UIImage imageWithData: imageData];
        }
    }
}

- (void)simulatedDelay
{
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}

# pragma mark -
# pragma mark - PreTransition Animations
- (void)preTransitionAnimationSetUp
{
    [self getLocation];
    [self hideLogoText];
}

- (void)hideLogoText
{
    CGSize newSize;
    CGPoint newOrigin = self.logo.frame.origin;
    
    newSize = CGSizeMake(62.5f, 90.0f);
    newOrigin.x = self.view.center.x - ((62./2) + 1);
    self.logo.layer.shadowColor = [UIColor blackColor].CGColor;
    
    CGRect newFrame = self.logo.frame;
    newFrame.size = newSize;
    newFrame.origin = newOrigin;
    
    [UIView animateWithDuration:0.22
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseOut)
                     animations:^{
                         self.logo.frame = newFrame;
                     } completion:^(BOOL finished) {
                         [self setUpBallonView];
                     }];
}

- (void)setUpBallonView
{
    _balloonView = [[UIImageView alloc] initWithFrame:self.logo.frame];
    _balloonView.image = [UIImage imageNamed:@"balloon_home_screen"];
    
    // Setting up shadow
    CGSize size = _balloonView.frame.size;
    _balloonShadowView = [[UIView alloc] initWithFrame:_balloonView.frame];
    _balloonShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _balloonShadowView.layer.shadowOpacity = 0.7f;
    _balloonShadowView.layer.shadowOffset = CGSizeMake(20.0f, 45.0f);
    _balloonShadowView.layer.shadowRadius = 6.0f;
    _balloonShadowView.layer.masksToBounds = NO;
    
    CGRect ovalRect = CGRectMake(0.0f, size.height + 5, size.width - 10, 15);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    _balloonShadowView.layer.shadowPath = path.CGPath;
    
    _balloonView.layer.shouldRasterize = YES;
    _balloonView.layer.rasterizationScale = _balloonView.image.scale;
    
    _balloonShadowView.layer.shouldRasterize = YES;
    _balloonShadowView.layer.rasterizationScale = _balloonView.image.scale;
    
    [self.view addSubview:_balloonShadowView];
    [self.view addSubview:_balloonView];
    
    [self.logo removeFromSuperview];
    
    [self floatBalloon];
    [self animateShadow];
    [self rotateLogo];
}

- (void)floatBalloon
{
    CGPoint newCenter = CGPointMake(_balloonView.center.x + 1,
                                    _balloonView.center.y + 30);
    [UIView animateWithDuration:2.5
                          delay:0.0
                        options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         _balloonView.center = newCenter;
                     }
                     completion:^(BOOL completed){
                     }];
}

- (void)rotateLogo
{
    // Rotation
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnim.toValue = [NSNumber numberWithFloat:((15*M_PI)/180)];
    
    rotationAnim.duration = 2.5;
    rotationAnim.repeatCount = INFINITY;
    rotationAnim.autoreverses = YES;
    rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [_balloonView.layer addAnimation:rotationAnim forKey:@"balloonRotation"];
    
}

- (void)animateShadow
{
    // Animating Layer Properties:
    // ShadowRadius
    CABasicAnimation *shadowRadiusAnim = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    shadowRadiusAnim.toValue = @4.0;
    
    // ShadowOffset - for ballon rotation.
    CABasicAnimation *shadowOffsetWidthAnim = [CABasicAnimation animationWithKeyPath:@"shadowOffset.width"];
    shadowOffsetWidthAnim.toValue = [NSNumber numberWithDouble:(double)8.0];
    
    // Shadow scla
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnim.toValue = @1;
    
    // Shadow Path
    CGSize size = _balloonView.frame.size;
    CGRect ovalRect = CGRectMake(10.0f, size.height + 5, size.width - 30, 15);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    CABasicAnimation *shadowPathAnim = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
    shadowPathAnim.toValue = (id)path.CGPath;
    
    // Grouping Layer Animations
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2.5;
    group.repeatCount = INFINITY;
    group.autoreverses = YES;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = [NSArray arrayWithObjects:scaleAnim, shadowRadiusAnim, shadowOffsetWidthAnim, shadowPathAnim, nil];
    
    [_balloonShadowView.layer addAnimation:group forKey:@"allImageViewAnimations"];
}

# pragma mark -
# pragma mark - Handling Request Returns
# pragma mark - Facebook

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSString *accessToken = [[[FBSession activeSession] accessTokenData] accessToken];
    
    NSLog(@"%@", accessToken);
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    [self getLocation];
    if (_fbButtonOn) {
        [self animateFBLoginAppearing:NO andDelay:0.7];
        [self performSelector:@selector(goToNextScene)
                   withObject:nil
                   afterDelay:0.8];
    }
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
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


# pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemory");
}

@end
