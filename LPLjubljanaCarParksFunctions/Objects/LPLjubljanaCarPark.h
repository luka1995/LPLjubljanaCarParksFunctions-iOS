//
//  LPLjubljanaCarPark.h
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
#import "LPLjubljanaCarParkOccupancy.h"


@interface LPLjubljanaCarPark : NSObject <NSCoding>

@property (nonatomic, assign) int aSpotCount;
@property (nonatomic, strong) NSString *priceDayEur;
@property (nonatomic, strong) NSString *priceMonthEur;
@property (nonatomic, strong) NSString *priceGeneral;
@property (nonatomic, strong) NSString *priceHourEur;
@property (nonatomic, assign) int parkID;
@property (nonatomic, assign) int parkIDNC;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int spotDisabledCount;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *parkDescription;
@property (nonatomic, assign) int spotCount;
@property (nonatomic, strong) NSString *typePark;
@property (nonatomic, strong) NSString *uWeekday;
@property (nonatomic, strong) NSString *uSaturday;
@property (nonatomic, strong) NSString *uGeneral;
@property (nonatomic, strong) NSString *manager;
@property (nonatomic, strong) LPLjubljanaCarParkOccupancy *occupancy;

- (NSDictionary *)dictionary;
- (NSString *)description;

@end
