//
//  rootViewController.m
//  SDFiveDayForecast
//
//  Created by shay deacy on 31/12/2014.
//  Copyright (c) 2014 shay deacy. All rights reserved.
//

#import "rootViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "DayForecastTableViewCell.h"
#import "SDCityWeatherData.h"



@interface rootViewController ()
@property (nonatomic,strong) NSString *searchCity;

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchCity = @"dublin,ie";            //default city is Dublin.
    [self getData];                      //loads data from web
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"clouds.png"]]];
    self.backgroundImageView.layer.cornerRadius = 115;                  //creates rounded backgrounds
    self.iconImageView.layer.cornerRadius = 45;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//activates search for another city, after user enters city name
- (IBAction)searchButton:(id)sender {
    _searchMessageLabel.text = @"";              //clears any previous messages
    NSString *userInput = _searchTextField.text;
    
    NSString *trimmedUserInput = [userInput stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //removes leading and trailing whitespace
    trimmedUserInput = [trimmedUserInput stringByReplacingOccurrencesOfString:@" " withString:@"_"];                       //so spaces in search term are not passed to the www query
    
    //the following lines check if any entered characters are not permitted, ie characters that would cause an error in the http request
    NSCharacterSet *notPermittedInputCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_,"]invertedSet];
    if([trimmedUserInput rangeOfCharacterFromSet:notPermittedInputCharacters].location !=  NSNotFound){             //ref http://nshipster.com/nsrange/
        _searchMessageLabel.text = @"Input error...";
    }
    else {
        _searchCity = trimmedUserInput;
        [_searchTextField resignFirstResponder];                //removes keyboard
        [self getData];
    }
}






//loads data into the UI
- (void)buildUI{
    _searchMessageLabel.text  = @" ";                                               //clears any previous messages
    SDCityWeatherData *cityWeatherData = [[SDCityWeatherData  alloc]init];              //SDweatherData class processes the data received from www
    [cityWeatherData setWeatherDataDictionary:[_daysForecastsArray objectAtIndex:0]];
    [cityWeatherData setCityDataDictionary:_cityDataDictionary];                        //feed in the first days forecast to the instance of SDweatherData
    
    _cityNameLabel.text                 = [cityWeatherData cityName];                   //fills in labels' content and image
    _temperatureLabel.text              = [cityWeatherData temperatureCelsius];
    _humidityLabel.text                 = [cityWeatherData humidityPerCent];
    _windSpeedLabel.text                = [cityWeatherData windSpeedMPS];
    _conditionsDescriptionLabel.text    = [cityWeatherData conditionsDescription];
    _iconImageView.image                = [cityWeatherData buildIconURL];
    _windDirectionLabel.text            = [cityWeatherData windDirection];
}





- (void)getData{
    NSLog(@"%@",@"getting.....");
    _searchMessageLabel.text  = @"Getting data...";
    NSString *searchCityURL = [NSString stringWithFormat:@"%@%@", @"http://api.openweathermap.org/data/2.5/forecast/daily?cnt=5&mode=json&APPID=91b6d62cbff687d9e5bff155939d33e0&type=accurate&q=", _searchCity];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:searchCityURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"got data...");
             NSDictionary *returnedData = (NSDictionary*)responseObject;
             if ([returnedData[@"cod"]  isEqual: @"200"]) {
                 _daysForecastsArray = returnedData[@"list"];                       //creates an array of objects, each object contains data for one days forecast
                 _cityDataDictionary = returnedData[@"city"];                       //creates a dictionary with data about the search city
             }
             else if ([returnedData[@"cod"]  isEqual: @"404"]) {                     //if city not found, error 404 returned from www
                 NSLog(@"%@",@"404");
                 _searchMessageLabel.text  = @"City not found, try again";
             }
             [self buildUI];                                                       //returned data is sent to be displayed
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {           //if error happpens during network request
             NSLog(@"%@",@"Error getting data");
             _searchMessageLabel.text  = @"Something went wrong, try again...";
         }];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController *transferViewController = [segue destinationViewController];
    transferViewController.daysForecastsArray   = _daysForecastsArray;                  //pass an array containing 5 objects(days weather forecasts) to the next screen, the collection view
    
}


@end
