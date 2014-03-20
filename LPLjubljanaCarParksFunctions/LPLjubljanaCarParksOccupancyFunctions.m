//
//  LPLjubljanaCarParksOccupancyFunctions.m
//  LPCarParksExample
//
//  Created by Luka Penger on 19/03/14.
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

#import "LPLjubljanaCarParksOccupancyFunctions.h"


@implementation LPLjubljanaCarParksOccupancyFunctions

NSString *const occupancyURL = @"http://www.lpt.si/uploads/xml/traffic/occupancy.xml";

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        self.occupancyList = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - Functions

- (void)load
{
    if ([self.delegate respondsToSelector:@selector(ljubljanaCarParksOccupancyFunctionsWillLoadOccupancy:)]) {
        [self.delegate ljubljanaCarParksOccupancyFunctionsWillLoadOccupancy:self];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:occupancyURL]];
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        XMLParser.delegate = self;
        [XMLParser parse];
    } failure:nil];
    [operation start];
}

- (LPLjubljanaCarParkOccupancy *)getOccupancyForParkID:(int)parkID
{
    for(LPLjubljanaCarParkOccupancy *occupancy in self.occupancyList) {
        if(occupancy.parkID == parkID) {
            return occupancy;
        }
    }
    
    return nil;
}

- (NSDate *)formatDateString:(NSString *)string
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [dateFormat dateFromString:string];
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

#pragma mark - XML Parser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    if(!self.occupancyList)
        self.occupancyList = [NSMutableArray new];
    
    [self.occupancyList removeAllObjects];
    
    elementsCount = 0;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([self.delegate respondsToSelector:@selector(ljubljanaCarParksOccupancyFunctions:didLoadOccupancy:)]) {
        [self.delegate ljubljanaCarParksOccupancyFunctions:self didLoadOccupancy:self.occupancyList];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElementName = elementName;
    
    if(elementsCount > 0) {
        if([elementName isEqualToString:@"ZASEDENOST"]) {
            LPLjubljanaCarParkOccupancy *occupancy = [LPLjubljanaCarParkOccupancy new];
            
            [self.occupancyList addObject:occupancy];
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
    if(![elementName isEqualToString:@"ZASEDENOST"]) {
        LPLjubljanaCarParkOccupancy *occupancy = (LPLjubljanaCarParkOccupancy*)[self.occupancyList objectAtIndex:self.occupancyList.count-1];
        
        if([elementName isEqualToString:@"ID_ParkiriscaNC"]) {
            occupancy.parkID = [[self searchNumberInString:currentStringValue] intValue];
        } else if([elementName isEqualToString:@"Cas"]) {
            occupancy.date = [self formatDateString:currentStringValue];
        } else if([elementName isEqualToString:@"P_kratkotrajniki"]) {
            occupancy.freeSpotsCount = [[self searchNumberInString:currentStringValue] intValue];
        }
    }
    
    currentElementName = @"";
    currentStringValue = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if ([self.delegate respondsToSelector:@selector(ljubljanaCarParksOccupancyFunctions:errorLoadingOccupancy:)]) {
        [self.delegate ljubljanaCarParksOccupancyFunctions:self errorLoadingOccupancy:parseError];
    }
}

@end