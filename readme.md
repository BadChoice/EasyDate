# NSDate+Easy

**Working with dates the right way**   

This library is inspired by the good `Carbon` dates library. It helps working with dates in a really easy way.


## Installation
Copy the category files to your project or just

```
    pod 'EasyDate' 
```

## Examples

The library mainly works with UTC dates but you can pass the timezone in almost all methods

### Creating
```
    NSDate *now         = NSDate.now;
    NSDate *today       = NSDate.today;
    NSDate *yesterday   = NSDate.yesterday;
    NSDate *tomorrow    = NSDate.tomorrow;
```

Available methods:
`now` `today` `tomorrow` `yesterday` `weekStart` `lastWeek` `nextWeek` `monthStart` `lastMonth` `nextMonth`

If you need to work with timezones you can pass the timezone or `device` to use the device timezone

So if you are in UTC +2 today:@"device" will be yesterday at 22:00

```
    NSDate *today   = [NSDate today:@"device"];
```

You can also give a date to those name constructors

```
[NSDate parse:@"2016-08-18"].weekStart;
```


You can also parse dates:

```
    NSDate* parsed              = [NSDate parse:@"2016-08-14 04:03:01"];
    NSDate* parsedTimezoned     = [NSDate parse:@"2016-08-14 04:03:01" timezone:@"Europe/Paris"];
    NSDate* parsedTimezoned2    = [NSDate parse:@"2016-08-14 04:03:01" timezone:@"device"];
```

if you have a `NSString` you can use the `NSString+EasyDate` category to do so:

```
    NSDate* date = stringDate.toDate;
    NSDate* date = [stringDate toDate:@"device"];
```

### To string
It comes with a handful to string methods


```
    date.toDateTimeString;              // 2016-08-14 04:03:01
    date.toDateString;                  // 2016-08-14
    date.toDeviceTimezoneString         // 2016-08-14 06:03:01   
```

## Datetools
This pod also installs the `DateTools` pod which makes working with dates quite easy as well, however this library has some convenience methods to shorten the calls and make code more readable


## Contributors
[Kyle Fleming](https://github.com/kylefleming)
