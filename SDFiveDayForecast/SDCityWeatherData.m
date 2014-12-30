//
//  SDCityWeatherData.m
//  SDFiveDayForecast
//
//  Created by shay deacy on 29/12/2014.
//  Copyright (c) 2014 shay deacy. All rights reserved.
//

#import "SDCityWeatherData.h"

@implementation SDCityWeatherData

-(NSString*)description{
    
    return [NSString stringWithFormat:@"City: %@\n Temperature: %@\n Wind: %@\n Humidity: %@",_cityName,_temperature,_windSpeedMPS,_humidityPerCent];
    
}

-(NSString*)temperatureCelsius{
    //todo - tidy
    float conversionKelvinToCelsius = 273.15;
    float temperatureCelsius = [_temperature floatValue]- conversionKelvinToCelsius;
    float rounded = ceilf(temperatureCelsius);
    NSNumber *tempCel = [NSNumber numberWithFloat:rounded];
    
    return tempCel.stringValue;
    
}

-(UIImage*)buildIconURL{
    
    NSString *baseURL = @"http://openweathermap.org/img/w/";
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseURL,_icon,@".png"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    
    return [UIImage imageWithData:imageData];
    
}

-(NSString*)date{
    
    NSNumber *dateUnixTime = _weatherDataDictionary[@"dt"];
    NSLog(@"%@",dateUnixTime);
    NSTimeInterval _interval=dateUnixTime.intValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}



@end
