//
//  WeatherCollectionViewController.h
//  SDWeatherCollectionView
//
//  Created by shay deacy on 05/01/2015.
//  Copyright (c) 2015 shay deacy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherCollectionViewCell.h"
@interface WeatherCollectionViewController : UICollectionViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray   *daysForecastsArray;
@property (nonatomic, strong) NSString  *searchCity;

@property (strong, nonatomic) IBOutlet UICollectionView *weatherCollectionView;

@end
