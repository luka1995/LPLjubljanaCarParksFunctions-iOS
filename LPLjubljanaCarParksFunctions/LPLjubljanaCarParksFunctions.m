//
//  LPLjubljanaCarParksFunctions.m
//  LPCarParksExample
//
//  Created by Luka Penger on 17/03/14.
//  Copyright (c) 2014 Luka Penger. All rights reserved.
//

// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2014 Luka Penger
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LPLjubljanaCarParksFunctions.h"


@implementation LPLjubljanaCarParksFunctions

NSString *const parksURL = @"http://www.lpt.si/uploads/xml/map/parkirisca.xml";

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        self.occupancyFunctions = [LPLjubljanaCarParksOccupancyFunctions new];
        self.occupancyFunctions.delegate = self;
        
        self.parksList = [NSMutableArray new];
        self.parkingMachinesList = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - Functions

- (void)load
{
    if ([self.delegate respondsToSelector:@selector(ljubljanaCarParksFunctionsWillLoadParks:)]) {
        [self.delegate ljubljanaCarParksFunctionsWillLoadParks:self];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:parksURL]];
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        XMLParser.delegate = self;
        [XMLParser parse];
    } failure:nil];
    [operation start];
    
    [self.occupancyFunctions load];
}

- (void)setOccupancyToCarParks
{
    for(int i=0; i<self.parksList.count; i++) {
        LPLjubljanaCarPark *carPark = (LPLjubljanaCarPark*)[self.parksList objectAtIndex:i];
     
        carPark.occupancy = [self.occupancyFunctions getOccupancyForParkID:carPark.parkID];
    }
}

- (NSString *)searchNumberInString:(NSString *)string
{
    NSString *numberString = nil;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"-0123456789"];
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    return numberString;
}

#pragma mark - LPLjubljanaCarParksOccupancyFunctions Delegate

- (void)ljubljanaCarParksOccupancyFunctionsWillLoadOccupancy:(LPLjubljanaCarParksOccupancyFunctions *)ljubljanaCarParksOccupancyFunctions
{
    
}

- (void)ljubljanaCarParksOccupancyFunctions:(LPLjubljanaCarParksOccupancyFunctions *)ljubljanaCarParksOccupancyFunctions didLoadOccupancy:(NSMutableArray *)occupancyList
{
    [self setOccupancyToCarParks];
    
    if ([self.delegate respondsToSelector:@selector(ljubljanaCarParksFunctions:didLoadOccupancyToCarParks:)]) {
        [self.delegate ljubljanaCarParksFunctions:self didLoadOccupancyToCarParks:self.parksList];
    }
}

- (void)ljubljanaCarParksOccupancyFunctions:(LPLjubljanaCarParksOccupancyFunctions *)ljubljanaCarParksOccupancyFunctions errorLoadingOccupancy:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(ljubljanaCarParksFunctions:errorLoadingOccupancyToCarParks:)]) {
        [self.delegate ljubljanaCarParksFunctions:self errorLoadingOccupancyToCarParks:error];
    }
}

