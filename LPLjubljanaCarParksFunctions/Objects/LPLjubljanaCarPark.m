//
//  LPLjubljanaCarPark.m
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

#import "LPLjubljanaCarPark.h"


@implementation LPLjubljanaCarPark

#pragma mark - Coder

- (id)initWithCoder:(NSCoder *)coder
{
	self = [LPLjubljanaCarPark new];
    if (self != nil) {
        self.aSpotCount = [coder decodeIntegerForKey:@"aSpotCount"];
        self.priceDayEur = [coder decodeObjectForKey:@"priceDayEur"];
        self.priceMonthEur = [coder decodeObjectForKey:@"priceMonthEur"];
        self.priceGeneral = [coder decodeObjectForKey:@"priceGeneral"];
        self.priceHourEur = [coder decodeObjectForKey:@"priceHourEur"];
        self.parkID = [coder decodeIntegerForKey:@"parkID"];
        self.parkIDNC = [coder decodeIntegerForKey:@"parkIDNC"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.spotDisabledCount = [coder decodeIntegerForKey:@"spotDisabledCount"];
        self.latitude = [coder decodeDoubleForKey:@"latitude"];
        self.longitude = [coder decodeDoubleForKey:@"longitude"];
        self.parkDescription = [coder decodeObjectForKey:@"parkDescription"];
        self.spotCount = [coder decodeIntegerForKey:@"spotCount"];
        self.typePark = [coder decodeObjectForKey:@"typePark"];
        self.uWeekday = [coder decodeObjectForKey:@"uWeekday"];
        self.uSaturday = [coder decodeObjectForKey:@"uSaturday"];
        self.uGeneral = [coder decodeObjectForKey:@"uGeneral"];
        self.manager = [coder decodeObjectForKey:@"manager"];
        self.occupancy = [coder decodeObjectForKey:@"occupancy"];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.aSpotCount forKey:@"aSpotCount"];
    [coder encodeObject:self.priceDayEur forKey:@"priceDayEur"];
    [coder encodeObject:self.priceMonthEur forKey:@"priceMonthEur"];
    [coder encodeObject:self.priceGeneral forKey:@"priceGeneral"];
    [coder encodeObject:self.priceHourEur forKey:@"priceHourEur"];
    [coder encodeInteger:self.parkID forKey:@"parkID"];
    [coder encodeInteger:self.parkIDNC forKey:@"parkIDNC"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.spotDisabledCount forKey:@"spotDisabledCount"];
    [coder encodeDouble:self.latitude forKey:@"latitude"];
    [coder encodeDouble:self.longitude forKey:@"longitude"];
    [coder encodeObject:self.parkDescription forKey:@"parkDescription"];
    [coder encodeInteger:self.spotCount forKey:@"spotCount"];
    [coder encodeObject:self.typePark forKey:@"typePark"];
    [coder encodeObject:self.uWeekday forKey:@"uWeekday"];
    [coder encodeObject:self.uSaturday forKey:@"uSaturday"];
    [coder encodeObject:self.uGeneral forKey:@"uGeneral"];
    [coder encodeObject:self.manager forKey:@"manager"];
    [coder encodeObject:self.occupancy forKey:@"occupancy"];
}

#pragma mark - Class

- (id)copyWithZone:(NSZone *)zone
{
    LPLjubljanaCarPark *new = [LPLjubljanaCarPark new];
    
    [new setASpotCount:self.aSpotCount];
    [new setPriceDayEur:self.priceDayEur];
    [new setPriceMonthEur:self.priceMonthEur];
    [new setPriceGeneral:self.priceGeneral];
    [new setPriceHourEur:self.priceHourEur];
    [new setParkID:self.parkID];
    [new setParkIDNC:self.parkIDNC];
    [new setName:self.name];
    [new setSpotDisabledCount:self.spotDisabledCount];
    [new setLatitude:self.latitude];
    [new setLongitude:self.longitude];
    [new setParkDescription:self.parkDescription];
    [new setSpotCount:self.spotCount];
    [new setTypePark:self.typePark];
    [new setUWeekday:self.uWeekday];
    [new setUSaturday:self.uSaturday];
    [new setUGeneral:self.uGeneral];
    [new setManager:self.manager];
    [new setOccupancy:self.occupancy];
    
    return new;
}

#pragma mark - Debug

- (NSDictionary *)dictionary
{
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];
    
    [mutableDictionary setObject:[NSString stringWithFormat:@"%d", self.aSpotCount] forKey:@"aSpotCount"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.priceDayEur] forKey:@"priceDayEur"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.priceMonthEur] forKey:@"priceMonthEur"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.priceGeneral] forKey:@"priceGeneral"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.priceHourEur] forKey:@"priceHourEur"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%d", self.parkID] forKey:@"parkID"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%d", self.parkIDNC] forKey:@"parkIDNC"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.name] forKey:@"name"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%d", self.spotDisabledCount] forKey:@"spotDisabledCount"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%f", self.latitude] forKey:@"latitude"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%f", self.longitude] forKey:@"longitude"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.parkDescription] forKey:@"parkDescription"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%d", self.spotCount] forKey:@"spotCount"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.typePark] forKey:@"typePark"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.uWeekday] forKey:@"uWeekday"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.uSaturday] forKey:@"uSaturday"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.uGeneral] forKey:@"uGeneral"];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%@", self.manager] forKey:@"manager"];

    if(self.occupancy) {
        [mutableDictionary setObject:self.occupancy.dictionary forKey:@"occupancy"];
    }
    
    return mutableDictionary;
}

- (NSString *)description
{
    return [self dictionary].description;
}

@end
