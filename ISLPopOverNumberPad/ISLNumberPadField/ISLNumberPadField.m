//
//  ISLNumberPadField.m
//  ISLPopOverNumberPad
//
//  Created by Eldhose on 21-03-2014.
//  Copyright (c) 2014 Islet Systems. All rights reserved.
//

#import "ISLNumberPadField.h"

@implementation ISLNumberPadField{
    __weak UIView * theSuperView;
    NumberPadAt apperAt;
    CGSize numberPadSize;
    
    
    UIButton *dismissNumberPadButton;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame forTheSuperView:(UIView *)superView withSize:(CGSize)size andAppearIn:(NumberPadAt) direction{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNumberPadSize:size forTheSuperView:superView andAppearIn:direction];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame forTheSuperView:(UIView *)superView withScale:(CGFloat)scaleValue andAppearIn:(NumberPadAt)direction{
    CGSize asize = CGSizeMake(ISLNumberUnitWidth*scaleValue, IslNumberUnitHeight*scaleValue);
    return [self initWithFrame:frame forTheSuperView:superView withSize:asize andAppearIn:direction];
}
- (void)setNumberPadSize:(CGSize)size forTheSuperView:(UIView *)superView andAppearIn:(NumberPadAt) direction{
    theSuperView = superView;
    apperAt = direction;
    numberPadSize = size;
    
    

    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(showNumberPad)];
    [self addGestureRecognizer:singleFingerTap];
    
}
-(void)hideNumberPad{
    [dismissNumberPadButton removeFromSuperview];
    dismissNumberPadButton = nil;
    [_numberPadView removeFromSuperview];
    _numberPadView = nil;
    numberpadButtonTouchhandle = nil;
    numberPadWillShowHandle = nil;
    btnTextChangehandle = nil;
    if (txtDoneEditinghandle) {
        txtDoneEditinghandle();
        txtDoneEditinghandle = nil;
    }
   

}
-(void)showNumberPad{
    if (!theSuperView) {
        NSLog(@"No superView Set");
        return;
    }
    CGRect arec =[self convertRect:self.bounds toView:theSuperView];
    if (_numberPadView) {
        [_numberPadView removeFromSuperview];
        _numberPadView = nil;
    }
    
    switch (apperAt) {
        case NumberPadAtButtom:
            arec.origin.y += arec.size.height+ISLNumberPadGap;
            arec.origin.x -= (numberPadSize.width/2- self.bounds.size.width/2);
            break;
        case NumberPadAtTop:
            arec.origin.y -= (ISLNumberPadGap+numberPadSize.height);
            arec.origin.x -= (numberPadSize.width/2- self.bounds.size.width/2);
            break;
        case NumberPadAtRight:
            arec.origin.x += arec.size.width+ISLNumberPadGap;
            arec.origin.y -= (numberPadSize.height/2- self.bounds.size.height/2);
            break;
        case NumberPadAtLeft:
            arec.origin.x -= (ISLNumberPadGap+numberPadSize.width);
            arec.origin.y -= (numberPadSize.height/2- self.bounds.size.height/2);
            break;
        default:
            break;
    }
    arec.size.height = numberPadSize.height;
    arec.size.width =  numberPadSize.width;
    _numberPadView = [[UIView alloc] initWithFrame:arec];
    _numberPadView.backgroundColor = [UIColor whiteColor];
    // _numberPadView.center = center;
    CGFloat numBtnWith = (numberPadSize.width - (ISLNumberPadGap*4))/3;
    CGFloat numBtnHeight = (numberPadSize.height - (ISLNumberPadGap*5))/4;
    NSMutableArray * numBtnArry = [@[] mutableCopy];
    for (int i=0; i<4; i++) {
        for (int j=0; j<3; j++) {
            UIButton * abtn = [[UIButton alloc] initWithFrame:CGRectMake((ISLNumberPadGap*(1+j))+(j*numBtnWith), (ISLNumberPadGap*(1+i))+(i*numBtnHeight), numBtnWith, numBtnHeight)];
            [abtn addTarget:self
                                       action:@selector(btnInNumberPadTouch:)
                             forControlEvents:UIControlEventTouchDown];
            [numBtnArry addObject:abtn];
            
            if (!numberPadWillShowHandle) {
                abtn.tag = i+j+1+i*2;
                [abtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [abtn.titleLabel setFont:self.font];
                if (abtn.tag == 10) {
                    [abtn setTitle:@"." forState:UIControlStateNormal];
                    [abtn setBackgroundImage:[UIImage imageNamed:@"numBg"] forState:UIControlStateNormal];
                    
                }else if (abtn.tag == 11){
                    [abtn setTitle:@"0" forState:UIControlStateNormal];
                    [abtn setBackgroundImage:[UIImage imageNamed:@"numBg"] forState:UIControlStateNormal];
                    
                }else if (abtn.tag == 12){
                    [abtn setTitle:@"" forState:UIControlStateNormal];
                    [abtn setBackgroundImage:[UIImage imageNamed:@"deleteLast"] forState:UIControlStateNormal];
                    
                }else{
                    [abtn setTitle:[NSString stringWithFormat:@"%d",abtn.tag] forState:UIControlStateNormal];
                    [abtn setBackgroundImage:[UIImage imageNamed:@"numBg"] forState:UIControlStateNormal];
                    
                }

            }
            [_numberPadView addSubview:abtn];

        }
    }
    self.btnArray = [NSArray arrayWithArray:numBtnArry];
    dismissNumberPadButton =[[UIButton alloc] initWithFrame:theSuperView.frame];
    [dismissNumberPadButton addTarget:self
                               action:@selector(hideNumberPad)
                     forControlEvents:UIControlEventTouchDown];
    
    if (numberPadWillShowHandle) {
        numberPadWillShowHandle(_numberPadView,@[]);
    }
    [theSuperView addSubview:dismissNumberPadButton];
    [theSuperView addSubview:_numberPadView];
    
}


- (void)setNumberPadWillShow:(NumberPadWillShow) ahandle{
    numberPadWillShowHandle = ahandle;
}
- (void)setNumberPadAButtonTouched:(NumberPadAButtonTouched) ahandle{
    numberpadButtonTouchhandle = ahandle;
}
- (void)setTextChanged:(TextChanged)ahandle{
    btnTextChangehandle = ahandle;
}
- (void)setTextDoneEditing:(TextDoneEditing)ahandle{
    txtDoneEditinghandle = ahandle;
}

#pragma mark KeyBord functions
- (void)btnInNumberPadTouch:(UIButton *)sender {
    if (numberpadButtonTouchhandle) {
        numberpadButtonTouchhandle(sender);
    }else{
        UIButton *tmp = (UIButton*)sender;
        NSString *inputTo = self.text;
        if (!inputTo) {
            inputTo = @"";
        }
        int wat = (int)tmp.tag;
        switch (wat) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 11:
                inputTo = [NSString stringWithFormat:@"%@%@", inputTo,sender.titleLabel.text];
                break;
            case 12:
                if ([inputTo length]>0) {
                    NSString *newString = [inputTo substringToIndex:[inputTo length]-1];
                    inputTo = newString;
                }
                break;
            case 10:
                if ([inputTo rangeOfString:@"."].location ==NSNotFound) {
                    inputTo = [NSString stringWithFormat:@"%@%@", inputTo,sender.titleLabel.text];
                }
                break;
            default:
                break;
        }
//        if ([inputTo rangeOfString:@"."].location !=NSNotFound) {
//            if ([([inputTo componentsSeparatedByString:@"."][1]) length]>2) {
//                NSString *newString = [inputTo substringToIndex:[inputTo length]-1];
//                inputTo = newString;
//            }
//        }
        self.text = inputTo;
        if (btnTextChangehandle) {
            btnTextChangehandle(inputTo);
        }

        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
