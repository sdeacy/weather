//
//  rootViewController.h
//  SDFiveDayForecast
//
//  Created by shay deacy on 31/12/2014.
//  Copyright (c) 2014 shay deacy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rootViewController : UIViewController

@property (nonatomic, strong)        NSArray        *daysForecastsArray;
@property (nonatomic, strong)        NSDictionary   *cityDataDictionary;
@property (weak, nonatomic) IBOutlet UILabel        *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel        *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel        *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UITextField    *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView    *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel        *searchMessageLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel        *conditionsDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel        *windDirectionLabel;


- (IBAction)searchButton:(id)sender;
-(void)buildUI;
-(void)getData;
@end
