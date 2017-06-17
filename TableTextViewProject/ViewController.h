//
//  ViewController.h
//  TableTextViewProject
//
//  Created by MaahiHiten on 17/12/16.
//  Copyright © 2016 MaahiHiten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextInputView.h"

@interface ViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong) IBOutlet TextInputView* firstNameInputView;
@property(nonatomic,strong) IBOutlet TextInputView* lastNameInputView;
@property(nonatomic,strong) IBOutlet TextInputView* stateInputView;
@property(nonatomic,strong) IBOutlet TextInputView* countryInputView;
@end

