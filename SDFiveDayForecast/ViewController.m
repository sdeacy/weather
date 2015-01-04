//
//  ViewController.m
//  SDFiveDayForecast
//
//  Created by shay deacy on 16/12/2014.
//  Copyright (c) 2014 shay deacy. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "DayForecastTableViewCell.h"
#import "SDCityWeatherData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clouds.png"]];
    [self getData];
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    NSLog(@"%@",@"getting.....");
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
                 
             }
             NSLog(@"_daysForecastsArray: %lu", (unsigned long)[_daysForecastsArray count]);
           [_tableView reloadData];
             self.navigationItem.title = [NSString stringWithFormat:@"%@ %@",_cityDataDictionary[@"name"],_cityDataDictionary[@"country"]];

             
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",@"Error getting data");
         //    _searchMessageLabel.text  = @"City not found, try again";
         }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu", (unsigned long)[_testArr count]);
    return [_daysForecastsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DayForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayForecastCell"];
    SDCityWeatherData *cityWeatherData = [[SDCityWeatherData  alloc]init];
    [cityWeatherData setWeatherDataDictionary:[_daysForecastsArray objectAtIndex:[indexPath row]]];
    cell.dayDateLabel.text      =   [cityWeatherData date];
    cell.humidityLabel.text     =   [cityWeatherData humidityPerCent];
    cell.windLabel.text         =   [cityWeatherData windSpeedMPS];
    cell.temperatureLabel.text  =   [cityWeatherData temperatureCelsius];
    cell.imageView.image        =   [cityWeatherData buildIconURL];
    return cell;
    
}


//{
//    clouds = 20;
//    deg = 311;
//    dt = 1418727600;
//    humidity = 92;
//    pressure = "1018.61";
//    speed = "3.16";
//    temp =     {
//        day = "280.4";
//        eve = "275.87";
//        max = "280.4";
//        min = "273.41";
//        morn = "280.4";
//        night = "274.6";
//    };
//    weather =     (
//                   {
//                       description = "few clouds";
//                       icon = 02d;
//                       id = 801;
//                       main = Clouds;
//                   }
//                   );
//}


@end
