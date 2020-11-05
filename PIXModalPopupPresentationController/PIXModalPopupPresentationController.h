//
//  PIXModalPopupPresentationController.h
//  CustomPresentationController
//
//  Created by Andrea Ottolina on 04/11/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PIXModalPopupPresentationController : UIPresentationController <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) BOOL dimmingViewTapDismissEnabled;
@property (nonatomic, assign) BOOL useContainerSafeAreaInsets;
@property (nonatomic, assign) UIEdgeInsets popupEdgeInsets;

@end

NS_ASSUME_NONNULL_END
