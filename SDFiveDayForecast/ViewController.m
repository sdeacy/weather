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

@interface ViewController ()
@property (nonatomic, strong) NSArray *daysForecastsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getData];
//    _daysForecastsArray = [[NSMutableArray alloc]initWithObjects:
//    @{@"dt":@1418608800,
//        @"temp":@{@"day":@270.88},
//    },
//    @{@"dt":@1418695200,
//        @"temp":@{@"day":@277.95},
//      },
//    nil];
 
     [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    NSLog(@"%@",@"getting.....");
    NSString *searchCityURL = [NSString stringWithFormat:@"%@%@", @"http://api.openweathermap.org/data/2.5/forecast/daily?cnt=5&mode=json&q=", @"paris"];
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
             }
             NSLog(@"_daysForecastsArray: %lu", (unsigned long)[_daysForecastsArray count]);
             [_tableView reloadData];


         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",@"Error getting data");
         }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu", (unsigned long)[_testArr count]);
    return [_daysForecastsArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DayForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayForecastCell"];
    
    NSNumber *dateUnixTime = [_daysForecastsArray objectAtIndex:[indexPath row]][@"dt"];
    NSLog(@"%@",dateUnixTime);
    NSTimeInterval _interval=dateUnixTime.intValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSString *dateFromDT= [formatter stringFromDate:date];
    cell.dayDateLabel.text = dateFromDT;
    
    NSNumber *humidity = [_daysForecastsArray objectAtIndex:[indexPath row]][@"humidity"];
    NSLog(@"humidity: %f%%",ceil([humidity intValue]));
    cell.humidityLabel.text = [NSString stringWithFormat:@"%f%%",ceil([humidity intValue])];
    
    NSNumber *wind = [_daysForecastsArray objectAtIndex:[indexPath row]][@"speed"];
    cell.windLabel.text = [NSString stringWithFormat:@"%@mps",[wind stringValue]];
    
    NSDictionary *temperatureDictionary = [_daysForecastsArray objectAtIndex:[indexPath row]][@"temp"];
    NSNumber *temperatureDay = [temperatureDictionary objectForKey:@"day"];
    int tempCelsius = ceil([temperatureDay floatValue]- 273.51);
    NSLog(@"%d",tempCelsius);
    cell.temperatureLabel.text = [NSString stringWithFormat:@"%dc",tempCelsius];
    
    NSArray *weatherArray = [_daysForecastsArray objectAtIndex:[indexPath row]][@"weather"];
    NSString *icon = weatherArray[0][@"icon"];
    NSString *baseURL = @"http://openweathermap.org/img/w/";
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseURL,icon,@".png"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    cell.imageView.image = [UIImage imageWithData:imageData];

    
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
