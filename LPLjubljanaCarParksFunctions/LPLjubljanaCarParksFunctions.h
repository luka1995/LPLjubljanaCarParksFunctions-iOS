//
//  LPLjubljanaCarParksFunctions.h
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

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LPLjubljanaCarParksOccupancyFunctions.h"
#import "LPLjubljanaCarPark.h"
#import "LPLjubljanaCarParkOccupancy.h"


@protocol LPLjubljanaCarParksFunctionsDelegate;

@interface LPLjubljanaCarParksFunctions : NSObject <NSXMLParserDelegate, LPLjubljanaCarParksOccupancyFunctionsDelegate> {
    int elementsCount;
    NSString *currentElementName;
    NSMutableString *currentStringValue;
}

@property (nonatomic, weak) id <LPLjubljanaCarParksFunctionsDelegate> delegate;
@property (nonatomic, strong) LPLjubljanaCarParksOccupancyFunctions *occupancyFunctions;
@property (nonatomic, strong) NSMutableArray *parksList;
@property (nonatomic, strong) NSMutableArray *parkingMachinesList;

- (void)load;

@end


#pragma mark - Delegate Protocol

@protocol LPLjubljanaCarParksFunctionsDelegate <NSObject>

@optional

- (void)ljubljanaCarParksFunctionsWillLoadParks:(LPLjubljanaCarParksFunctions *)ljubljanaCarParksFunctions;
- (void)ljubljanaCarParksFunctions:(LPLjubljanaCarParksFunctions *)ljubljanaCarParksFunctions didLoadParks:(NSMutableArray *)parksList parkingMachines:(NSMutableArray *)parkingMachinesList;
- (void)ljubljanaCarParksFunctions:(LPLjubljanaCarParksFunctions *)ljubljanaCarParksFunctions errorLoadingCarParks:(NSError *)error;

- (void)ljubljanaCarParksFunctions:(LPLjubljanaCarParksFunctions *)ljubljanaCarParksFunctions didLoadOccupancyToCarParks:(NSMutableArray *)parksList;
- (void)ljubljanaCarParksFunctions:(LPLjubljanaCarParksFunctions *)ljubljanaCarParksFunctions errorLoadingOccupancyToCarParks:(NSError *)error;

@end