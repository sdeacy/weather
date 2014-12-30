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

@property (nonatomic,strong)NSDictionary *weatherDataDictionary;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSNumber *temperature;
@property (nonatomic,strong) NSNumber *windSpeedMPS;
@property (nonatomic,strong) NSNumber *humidityPerCent;
@property (nonatomic,strong) NSString *conditionsDescription;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSArray  *daysForecastsArray;
@property (nonatomic,strong) NSString *mydate;



-(NSString *)     temperatureCelsius;
-(UIImage  *)     buildIconURL;
-(NSString *)     date;

@end
