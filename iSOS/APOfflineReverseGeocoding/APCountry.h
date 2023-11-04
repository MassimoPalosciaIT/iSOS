//
//  APCountry.h
//  APReverseGeocodingExample
//
//  Created by Sergii Kryvoblotskyi on 4/15/15.
//  Copyright by Sergii Kryvoblotskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APCountry : NSObject

/**
 * Convenience initializer.
 *
 * @param dictionary NSDictionary with JSON data from the world.geo.json project.
 *
 * @return APCountry instance.
 */
+ (instancetype)countryWithGEODictionary:(NSDictionary *)dictionary;

/**
 * Designated initializer.
 *
 * @param dictionary NSDictionary instance containing geo data.
 *
 * @return APCountry instance.
 */
- (instancetype)initWithGeoDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

/* Represents country 3 digits code ISO 3166-1 Alpha 3 */
@property (nonatomic, copy, readonly) NSString *code;

/* Represents country 2 digits code ISO 3166-1 Alpha 2 */
@property (nonatomic, copy, readonly) NSString *shortCode;

/* Represents country name */
@property (nonatomic, copy, readonly) NSString *name;

/* Represents country name in the current locale */
@property (nonatomic, copy, readonly) NSString *localizedName;

/* Represents country currency code */
@property (nonatomic, copy, readonly) NSString *currencyCode;

/* Represents country currency symbol */
@property (nonatomic, copy, readonly) NSString *currencySymbol;

/* Represents country calendar */
@property (nonatomic, strong, readonly) NSCalendar *calendar;

/* Making default initializers unavailable for use */
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
