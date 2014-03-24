//
//  ISLNumberPadField.h
//  ISLPopOverNumberPad
//
//  Created by Eldhose on 21-03-2014.
//  Copyright (c) 2014 Islet Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ISLNumberPadGap 2.0
#define ISLNumberUnitWidth 362.0
#define IslNumberUnitHeight 466.0
typedef NS_ENUM(NSUInteger,NumberPadAt) {
    NumberPadAtButtom=0,
    NumberPadAtTop,
    NumberPadAtLeft,
    NumberPadAtRight
};
typedef void (^NumberPadWillShow)(UIView * numberPadView,NSArray * btns);
typedef void (^NumberPadAButtonTouched)(UIButton *touchedButton);
typedef void (^TextChanged)(NSString * newText);
typedef void (^TextDoneEditing)();
@interface ISLNumberPadField : UILabel{
    NumberPadWillShow numberPadWillShowHandle;
    NumberPadAButtonTouched numberpadButtonTouchhandle;
    TextChanged btnTextChangehandle;
    TextDoneEditing txtDoneEditinghandle;
}
@property(nonatomic,strong) UIView * numberPadView;
@property(nonatomic,strong) NSArray * btnArray;


- (void)setNumberPadWillShow:(NumberPadWillShow) ahandle;
- (void)setNumberPadAButtonTouched:(NumberPadAButtonTouched) ahandle;
- (void)setTextChanged:(TextChanged)ahandle;
- (void)setTextDoneEditing:(TextDoneEditing)ahandle;

- (instancetype)initWithFrame:(CGRect)frame forTheSuperView:(UIView *)superView withSize:(CGSize)size andAppearIn:(NumberPadAt) direction;
- (instancetype)initWithFrame:(CGRect)frame forTheSuperView:(UIView *)superView withScale:(CGFloat)scaleValue andAppearIn:(NumberPadAt)direction;
- (void)setNumberPadSize:(CGSize)size forTheSuperView:(UIView *)superView andAppearIn:(NumberPadAt) direction;
@end
