//
//  NSString+NSString_PNGCLABEValidator.m
//  Pangea
//
//  Created by Jorge Villa on 12/7/15.
//  Copyright © 2015 gopangea. All rights reserved.
//

#import "NSString+PNGCLABEValidator.h"

@implementation NSString (PNGCLABEValidator)


+ (NSDictionary *)ABMBankNumbers {
    return @{
             @"002" : @"BANAMEX",
             @"012" : @"BBVA BANCOMER",
             @"014" : @"SANTANDER",
             @"019" : @"BANJERCITO",
             @"021" : @"HSBC",
             @"022" : @"GE MONEY",
             @"030" : @"BAJIO",
             @"032" : @"IXE",
             @"036" : @"INBURSA",
             @"037" : @"INTERACCIONES",
             @"042" : @"MIFEL",
             @"044" : @"SCOTIABANK",
             @"058" : @"BANREGIO",
             @"059" : @"INVEX",
             @"060" : @"BANSI",
             @"062" : @"AFIRME",
             @"072" : @"BANORTE",
             @"102" : @"ABNAMRO",
             @"103" : @"AMERICAN EXPRESS",
             @"106" : @"BAMSA",
             @"108" : @"TOKYO",
             @"110" : @"JP MORGAN",
             @"112" : @"BMONEX",
             @"113" : @"VE POR MAS",
             @"116" : @"ING",
             @"124" : @"DEUTSCHE",
             @"126" : @"CREDIT SUISSE",
             @"127" : @"AZTECA",
             @"128" : @"AUTOFIN",
             @"129" : @"BARCLAYS",
             @"130" : @"COMPARTAMOS",
             @"131" : @"FAMSA",
             @"132" : @"BMULTIVA",
             @"133" : @"ACTINVER",
             @"134" : @"WAL-MART",
             @"136" : @"REGIONAL",
             @"137" : @"BANCOPPEL",
             @"138" : @"AMIGO",
             @"139" : @"UBS BANK",
             @"140" : @"FÁCIL",
             @"143" : @"CONSULTORIA",
             @"147" : @"BANKAOOL",
             @"166" : @"BANSEFI",
             @"166" : @"BANSEFI",
             @"168" : @"HIPOTECARIA FEDERAL",
             @"600" : @"MONEXCB",
             @"601" : @"GBM",
             @"602" : @"MASARI CC.",
             @"604" : @"C.B. INBURSA",
             @"605" : @"VALUÉ",
             @"606" : @"CB BASE",
             @"607" : @"TIBER",
             @"608" : @"VECTOR",
             @"610" : @"B&B",
             @"611" : @"INTERCAM",
             @"613" : @"MULTIVA",
             @"614" : @"ACCIVAL",
             @"615" : @"MERRILL LYNCH",
             @"616" : @"FINAMEX",
             @"617" : @"VALMEX",
             @"618" : @"ÚNICA",
             @"619" : @"ASEGURADORA MAPFRE",
             @"620" : @"AFORE PROFUTURO",
             @"621" : @"CB ACTINBER",
             @"622" : @"ACTINVE SI	",
             @"623" : @"SKANDIA",
             @"624" : @"CONSULTORIA",
             @"627" : @"ZURICH",
             @"628" : @"ZURICHVI",
             @"629" : @"HIPOTECARIA SU CASITA",
             @"630" : @"C.B. INTERCAM",
             @"631" : @"C.B. VANGUARDIA",
             @"632" : @"BULLTICK C.B.",
             @"634" : @"AKALA",
             @"638" : @"HSBC",
             @"640" : @"JP MORGAN C.B.",
             @"646" : @"STP",
             @"901" : @"CLS",
             @"902" : @"INDEVAL"
             };
}

+ (NSArray *)digitWeights {
    return @[@"3", @"7", @"1",
             @"3", @"7", @"1",
             @"3", @"7", @"1",
             @"3", @"7", @"1",
             @"3", @"7", @"1",
             @"3", @"7"];
}

+ (NSArray *)bankCodes {
    NSDictionary *ABMBankNumbers = [self ABMBankNumbers];
    
    return ABMBankNumbers.allKeys;
}

+ (BOOL)hasValidLenght:(NSString *)clabeString {
    if (clabeString.length != 18) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isAllDigits:(NSString *)clabeString {
    NSCharacterSet *nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [clabeString rangeOfCharacterFromSet:nonNumbers];
    
    return r.location == NSNotFound;
}

+ (BOOL)hasValidABMNumber:(NSString *)clabeString {
    NSString *typedAbmNumber = [clabeString substringToIndex:3];
    NSArray *storedBankCodes = [self bankCodes];
    
    for (NSString *storedBankCode in storedBankCodes) {
        if ([storedBankCode isEqualToString:typedAbmNumber]) {
            return YES;
        }
    }
    
    return NO;
}

+ (NSArray *)clabeArray:(NSString *)clabeString {
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:clabeString.length];
   
    for (int i = 0; i < clabeString.length - 1; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [clabeString characterAtIndex:i]];
        [characters addObject:ichar];
    }
    
    return characters;
}

+ (BOOL)hasValidControlDigit:(NSString *)clabeString {
    NSArray *digitWeights = [self digitWeights];
    
    NSArray *clabeNumbers = [self clabeArray:clabeString];
    NSMutableArray *mods = [NSMutableArray new];
    
    [digitWeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *digitWeight = (NSString *)obj;
        NSString *clabeNumber = (NSString *)[clabeNumbers objectAtIndex:idx];
        
        NSInteger integerWeight = digitWeight.intValue;
        NSInteger integerClabe = clabeNumber.intValue;
        NSInteger clabeProduct = integerClabe * integerWeight;
        
        float moduloResult = (float)((int)clabeProduct % 10);
        NSNumber *moduloResultNumber = [NSNumber numberWithFloat:moduloResult];
        
        [mods addObject:moduloResultNumber];
    }];
    
    NSInteger sum = 0;
    
    for (NSNumber *clabeNumber in mods) {
        sum += [clabeNumber intValue];
    }
    
    NSString *typedControlDigit = [clabeString substringFromIndex:clabeString.length - 1];
    
    float productSum = (float)((int)sum % 10);
    float tenLessProductSum = 10 - productSum;
    
    NSInteger typedControlNumber = typedControlDigit.integerValue;
    NSInteger controlDigitNumber = (float)((int)tenLessProductSum % 10);
    
    if (typedControlNumber == controlDigitNumber) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isValidCLABE:(NSString *)clabeString {
    clabeString = [clabeString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![self isAllDigits:clabeString]) {
        return NO;
    } else if (![self hasValidLenght:clabeString]) {
        return NO;
    } else if (![self hasValidABMNumber:clabeString]) {
        return NO;
    } else if (![self hasValidControlDigit:clabeString]) {
        return NO;
    }
    
    return YES;
}


@end
