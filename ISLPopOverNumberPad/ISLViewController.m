//
//  ISLViewController.m
//  ISLPopOverNumberPad
//
//  Created by Eldhose on 21-03-2014.
//  Copyright (c) 2014 Islet Systems. All rights reserved.
//

#import "ISLViewController.h"
#import "ISLNumberPadField.h"

@interface ISLViewController (){
    NumberPadAt pos;
}
@property (weak, nonatomic) IBOutlet ISLNumberPadField *numberInput;

@end

@implementation ISLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    pos = NumberPadAtButtom;
    [self.numberInput setNumberPadSize:CGSizeMake(366, 475) forTheSuperView:self.view andAppearIn:NumberPadAtButtom];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnSwitchValueChanged:(UISegmentedControl *)sender {
    pos = sender.selectedSegmentIndex;
    [self.numberInput setNumberPadSize:CGSizeMake(200, 260) forTheSuperView:self.view andAppearIn:pos];
}

@end
