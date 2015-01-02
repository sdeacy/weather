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
    _searchCity = @"dublin";            //default city is Dublin.
    [self getData];                     //loads data from web
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//activates search for another city, after user entered city name
- (IBAction)searchButton:(id)sender {
    _searchMessageLabel.text = @"";
    NSString *userInput = _searchTextField.text;
    NSString *trimmedUserInput = [userInput stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedUserInput = [trimmedUserInput stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSLog(@"trimmed: %@",trimmedUserInput);
    //ref http://stackoverflow.com/questions/9291624/how-do-i-remove-leading-trailing-whitespace-of-nsstring-inside-an-nsarray
    
    
    _searchCity = trimmedUserInput;
    [_searchTextField resignFirstResponder];                //removes keyboard
    [self getData];
}



//
-(void)buildUI{
    _searchMessageLabel.text  = @" ";
    SDCityWeatherData *cityWeatherData = [[SDCityWeatherData  alloc]init];
    [cityWeatherData setWeatherDataDictionary:[_daysForecastsArray objectAtIndex:0]];
    [cityWeatherData setCityDataDictionary:_cityDataDictionary];
    _cityNameLabel.text     = [cityWeatherData cityName];
    _temperatureLabel.text  = [cityWeatherData temperatureCelsius];
    _humidityLabel.text     = [cityWeatherData humidityPerCent];
    _windSpeedLabel.text    = [cityWeatherData windSpeedMPS];
    _iconImageView.image    = [cityWeatherData buildIconURL];
    
}

-(void)getData{
    NSLog(@"%@",@"getting.....");
    _searchMessageLabel.text  = @"Getting data...";
   // http://api.openweathermap.org/data/2.5/weather?q=London,uk

    NSString *searchCityURL = [NSString stringWithFormat:@"%@%@", @"http://api.openweathermap.org/data/2.5/forecast/daily?cnt=5&mode=json&APPID=91b6d62cbff687d9e5bff155939d33e0&type=accurate&q=", _searchCity];
    NSLog(@"%@",searchCityURL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:searchCityURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"got data...");
             NSDictionary *returnedData = (NSDictionary*)responseObject;
             if ([returnedData[@"cod"]  isEqual: @"200"]) {
                 _daysForecastsArray = returnedData[@"list"];
                 _cityDataDictionary = returnedData[@"city"];
                 
             }
             else if ([returnedData[@"cod"]  isEqual: @"404"]){
                 NSLog(@"%@",@"404");
                 _searchMessageLabel.text  = @"City not found, try again";

             }
             NSLog(@"_daysForecastsArray: %lu", (unsigned long)[_daysForecastsArray count]);
 //            [_tableView reloadData];
             [self buildUI];
             
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",@"Error getting data");
             _searchMessageLabel.text  = @"City not found, try again";
         }];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *transferViewController = [segue destinationViewController];
    transferViewController.daysForecastsArray = _daysForecastsArray;
    
}


@end
