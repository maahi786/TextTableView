//
//  TextInputView.h
//  TextInputViewDemo
//
//  Created by Mahendra Bhama on 28/11/16.
//  Copyright © 2016 Cacao Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface TextInputView : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)IBInspectable JVFloatLabeledTextField* textField;

@property(nonatomic,strong,nullable)IBInspectable NSString* placeholder;
@property(nonatomic,strong,nullable)IBInspectable NSString* text;
@property(nonatomic,strong,nullable)IBInspectable NSString* message;

@property(nonatomic,strong)UIFont* textFont;
@property(nonatomic,strong)UIFont* messageFont;
@property(nonatomic,strong)NSArray* valueArray;
@property(nonatomic,strong)IBInspectable UIColor* textColor;
@property(nonatomic,strong)IBInspectable UIColor* messageColor;

@property(nonatomic,strong)IBInspectable UIColor* dividerNormalColor;
@property(nonatomic,strong)IBInspectable UIColor* dividerActiveColor;

@property(nonatomic,strong)IBInspectable UITableView* tableView;

-(void)showMessage:(NSString*)message;
-(void)showMessage:(NSString*)message textColor:(UIColor*)color;

-(void)hideMessage;

@end

NS_ASSUME_NONNULL_END
