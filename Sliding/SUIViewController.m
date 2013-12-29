//
//  SUIViewController.m
//  Sliding
//
//  Created by Jacob Sokolov on 29/12/13.
//  Copyright (c) 2013 Jacob Sokolov. All rights reserved.
//

#import "SUIViewController.h"
#import "SUISocialViewController.h"

@interface SUIViewController () <UIActionSheetDelegate>
{
    UIButton * backImage;
    UIButton * devInfo;
    
    UIView *dropTarget;
    
    UIImageView *subject;
    
    UIActionSheet * devSheet;
    
    CGPoint touchOffset;
    CGPoint homePosition;
}

@end

@implementation SUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
}

- (void)setUp
{
    subject = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"doge.png"]];
    subject.frame = CGRectMake(60, 184, 200, 200);
    
    devInfo = [UIButton buttonWithType:UIButtonTypeSystem];
    [devInfo setFrame:CGRectMake(0, 0, 40, 40)];
    [devInfo setTitle:@"i" forState:UIControlStateNormal];
    [devInfo addTarget:self action:@selector(loadDevSheet) forControlEvents:UIControlEventTouchUpInside];
    
    backImage = [UIButton buttonWithType:UIButtonTypeSystem];
    [backImage setTitle:@"back" forState:UIControlStateNormal];
    [backImage setFrame:CGRectMake(0, 0, 40, 40)];
    [backImage addTarget:self action:@selector(returnImageBack) forControlEvents:UIControlEventTouchUpInside];
    
    devSheet = [[UIActionSheet alloc]initWithTitle:@"Developer" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"Twitter" otherButtonTitles:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backImage];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:devInfo];
    
    [self.view addSubview:subject];
}

- (void)cancelBump
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        for (UIImageView *iView in self.view.subviews)
        {
            if ([iView isMemberOfClass:[UIImageView class]])
            {
                if (touchPoint.x > iView.frame.origin.x &&
                    touchPoint.x < iView.frame.origin.x + iView.frame.size.width &&
                    touchPoint.y > iView.frame.origin.y &&
                    touchPoint.y < iView.frame.origin.y + iView.frame.size.height)
                {
                    self->subject = iView;
                    self->touchOffset = CGPointMake(touchPoint.x - iView.frame.origin.x,
                                                    touchPoint.y - iView.frame.origin.y);
                    self->homePosition = CGPointMake(iView.frame.origin.x,
                                                     iView.frame.origin.y);
                    [self.view bringSubviewToFront:self->subject];
                }
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    CGRect newDragObjectFrame = CGRectMake(touchPoint.x - touchOffset.x,
                                           touchPoint.y - touchOffset.y,
                                           self->subject.frame.size.width,
                                           self->subject.frame.size.height);
    self->subject.frame = newDragObjectFrame;
}

- (void)loadDevSheet
{
    [devSheet showInView:self.view];
}

- (void)returnImageBack
{
    subject.frame = CGRectMake(60, 184, 200, 200);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self presentSocialController];
    }
}

- (void)presentSocialController
{
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[[SUISocialViewController alloc]init]] animated:YES completion:NULL];
}

@end
