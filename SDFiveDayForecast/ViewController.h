//
//  ViewController.h
//  SDFiveDayForecast
//
//  Created by shay deacy on 16/12/2014.
//  Copyright (c) 2014 shay deacy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *testArr;
@property (nonatomic, strong) NSArray *daysForecastsArray;
@property (nonatomic, strong) NSDictionary *oneDayWeatherDictionary;

@property (nonatomic, strong) NSString *searchCity;

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, strong)NSDictionary *cityDataDictionary;




@end

