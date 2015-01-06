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

- (void)viewDidLoad {
    [super viewDidLoad];
     self.weatherCollectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clouds.png"]];  //sets background image
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_daysForecastsArray count];                                                                 //the number of items in the collection is the number of days weather forecast that will be presented, ie 5
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"building cell..");
   WeatherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"weatherCell" forIndexPath:indexPath];   //prototype cell that will be reused to display each days forecast conditions
    SDCityWeatherData *cityWeatherData = [[SDCityWeatherData alloc]init];
    [cityWeatherData setWeatherDataDictionary:[_daysForecastsArray objectAtIndex:[indexPath row]]];     //pass in data to be processed, to the instance of SDCityWeatherData
   
    // Configure the cell
    cell.temperatureLabel.text  =   [cityWeatherData temperatureCelsius];
    cell.dateLabel.text         =   [cityWeatherData day];
    cell.humidityLabel.text     =   [cityWeatherData humidityPerCent];
    cell.windLabel.text         =   [cityWeatherData windSpeedMPS];
    cell.windDirectionLabel.text=   [cityWeatherData windDirection];
    cell.temperatureLabel.text  =   [cityWeatherData temperatureCelsius];
    cell.iconImageView.image    =   [cityWeatherData buildIconURL];
    cell.conditionsLabel.text   =   [cityWeatherData conditionsDescription];
    [cell setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];    //set cell background to be semi-transparent
    return cell;    
}



@end
