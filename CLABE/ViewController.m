//
//  ViewController.m
//  CLABE
//
//  Created by Jorge Villa on 12/14/15.
//  Copyright © 2015 kinejara. All rights reserved.
//

#import "ViewController.h"
#import "NSString+PNGCLABEValidator.h"

@interface ViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *CLABETextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.CLABETextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)validateCLABEForm:(NSString *)CLABE {
    BOOL isValidClabe = [NSString isValidCLABE:CLABE];
    
    if (isValidClabe) {
        NSLog(@"VALID");
    } else {
        NSLog(@"INVALID");
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newString.length == 18) {
        [self validateCLABEForm:newString];
    }
    
    return (newString.length<=18);
}

@end