#pragma mark - XML Parser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    if(!self.parksList)
        self.parksList = [NSMutableArray new];
    
    if(!self.parkingMachinesList)
        self.parkingMachinesList = [NSMutableArray new];
    
    [self.parksList removeAllObjects];
    
    [self.parkingMachinesList removeAllObjects];
    
    elementsCount = 0;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    for(int i=0; i<self.parksList.count; i++) {
        LPLjubljanaCarPark *carPark = (LPLjubljanaCarPark*)[self.parksList objectAtIndex:i];
        
        if([carPark.name isEqualToString:@"Parkomati"]) {
            [self.parkingMachinesList addObject:carPark];
            [self.parksList removeObjectAtIndex:i];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(ljubljanaCarParksFunctions:didLoadParks:parkingMachines:)]) {
        [self.delegate ljubljanaCarParksFunctions:self didLoadParks:self.parksList parkingMachines:self.parkingMachinesList];
    }
    
    [self setOccupancyToCarParks];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElementName = elementName;
    
    if(elementsCount > 0) {
        if([elementName isEqualToString:@"Parkirisca"]) {
            LPLjubljanaCarPark *carPark = [LPLjubljanaCarPark new];
            
            [self.parksList addObject:carPark];
        }
    }
    
    elementsCount++;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!currentStringValue){
        currentStringValue = [NSMutableString new];
    } else {
        [currentStringValue appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if(![elementName isEqualToString:@"Parkirisca"]) {
        LPLjubljanaCarPark *carPark = (LPLjubljanaCarPark*)[self.parksList objectAtIndex:self.parksList.count-1];
        
        if([currentElementName isEqualToString:@"A_St_Mest"]) {
            carPark.aSpotCount = [[self searchNumberInString:currentStringValue] intValue];
        } else if([currentElementName isEqualToString:@"Cena_dan_Eur"]) {
            carPark.priceDayEur = currentStringValue;
        } else if([currentElementName isEqualToString:@"Cena_mesecna_Eur"]) {
            carPark.priceMonthEur = currentStringValue;
        } else if([currentElementName isEqualToString:@"Cena_splosno"]) {
            carPark.priceGeneral = currentStringValue;
        } else if([currentElementName isEqualToString:@"Cena_ura_Eur"]) {
            carPark.priceHourEur = currentStringValue;
        } else if([currentElementName isEqualToString:@"ID_Parkirisca"]) {
            carPark.parkID = [[self searchNumberInString:currentStringValue] intValue];
        } else if([currentElementName isEqualToString:@"ID_ParkiriscaNC"]) {
            carPark.parkIDNC = [[self searchNumberInString:currentStringValue] intValue];
        } else if([currentElementName isEqualToString:@"Ime"]) {
            carPark.name = currentStringValue;
        } else if([currentElementName isEqualToString:@"Invalidi_St_mest"]) {
            carPark.spotDisabledCount = [[self searchNumberInString:currentStringValue] intValue];
        } else if([currentElementName isEqualToString:@"KoordinataX"]) {
            if([currentStringValue isEqualToString:@""] || currentStringValue == nil) {
                carPark.longitude = 0.0;
            } else {
                carPark.longitude = 14.4643304994 + ([[self searchNumberInString:currentStringValue] doubleValue]-458908)/77619.7881298;
            }
        } else if([currentElementName isEqualToString:@"KoordinataY"]) {
            if([currentStringValue isEqualToString:@""] || currentStringValue == nil) {
                carPark.latitude = 0.0;
            } else {
                carPark.latitude = 46.0368497614 + ([[self searchNumberInString:currentStringValue] doubleValue]-99325)/109625.9334262;
            }
        } else if([currentElementName isEqualToString:@"Opis"]) {
            carPark.parkDescription = currentStringValue;
        } else if([currentElementName isEqualToString:@"St_mest"]) {
            carPark.spotCount = [[self searchNumberInString:currentStringValue] intValue];
        } else if([currentElementName isEqualToString:@"Tip_parkirisca"]) {
            carPark.typePark = currentStringValue;
        } else if([currentElementName isEqualToString:@"U_delovnik"]) {
            carPark.uWeekday = currentStringValue;
        } else if([currentElementName isEqualToString:@"U_sobota"]) {
            carPark.uSaturday = currentStringValue;
        } else if([currentElementName isEqualToString:@"U_splosno"]) {
            carPark.uGeneral = currentStringValue;
        } else if([currentElementName isEqualToString:@"Upravljalec"]) {
            carPark.manager = currentStringValue;
        }
    }

    currentElementName = @"";
    currentStringValue = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if ([self.delegate respondsToSelector:@selector(ljubljanaCarParksFunctions:errorLoadingCarParks:)]) {
        [self.delegate ljubljanaCarParksFunctions:self errorLoadingCarParks:parseError];
    }
}

@end
