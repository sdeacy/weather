//
//  SDCityWeatherData.h
//  SDFiveDayForecast
//
//  Created by shay deacy on 29/12/2014.
//  Copyright (c) 2014 shay deacy. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


@interface SDCityWeatherData : NSObject

@property (nonatomic,strong) NSDictionary   *weatherDataDictionary;
@property (nonatomic,strong) NSDictionary   *cityDataDictionary;
@property (nonatomic,strong) NSString       *cityName;
@property (nonatomic,strong) NSNumber       *temperature;
@property (nonatomic,strong) NSString       *windSpeedMPS;
@property (nonatomic,strong) NSString       *humidityPerCent;
@property (nonatomic,strong) NSString       *conditionsDescription;
@property (nonatomic,strong) NSString       *icon;
@property (nonatomic,strong) NSArray        *daysForecastsArray;



-(NSString *)temperatureCelsius;
-(UIImage  *)buildIconURL;
-(NSString *)date;
-(NSString *)humidityPerCent;
-(NSString *)windSpeedMPS;
-(NSString *)cityName;



@end
