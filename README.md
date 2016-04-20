# RssFeed

Abstract: Pull the RSS feeds from the given url and displays summary along with few lines of details and image.

Not using any third party library or classes to achieve the results, yes used the Xcode provided support for core data and master/details project template

RSSEventCell: custom cell object, responsible for displaying title, description and image related to the event/feed

image download initiates in the separate thread and once data is received, ui is updated on the main thread 

RSSImageDownloader: downloads the image from given url, using convenience initializer as it allows multiple parameters and initialization at the same time following success and failure block pattern to clearly specify the outcome of the network call

RSSExtensions: extension to the string class for removing the new line and tab chars from the title and description text

RSSFeed: This class pulls the feeds from the given url and passes it on to the parser for further processing/ parsing, parsing is happening on main thread, as we can not have relevant data to display unless parsing is completed

RSSServiceManager: makes a network call and returns the result success or failure. Consuming classes/ objects can utilize the result given by this class

RSSEventParser: Parses the event feed based on the keys defined in the enum

RSSCoreDataManager: Singleton sharedManager takes care of storing data locally on the device, as this is very simple app, we are storing new feeds and deleting old feeds every time the app launches

NSURLSessionDataTask is used for network calls.


This class is also responsible for providing managed object context, and other core data related stuffs

MasterViewController: This is an tableviewcontroller which is given by Xcode master details project template

It displays the fetched rssfeeds, most of the methods are readily given by Xcode



