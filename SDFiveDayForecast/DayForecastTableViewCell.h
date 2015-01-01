//
//  DayForecastTableViewCell.h
//  SDFiveDayForecast
//
//  Created by shay deacy on 16/12/2014.
//  Copyright (c) 2014 shay deacy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayForecastTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView    *iconImage;
@property (weak, nonatomic) IBOutlet UILabel        *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel        *windLabel;
@property (weak, nonatomic) IBOutlet UILabel        *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel        *dayDateLabel;

@end
