//
//  SDWCollectionViewController.h
//  SDWeatherCollectionView
//
//  Created by shay deacy on 05/01/2015.
//  Copyright (c) 2015 shay deacy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWCollectionViewCell.h"
@interface SDWCollectionViewController : UICollectionViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray   *daysForecastsArray;
@property (nonatomic, strong) NSString  *searchCity;
@property (strong, nonatomic) IBOutlet UICollectionView *SDWCollectionView;

@end
