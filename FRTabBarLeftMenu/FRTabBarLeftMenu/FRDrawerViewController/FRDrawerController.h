//
//  FRDrawerController.h
//
//  Created by Vito Modena
//
//  Copyright (c) 2014 ice cream studios s.r.l. - http://icecreamstudios.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>

@protocol FRDrawerControllerChild;
@protocol FRDrawerControllerPresenting;

/**
 FRDrawerController is a left-side drawer controller for iPhone (iOS 7 or later).
 
 It has all the features you'd expect from a side drawer controller, plus it's small, easy to read and tailor to your needs.
 
 The controller is designed as a container controller and accepts two child controllers: the left and the center view controllers. The left view controller is intended as a master view controller: it is visible only when the drawer is open and, typically, talks to the drawer in order to update/replace the center view controller. The center view controller is intended as a detail view controller: it is visible when the drawer is closed and typically sends the `open` message to the drawer to reveal the left side controller.
 
 ## Opening/closing the drawer
 FRDrawerController uses a UIPanGestureRecognizer to open/close the drawer and a UITapGestureRecognizer to close the drawer by tapping anywhere on the visible part of the center view controller.
 
 It is left to your center view controller to provide a button and call `open` on the drawer controller. (From your child controllers you access the drawer controller by adopting the `FRDrawerControllerChild` protocol and implementing the required `drawer` property.)
 
 ## Status bar
 You can control the status bar's visibility and style by implementing, in each one of your child controllers, the `prefersStatusBarHidden`  and `preferredStatusBarStyle` methods made available by iOS 7.
 
 ## Getting notified when the drawer state changes
 The drawer controller will notify its child controllers by sending:
 
 - the message `drawerControllerWillOpen:` when the drawer is about to open
 - the message `drawerControllerDidOpen:` when the drawer has completed the opening phase
 - the message `drawerControllerWillClose:` when the drawer is about to close
 - the message `drawerControllerDidClose:` when the drawer has completed the closing phase
 
 ## Installing
 1. Drag the inner FRDrawerController folder to your Xcode project
 2. Adopt in your child controllers the `FRDrawerControllerChild` protocol and implement its the required `drawer` property
 3. Adopt in your child controllers the `FRDrawerControllerPresenting` protocol
 4. Initialize the drawer controller with your left view controller and your initial center view controller:
 
    YourLeftViewController *left = [[YourLeftViewController alloc] init];
    YourCenterViewController *center = [[YourCenterViewController alloc] init];
    FRDrawerController *drawer = [[FRDrawerController alloc] initWithLeftViewController:left
                                                                     centerViewController:center];
 */
@interface FRDrawerController : UIViewController

/**
 @name Child controllers
 */

/**
 The left view controller.

 This controller shows up when the drawer opens. You add it when initializing the drawer object.
 
 @see initWithLeftViewController:centerViewController:
 */
@property(nonatomic, strong, readonly) UIViewController<FRDrawerControllerChild, FRDrawerControllerPresenting> *leftViewController;
/**
 The center view controller.

 This is the main view controller. When needed, it is possible to replace the current center view controller with a different one
 by calling `replaceCenterViewControllerWithViewController:`.

 @see replaceCenterViewControllerWithViewController:
 */
@property(nonatomic, strong, readonly) UIViewController<FRDrawerControllerChild, FRDrawerControllerPresenting> *centerViewController;

/**
 @name Initialization
 */

/**
 Initializes and returns a newly allocated drawer object with the given child controllers.

 @param leftViewController The left view controller. It cannot be `nil`.
 @param centerViewController The center view controller. It cannot be `nil`.

 @return An initialized drawer object or nil if the object couldn't be created.
 */
- (id)initWithLeftViewController:(UIViewController<FRDrawerControllerChild, FRDrawerControllerPresenting> *)leftViewController
            centerViewController:(UIViewController<FRDrawerControllerChild, FRDrawerControllerPresenting> *)centerViewController;

/**
 @name Drawer functionality
 */

/**
 Opens the drawer.

 Typically, you call this method as a result of tapping on a button in your center view controller.
 */
- (void)open;
/**
 Closes the drawer.

 Call this method when you want to programmatically close the drawer.
 Typically, this is the case of a tap in the left view controller leading to exactly the same center view controller currently shown.

 From the user's point of view, the result of calling this method is the same of tapping on the center view controller to close it.
 */
- (void)close;
/**
 Reloads the current center view controller and then closes the drawer.
 
 Call this method when you need to reload the contents of the current center view controller. The center view controller will be moved
 out of the right edge of the screen and the given `reloadBlock` will be then invoked. Finally, the drawer will be closed.

 @param reloadBlock The reload block
 */
- (void)reloadCenterViewControllerUsingBlock:(void (^)(void))reloadBlock;
/**
 Replaces the current center view controller with the given `viewController` and then closes the drawer.

 @param viewController The view controller object that will replace the current center view controller.
 */
- (void)replaceCenterViewControllerWithViewController:(UIViewController<FRDrawerControllerChild, FRDrawerControllerPresenting> *)viewController;

@end



/**
 The `FRDrawerControllerChild` protocol is used by the `FRDrawerController`'s child controllers to communicate with the drawer.

 When the child controller is added to the drawer controller, the drawer object automatically sets this property to point to itself.
 */
@protocol FRDrawerControllerChild <NSObject>

/**
 The drawer object for this child controller
 */
@property(nonatomic, weak) FRDrawerController *drawer;

@end



/**
 The `FRDrawerControllerPresenting` protocol is used by `FRDrawerController` to communicate changes in the open/closed
 state of the drawer to its child controllers.

 As an example, you may want to implement these methods in your drawer's center view controller to be able to disable/enable
 the user interaction when the drawer is open/closed.
 */
@protocol  FRDrawerControllerPresenting <NSObject>

@optional
/**
 Tells the child controller that the drawer controller is about to open.

 @param drawerController The drawer object that is about to open.
 */
- (void)drawerControllerWillOpen:(FRDrawerController *)drawerController;
/**
 Tells the child controller that the drawer controller has completed the opening phase and is now open.

 @param drawerController The drawer object that is now open.
 */
- (void)drawerControllerDidOpen:(FRDrawerController *)drawerController;
/**
 Tells the child controller that the drawer controller is about to close.

 @param drawerController The drawer object that is about to close.
 */
- (void)drawerControllerWillClose:(FRDrawerController *)drawerController;
/**
 Tells the child controller that the drawer controller has completed the closing phase and is now closed.

 @param drawerController The drawer object that is now closed.
 */
- (void)drawerControllerDidClose:(FRDrawerController *)drawerController;

@end