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
    _searchCity = @"dublin";
    [self getData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)searchButton:(id)sender {
    
    _searchCity = _searchTextField.text;
    [_searchTextField resignFirstResponder];
    NSLog(@"%@",_searchCity);
    [self getData];
    
}

-(void)buildUI{
    
    SDCityWeatherData *cityWeatherData = [[SDCityWeatherData  alloc]init];
    [cityWeatherData setWeatherDataDictionary:[_daysForecastsArray objectAtIndex:0]];
    _cityNameLabel.text     =  _searchCity;
    _temperatureLabel.text  = [cityWeatherData temperatureCelsius];
    _humidityLabel.text     = [cityWeatherData humidityPerCent];
    _windSpeedLabel.text    = [cityWeatherData windSpeedMPS];
    _iconImageView.image    = [cityWeatherData buildIconURL];
    
}

-(void)getData{
    NSLog(@"%@",@"getting.....");
    NSString *searchCityURL = [NSString stringWithFormat:@"%@%@", @"http://api.openweathermap.org/data/2.5/forecast/daily?cnt=6&mode=json&q=", _searchCity];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:searchCityURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"got data...");
             NSDictionary *returnedData = (NSDictionary*)responseObject;
             if ([returnedData[@"cod"]  isEqual: @"200"]) {
                 _daysForecastsArray = returnedData[@"list"];
             }
             else if ([returnedData[@"cod"]  isEqual: @"404"]){
                 NSLog(@"%@",@"404");
                 _cityNameLabel.text  = @"City not found, try again";

             }
             NSLog(@"_daysForecastsArray: %lu", (unsigned long)[_daysForecastsArray count]);
 //            [_tableView reloadData];
             [self buildUI];
             
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",@"Error getting data");
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
