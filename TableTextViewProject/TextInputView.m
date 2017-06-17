//
//  TextInputView.m
//  TextInputViewDemo
//
//  Created by Mahendra Bhama on 28/11/16.
//  Copyright © 2016 Cacao Solutions. All rights reserved.
//

#import "TextInputView.h"
#import "TextInsetsLabel.h"
#define Cell  @"cell"

NS_ASSUME_NONNULL_BEGIN

@interface TextInputView ()
{
    UIStackView* stackView;
    UIView* dividerView;
    TextInsetsLabel* messageLabel;
    
    NSLayoutConstraint* bottomLineLabelHeightConstraint;
    NSLayoutConstraint* tableHeightConstraint;
}

@end

@implementation TextInputView

#pragma mark - INIT

-(nullable instancetype)initWithCoder:(NSCoder*)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(instancetype)init {
    if(self = [super init]) {
        [self setup];
    }
    return self;
}


#pragma mark - Interface Builder Appearance

-(void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    
    _textField.placeholder = _placeholder;
    _textField.text = _text;
    messageLabel.text = _message;
    
    _textField.font = _textFont;
    messageLabel.font = _messageFont;
    
    _textField.textColor = _textColor;
    messageLabel.textColor = _messageColor;
    
    dividerView.backgroundColor = _dividerNormalColor;
}


#pragma mark - Setup

-(void)setup
{
    _textFont = [UIFont systemFontOfSize:16];
    _messageFont = [UIFont systemFontOfSize:12];
    
    _textColor = [UIColor blackColor];
    _messageColor = [UIColor grayColor];
    
    _dividerNormalColor = [UIColor lightGrayColor];
    _dividerActiveColor = [self tintColor];
    
    
    stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    [self addSubview:stackView];
    
    [[stackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0] setActive:YES];
    [[stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0] setActive:YES];
    [[stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0] setActive:YES];
    [[stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0] setActive:YES];
    
    
    _textField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    dividerView = [[UIView alloc] initWithFrame:CGRectZero];
    dividerView.backgroundColor = _dividerNormalColor;
    
    messageLabel = [[TextInsetsLabel alloc] initWithFrame:CGRectZero];
    [messageLabel setTextInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
    messageLabel.numberOfLines = 2;
    messageLabel.font = _messageFont;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableHeightConstraint = [_tableView.heightAnchor constraintEqualToConstant:0];
    _tableView.delegate = self;
     _tableView.dataSource = self;
    [tableHeightConstraint setActive:YES];
    [stackView insertArrangedSubview:_textField atIndex:0];
    [stackView insertArrangedSubview:dividerView atIndex:1];
    [stackView insertArrangedSubview:_tableView atIndex:2];
    [stackView insertArrangedSubview:messageLabel atIndex:3];
    bottomLineLabelHeightConstraint = [dividerView.heightAnchor constraintEqualToConstant:1];
    [bottomLineLabelHeightConstraint setActive:YES];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(highlightBottomLine:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unhighlightBottomLine:) name:UITextFieldTextDidEndEditingNotification object:nil];
}


#pragma mark - Convenience

-(void)showMessage:(NSString*)message
{
    [self showMessage:message textColor:messageLabel.textColor];
}

-(void)showMessage:(NSString*)message textColor:(UIColor *)color
{
    
    messageLabel.text = message;
    messageLabel.textColor = color;
    if (messageLabel.text.length > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self invalidateIntrinsicContentSize];
            
        });
    }
}

-(void)hideMessage
{
    
    messageLabel.text = @"";
     if (messageLabel.text.length == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self invalidateIntrinsicContentSize];
        });
     }
}


#pragma mark - Intrinsic Content Size

-(CGSize)intrinsicContentSize
{
    return stackView.intrinsicContentSize;
}


#pragma mark - Properties

-(void)setPlaceholder:(nullable NSString*)placeholder
{
    _placeholder = placeholder;
    _textField.placeholder = _placeholder;
}

-(void)setText:(nullable NSString*)text
{
    _text = text;
    _textField.text = _text;
}

-(void)setMessage:(nullable NSString*)message
{
    _message = message;
    messageLabel.text = message;
}

-(void)setTextFont:(UIFont*)textFont
{
    _textFont = textFont;
    _textField.font = _textFont;
}

-(void)setMessageFont:(UIFont*)messageFont
{
    _messageFont = messageFont;
    messageLabel.font = _messageFont;
}

-(void)setTextColor:(UIColor*)textColor
{
    _textColor = textColor;
    _textField.textColor = _textColor;
}

-(void)setMessageColor:(UIColor*)messageColor
{
    _messageColor = messageColor;
    messageLabel.textColor = messageColor;
}

-(void)setDividerNormalColor:(UIColor*)dividerNormalColor
{
    _dividerNormalColor = dividerNormalColor;
    dividerView.backgroundColor = _dividerNormalColor;
}

-(void)setDividerActiveColor:(UIColor*)dividerActiveColor
{
    _dividerActiveColor = dividerActiveColor;
    dividerView.backgroundColor = _dividerActiveColor;
}


#pragma mark - Notification Handlers

-(void)highlightBottomLine:(NSNotification*)notification
{
    if([notification.object isEqual:self.textField])
    {
        if(_valueArray.count > 0)
            [tableHeightConstraint setConstant:200];
        
        [bottomLineLabelHeightConstraint setConstant:2];
        [dividerView setBackgroundColor:_dividerActiveColor];
    }
}

-(void)unhighlightBottomLine:(NSNotification*)notification
{
    if([notification.object isEqual:self.textField])
    {   [tableHeightConstraint setConstant:0];
        [bottomLineLabelHeightConstraint setConstant:1];
        [dividerView setBackgroundColor:_dividerNormalColor];
    }
}


#pragma mark - UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _valueArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = Cell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = _valueArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _textField.text = _valueArray[indexPath.row];
    [tableHeightConstraint setConstant:0];
    [_textField resignFirstResponder];
}

@end

NS_ASSUME_NONNULL_END
