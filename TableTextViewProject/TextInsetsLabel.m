//
//  TextInsetsLabel.m
//  DemoProducer
//
//  Created by Shivam Singhal on 12/14/16.
//  Copyright © 2016 Cacao. All rights reserved.
//

#import "TextInsetsLabel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TextInsetsLabel

#pragma mark - Intrinsic Content Size

-(CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    
    if([self shouldApplyTextInsets])
    {
        size.width += (_textInsets.left + _textInsets.right);
        size.height += (_textInsets.top + _textInsets.bottom);
    }
    
    return size;
}

-(void)drawTextInRect:(CGRect)rect {
    
    if([self shouldApplyTextInsets] && !UIEdgeInsetsEqualToEdgeInsets(_textInsets, UIEdgeInsetsZero)) {
        rect.origin.x += _textInsets.left;
        rect.size.width -= (_textInsets.left + _textInsets.right);
        rect.origin.y += _textInsets.top;
        rect.size.height -= (_textInsets.top + _textInsets.bottom);
    }
    
    [super drawTextInRect:rect];
}


#pragma mark - Text Insets Support

-(void)setTextInsets:(UIEdgeInsets)textInsets {
    _textInsets = textInsets;
    [self invalidateIntrinsicContentSize];
}


#pragma mark - Helpers

-(BOOL)shouldApplyTextInsets {
    return (self.text.length > 0 || self.attributedText.string.length > 0);
}

@end

NS_ASSUME_NONNULL_END
