//
//  SDCityWeatherData.m
//  SDFiveDayForecast
//
//  Created by shay deacy on 29/12/2014.
//  Copyright (c) 2014 shay deacy. All rights reserved.
//

#import "SDCityWeatherData.h"
#import "AFNetworking.h"


@implementation SDCityWeatherData

-(NSString*)description {
    return [NSString stringWithFormat:@"City: %@\n Temperature: %@\n Wind: %@\n Humidity: %@",_cityName,_temperature,_windSpeedMPS,_humidityPerCent];
}

//converts temperature from kelvin to celsius
-(NSString*)temperatureCelsius {
    NSDictionary *temperatureDictionary = _weatherDataDictionary[@"temp"];
    NSNumber *temperatureDay = [temperatureDictionary objectForKey:@"day"];
    int tempCelsius = ceil([temperatureDay floatValue]- 273.51);
    return [NSString stringWithFormat:@"%dC",tempCelsius];
}

//loads image data for the weather icon from the url specified
//(possibly a problem on slow networks, a better implementation would be to have the icons stored locally, but they are not available at present
-(UIImage*)buildIconURL {
    NSArray     *weatherArray   = _weatherDataDictionary[@"weather"];
    NSString    *icon           = weatherArray[0][@"icon"];
    NSString    *baseURL        = @"http://openweathermap.org/img/w/";
    NSURL       *imageURL       = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseURL,icon,@".png"]];
    NSData      *imageData      = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:imageData];
}

//returns a formated date from a unix time stamp
-(NSString*)date {
    NSNumber *dateUnixTime = _weatherDataDictionary[@"dt"];
    NSTimeInterval _interval=dateUnixTime.intValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

//returns a day from a unix time stamp
-(NSString *)day {
    NSNumber *dateUnixTime = _weatherDataDictionary[@"dt"];
    NSTimeInterval _interval=dateUnixTime.intValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"EEEE"];
    NSString *day = [formatter stringFromDate:date];
    return day;
}

//returns a value for humidity, and a percent sign
-(NSString*)humidityPerCent {
    _humidityPerCent = _weatherDataDictionary[@"humidity"];
    return [NSString stringWithFormat:@"%d%%",[_humidityPerCent intValue]];
}

//returns windspeed and 'm/s'
-(NSString *)     windSpeedMPS {
    return [NSString stringWithFormat:@"%d m/s",[_weatherDataDictionary[@"speed"] intValue]];
}

//returns city name and country name
-(NSString *)cityName {
    NSString *country = _cityDataDictionary[@"country"];
    if ([country  isEqualToString : @"United States of America"]) {
        country = @"USA";
    }
    return [NSString stringWithFormat:@"%@  %@",_cityDataDictionary[@"name"],country];
}

//returns a description of the weather conditions
-(NSString *)conditionsDescription {
    NSArray  *weatherArray   = _weatherDataDictionary[@"weather"];
   return weatherArray[0][@"description"];
}

//converts degrees to compass wind direction
-(id)windDirection {
    NSNumber *windDirectionDegrees = _weatherDataDictionary[@"deg"];
    float temp = (windDirectionDegrees.floatValue -11.25) / 22.5;
    NSArray *compassDirections = @[@"North",@"NNE",@"NE",@"ENE",@"East",@"ESE", @"SE",@"SSE",@"South",@"SSW",@"SW",@"WSW",@"West",@"WNW",@"NW",@"NNW"];
    int index = fabsf(temp);
    return compassDirections[index];
}


@end
