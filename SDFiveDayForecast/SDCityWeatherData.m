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
    
    NSDictionary *temperatureDictionary = _weatherDataDictionary[@"temp"];
    NSNumber *temperatureDay = [temperatureDictionary objectForKey:@"day"];
    int tempCelsius = ceil([temperatureDay floatValue]- 273.51);
    return [NSString stringWithFormat:@"%dC",tempCelsius];
    
}

-(UIImage*)buildIconURL{
    
    NSArray     *weatherArray   = _weatherDataDictionary[@"weather"];
    NSString    *icon           = weatherArray[0][@"icon"];
    NSString    *baseURL        = @"http://openweathermap.org/img/w/";
    NSURL       *imageURL       = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseURL,icon,@".png"]];
    NSData      *imageData      = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:imageData];
}

-(NSString*)date{
    
    NSNumber *dateUnixTime = _weatherDataDictionary[@"dt"];
    NSTimeInterval _interval=dateUnixTime.intValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

-(NSString*)humidityPerCent{
    _humidityPerCent = _weatherDataDictionary[@"humidity"];
    return [NSString stringWithFormat:@"%d%%",[_humidityPerCent intValue]];
}
-(NSString *)     windSpeedMPS{
    return [NSString stringWithFormat:@"%d m/sec",[_weatherDataDictionary[@"speed"] intValue]];
}

-(NSString *)cityName;{
    return _cityDataDictionary[@"name"];
}





@end
