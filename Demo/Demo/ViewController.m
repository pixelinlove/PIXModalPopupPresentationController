//
//  ViewController.m
//  Demo
//
//  Created by Andrea Ottolina on 05/11/2020.
//

#import "ViewController.h"
#import "PopupViewController.h"
#import "PIXModalPopupPresentationController.h"

@interface ViewController ()

- (IBAction)buttonDidTap:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonDidTap:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopupViewController *vc = [sb instantiateViewControllerWithIdentifier:@"PopupViewController"];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    PIXModalPopupPresentationController *presentationController = [[PIXModalPopupPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentationController.dimmingViewTapDismissEnabled = YES;
    presentationController.useContainerSafeAreaInsets = YES;
    
    return presentationController;
}

@end
