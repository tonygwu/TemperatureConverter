//
//  TemperatureConverterViewController.m
//  Temperature Converter
//
//  Created by Tony Wu on 10/9/13.
//  Copyright (c) 2013 Tony Wu. All rights reserved.
//

#import "TemperatureConverterViewController.h"

@interface TemperatureConverterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fahrenheitTextField;
@property (weak, nonatomic) IBOutlet UITextField *celsiusTextField;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (assign, nonatomic) BOOL fahrenheitLastTouched;
- (void)updateTemperature;
+ (float) celsiusWithFahrenheit:(float) fahrenheit;
+ (float) fahrenheitWithCelsius:(float) celsius;
- (IBAction)onTap:(id)sender;
@end

@implementation TemperatureConverterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Temperature";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.convertButton addTarget:self action:@selector(updateTemperature) forControlEvents:UIControlEventTouchUpInside];
    
    [self.fahrenheitTextField addTarget:self action:@selector(didLastEditFahrenheit) forControlEvents:UIControlEventAllEditingEvents];
    
    [self.celsiusTextField addTarget:self action:@selector(didLastEditCelsius) forControlEvents:UIControlEventAllEditingEvents];
    // Do any additional setup after loading the view from its nib.
}

- (void) didLastEditFahrenheit
{
    self.fahrenheitLastTouched = true;
}

- (void) didLastEditCelsius
{
    self.fahrenheitLastTouched = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) onTap:(id) sender
{
    [self.view endEditing:YES];
}

# pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDoneButton)];
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = nil;
    return YES;
}

# pragma mark - Public methods
- (void)updateTemperature {
    NSScanner *celsiusScanner = [NSScanner scannerWithString:self.celsiusTextField.text];
    NSScanner *fahrenheitScanner = [NSScanner scannerWithString:self.fahrenheitTextField.text];
    float celsius, fahrenheit;
    BOOL celsiusValid = [celsiusScanner scanFloat:&celsius];
    BOOL fahrenheitValid = [fahrenheitScanner scanFloat:&fahrenheit];
    
    if (celsiusValid && !fahrenheitValid) {
        self.fahrenheitTextField.text = [NSString stringWithFormat:@"%0.2f", [TemperatureConverterViewController fahrenheitWithCelsius:celsius]];
    } else if (fahrenheit && !celsiusValid) {
        self.celsiusTextField.text = [NSString stringWithFormat:@"%0.2f", [TemperatureConverterViewController celsiusWithFahrenheit:fahrenheit]];
    } else if (fahrenheitValid && celsiusValid) {
        if (self.fahrenheitLastTouched) {
            self.celsiusTextField.text = [NSString stringWithFormat:@"%0.2f", [TemperatureConverterViewController celsiusWithFahrenheit:fahrenheit]];
        } else {
            self.fahrenheitTextField.text = [NSString stringWithFormat:@"%0.2f", [TemperatureConverterViewController fahrenheitWithCelsius:celsius]];
        }
    }
}

# pragma mark - Private methods
- (void)onDoneButton {
    [self.view endEditing:YES];
}

+ (float)celsiusWithFahrenheit:(float)fahrenheit
{
    return (fahrenheit - 32.0) * 5 / 9;
}

+ (float)fahrenheitWithCelsius:(float)celsius
{
    return (celsius) * 9 / 5 + 32;
}

@end
