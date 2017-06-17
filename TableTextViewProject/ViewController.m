//
//  ViewController.m
//  TableTextViewProject
//
//  Created by MaahiHiten on 17/12/16.
//  Copyright © 2016 MaahiHiten. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _firstNameInputView.textField.delegate = _lastNameInputView.textField.delegate = _stateInputView.textField.delegate = _countryInputView.textField.delegate = self;
    _countryInputView.valueArray = @[@"q",@"r",@"s",@"t",@"q",@"r",@"s",@"t",@"q",@"r",@"s",@"t"];
    _stateInputView.valueArray = @[@"my",@"r",@"s",@"t",@"q",@"r",@"s",@"t",@"q",@"r",@"s",@"t"];
    
}


#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
  
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField isEqual:_firstNameInputView.textField] && _firstNameInputView.textField.text.length == 0)
    {
    [_firstNameInputView showMessage:@"Please Select Value For Name" textColor:[UIColor redColor]];
    
    }
    if(_firstNameInputView.textField.text.length > 0)
    {
    [_firstNameInputView hideMessage];
    }
    
    if([textField isEqual:_lastNameInputView.textField] && _lastNameInputView.textField.text.length == 0)
    {
        [_lastNameInputView showMessage:@"Please Select Value For Name" textColor:[UIColor redColor]];
        
    }
    if(_lastNameInputView.textField.text.length > 0)
    {
        [_lastNameInputView hideMessage];
    }
    if([textField isEqual:_stateInputView.textField] && _stateInputView.textField.text.length == 0)
    {
        [_stateInputView showMessage:@"Please Select Value For Name" textColor:[UIColor redColor]];
        
    }
    if(_stateInputView.textField.text.length > 0)
    {
        [_stateInputView hideMessage];
    }

}


@end
