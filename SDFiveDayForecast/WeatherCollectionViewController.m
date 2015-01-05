//
//  WeatherCollectionViewController.m
//  SDWeatherCollectionView
//
//  Created by shay deacy on 05/01/2015.
//  Copyright (c) 2015 shay deacy. All rights reserved.
//

#import "WeatherCollectionViewController.h"
#import "AFNetworking.h"
#import "SDCityWeatherData.h"
#import "WeatherCollectionViewCell.h"

@interface WeatherCollectionViewController ()

@end

@implementation WeatherCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //_searchCity = @"dublin,ie";            //default city is Dublin.

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
  
     self.weatherCollectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clouds.png"]];
}

-(void)getData{
    NSLog(@"%@",@"collection view . getting.....");
    // http://api.openweathermap.org/data/2.5/weather?q=London,uk
    
    NSString *searchCityURL = [NSString stringWithFormat:@"%@%@", @"http://api.openweathermap.org/data/2.5/forecast/daily?cnt=5&mode=json&q=", _searchCity];
    NSLog(@"%@",searchCityURL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:searchCityURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"got data...");
             NSDictionary *returnedData = (NSDictionary*)responseObject;
             if ([returnedData[@"cod"]  isEqual: @"200"]) {
                 _daysForecastsArray = returnedData[@"list"];
                // _cityDataDictionary = returnedData[@"city"];
             }
             else if ([returnedData[@"cod"]  isEqual: @"404"]){
                 NSLog(@"%@",@"404");
                 
             }
             NSLog(@"_daysForecastsArray: %lu", (unsigned long)[_daysForecastsArray count]);
             [_weatherCollectionView reloadData];
            

//             self.navigationItem.title = [NSString stringWithFormat:@"%@ %@",_cityDataDictionary[@"name"],_cityDataDictionary[@"country"]];
//             
             
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",@"Error getting data");
             //    _searchMessageLabel.text  = @"City not found, try again";
         }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_daysForecastsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"building cell..");
   WeatherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"weatherCell" forIndexPath:indexPath];
    SDCityWeatherData *cityWeatherData = [[SDCityWeatherData alloc]init];
    [cityWeatherData setWeatherDataDictionary:[_daysForecastsArray objectAtIndex:[indexPath row]]];
                                           
     
    // Configure the cell
    cell.temperatureLabel.text  =   [cityWeatherData temperatureCelsius];
    cell.dateLabel.text         =   [cityWeatherData day];
    cell.humidityLabel.text     =   [cityWeatherData humidityPerCent];
    cell.windLabel.text         =   [cityWeatherData windSpeedMPS];
    cell.windDirectionLabel.text=   [cityWeatherData windDirection];
    cell.temperatureLabel.text  =   [cityWeatherData temperatureCelsius];
    cell.iconImageView.image    =   [cityWeatherData buildIconURL];
    cell.conditionsLabel.text   =   [cityWeatherData conditionsDescription];
    
    [cell setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    
  

    return cell;    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
