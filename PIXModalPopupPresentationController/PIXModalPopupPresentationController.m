//
//  PIXModalPopupPresentationController.m
//  CustomPresentationController
//
//  Created by Andrea Ottolina on 04/11/2020.
//

#import "PIXModalPopupPresentationController.h"

@interface PIXModalPopupPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation PIXModalPopupPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
    
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        // set defaults
        self.popupEdgeInsets = UIEdgeInsetsMake(16.0, 16.0, 16.0, 16.0);
        // initialize dimmingView
        [self setupDimmingView];
    }
    return self;
    
}

- (CGRect)frameOfPresentedViewInContainerView {

    UIView *containerView = self.containerView;

    CGRect presentedFrame = containerView.bounds;
    if (_useContainerSafeAreaInsets) {
        presentedFrame = UIEdgeInsetsInsetRect(presentedFrame, containerView.safeAreaInsets);
    }
    presentedFrame = UIEdgeInsetsInsetRect(presentedFrame, _popupEdgeInsets);

    return presentedFrame;

}

- (void)containerViewDidLayoutSubviews {

    [super containerViewDidLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];

}

// Not clear if it's necessary to override this call
/*
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    CGSize newSize = [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
    return newSize
}
 */

- (void)presentationTransitionWillBegin {
    
    UIView *containerView = self.containerView;
    UIViewController *presentedViewController = self.presentedViewController;
    
    self.dimmingView.frame = containerView.bounds;
    self.dimmingView.alpha = 0.0;
    
    [containerView insertSubview:self.dimmingView atIndex:0];
    
    if([presentedViewController transitionCoordinator]) {
        [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.dimmingView.alpha = 1.0;
        } completion:nil];
    } else {
        self.dimmingView.alpha = 1.0;
    }
    
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    // If the presentation was canceled, remove the dimming view.
    if (!completed)
        [self.dimmingView removeFromSuperview];
}

- (void)dismissalTransitionWillBegin {
    
    UIViewController *presentedViewController = self.presentedViewController;
    
    if([presentedViewController transitionCoordinator]) {
        [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.dimmingView.alpha = 0.0;
        } completion:nil];
    } else {
        self.dimmingView.alpha = 0.0;
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    // If the dismissal was successful, remove the dimming view.
    if (completed)
        [self.dimmingView removeFromSuperview];
}


#pragma mark - DimmingView setup

- (void)setupDimmingView {
    
    self.dimmingView = [UIView new];
    self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    self.dimmingView.alpha = 0.0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)];
    [self.dimmingView addGestureRecognizer:tap];
    
}

- (void)dimmingViewTapped:(UIGestureRecognizer *)gesture {
    
    if([gesture state] == UIGestureRecognizerStateRecognized && self.dimmingViewTapDismissEnabled) {
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
    
}

@end
