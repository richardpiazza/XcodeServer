# Xcode Server API Reference

_Xcode Server_: `2.0` | _API_: `19`

## Overview

Apple provides documentation for the Xcode Server API at [https://developer.apple.com/library/content/documentation/Xcode/Conceptual/XcodeServerAPIReference/index.htm](https://developer.apple.com/library/content/documentation/Xcode/Conceptual/XcodeServerAPIReference/index.htm)

This guide acts as an extension with additional routes and information.

## Endpoint

All calls to the API must be made over HTTPS. The API endpoint is

```
https://{hostname}:20343/api
```

_Xcode Server 2.0 included with Xcode 9+ will generate it's own SSL Certificates._

## Documents

Xcode Server stores its data in a CouchDB document database.
Every document has at least two properties: _id and _rev.

- _id is a unique identifier that makes the document unique.
- _rev is a value that changes every time the document is modified.

## Routes & Documents

### _Ping_

__Request__: `[GET] /ping`

__Response__: `204 (no content)`

The response from the server will include the HTTP Header __x-xscapiversion__ with the current API version the server is running. As of Xcode Server 2.0 & Xcode 11.0 the version is 19.

### _Versions_

__Request__: `[GET] /versions`

__Response__: `200`

```json
{
    "_id":"40fcb59015993525294508ddee0007d5",
    "_rev":"13479-58697d16836863db6d6528f97a78be6c",
    "doc_type":"version",
    "tinyID":"4FA43D1",
    "os":"10.13 (17A291j)",
    "xcode":"9.0 (9M137d)",
    "xcodeServer":"2.0",
    "server":"5.3.51 (17S1119j)"
}
```

### _Bots_

__Request__: `[GET] /bots`

__Response__: `200`

```json
{
    "count":1,
    "results":[
        LIST OF BOTS
    ]
}
```

__Request__: `[GET] /bots/{id}`

__Response__: `200`

Returns a single [Bot Document](### _BotDocument_)

__Request__: `[GET] /bots/{id}/stats`

__Response__: `200`

```json
{
    "numberOfIntegrations":1,
    "numberOfCommits":5,
    "averageIntegrationTime":{
        "sum":0,
        "count":0,
        "min":0,
        "max":0,
        "avg":0,
        "stdDev":0
    },
    "testAdditionRate":0,
    "analysisWarnings":{
        "sum":0,
        "count":0,
        "min":0,
        "max":0,
        "avg":0,
        "stdDev":0
    },
    "testFailures":{
        "sum":0,
        "count":0,
        "min":0,
        "max":0,
        "avg":0,
        "stdDev":0
    },
    "errors":{
        "sum":0,
        "count":0,
        "min":0,
        "max":0,
        "avg":0,
        "stdDev":0
    },
    "regressedPerfTests":{
        "sum":0,
        "count":0,
        "min":0,
        "max":0,
        "avg":0,
        "stdDev":0
    },
    "warnings":{
        "sum":0,
        "count":0,
        "min":0,
        "max":0,
        "avg":0,
        "stdDev":0
    },
    "improvedPerfTests":{
        "sum":0,
        "count":0,
        "min":0,
        "max":0,
        "avg":0,
        "stdDev":0
    },
    "tests":{
        "sum":0,
        "count":0,
        "min":0,
        "max":0,
        "avg":0,
        "stdDev":0
    },
    "codeCoveragePercentageDelta":0,
    "numberOfSuccessfulIntegrations":0,
    "sinceDate":"2016-06-24T14:11:31.807Z"
}
```

### _Integrations_

__Request__: `[GET] /bots/{id}/integrations`

__Response__: `200`

```json
{
    "count":1,
    "results":[
        LIST OF INTEGRATIONS
    ]
}
```

__Request__: `[GET] /integrations/{id}`

__Response__: `200`

Returns a single [Integration Document](### _IntegrationDocument_)

__Request__: `[GET] /integrations/{id}/commits`

__Response__: `200`

```json
{
  "count": 1,
  "results": [
    {
      "_id": "7b0bfdf8f209bf9b85b8aa0205104023",
      "_rev": "3-58a0d02f2c092bf949761d783b09f5a6",
      "commits": {
        "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9": [
          {
            "XCSBlueprintRepositoryID": "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
            "XCSCommitCommitChangeFilePaths": [
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/AppDelegate.swift"
              },
              {
                "status": 1,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Schedule.xcdatamodeld/Schedule.xcdatamodel/contents"
              },
              {
                "status": 1,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Model/Event+CoreDataClass.swift"
              },
              {
                "status": 1,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Controllers/EventTableViewController.swift"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Base.lproj/Main.storyboard"
              },
              {
                "status": 4,
                "filePath": "Crazy Monkey Twin Cities.xcodeproj/project.pbxproj"
              },
              {
                "status": 1,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Schedule.swift"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Controllers/ScheduleTableViewController.swift"
              }
            ],
            "XCSCommitContributor": {
              "XCSContributorEmails": [
                "richard@richardpiazza.com"
              ],
              "XCSContributorName": "Richard Piazza",
              "XCSContributorDisplayName": "Richard Piazza"
            },
            "XCSCommitHash": "cdfd4c217d5b85530c2b81849d327e400af84015",
            "XCSCommitMessage": "Added CoreDate schedule model. Added EventTableViewController stub.\n",
            "XCSCommitIsMerge": "NO",
            "XCSCommitTimestamp": "2017-06-05T20:16:13.000Z",
            "XCSCommitTimestampDate": [
              2017,
              6,
              5,
              20,
              16,
              13,
              0
            ]
          },
          {
            "XCSBlueprintRepositoryID": "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
            "XCSCommitCommitChangeFilePaths": [
              {
                "status": 1,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/InvertedMonkey.imageset/Contents.json"
              },
              {
                "status": 1,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/InvertedMonkey.imageset/InvertedMonkey.png"
              },
              {
                "status": 1,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/InvertedMonkey.imageset/InvertedMonkey@2x.png"
              },
              {
                "status": 1,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/InvertedMonkey.imageset/InvertedMonkey@3x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Base.lproj/LaunchScreen.storyboard"
              }
            ],
            "XCSCommitContributor": {
              "XCSContributorEmails": [
                "richard@richardpiazza.com"
              ],
              "XCSContributorName": "Richard Piazza",
              "XCSContributorDisplayName": "Richard Piazza"
            },
            "XCSCommitHash": "17dd8366d861df1fda93ab5d774c5856d232fc45",
            "XCSCommitMessage": "Added inverted monkey image.\n",
            "XCSCommitIsMerge": "NO",
            "XCSCommitTimestamp": "2017-06-05T20:15:45.000Z",
            "XCSCommitTimestampDate": [
              2017,
              6,
              5,
              20,
              15,
              45,
              0
            ]
          },
          {
            "XCSBlueprintRepositoryID": "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
            "XCSCommitCommitChangeFilePaths": [
              {
                "status": 4,
                "filePath": "Crazy Monkey Twin Cities/GoogleCalendarEvent.swift"
              },
              {
                "status": 4,
                "filePath": "Crazy Monkey Twin Cities/GoogleCalendarTimestamp.swift"
              }
            ],
            "XCSCommitContributor": {
              "XCSContributorEmails": [
                "richard@richardpiazza.com"
              ],
              "XCSContributorName": "Richard Piazza",
              "XCSContributorDisplayName": "Richard Piazza"
            },
            "XCSCommitHash": "2c0a2818dfbfe910f2f53d2298554fd6c37fac97",
            "XCSCommitMessage": "Additional Google Timestamp support for created and updated dates.\n",
            "XCSCommitIsMerge": "NO",
            "XCSCommitTimestamp": "2017-06-05T20:15:16.000Z",
            "XCSCommitTimestampDate": [
              2017,
              6,
              5,
              20,
              15,
              16,
              0
            ]
          },
          {
            "XCSBlueprintRepositoryID": "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
            "XCSCommitCommitChangeFilePaths": [
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/AccessibilityAPI.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/AccessibilityControl.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/AccessibilityFeature.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/AccessibilityHazard.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/AccessMode.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/AccessModeSufficient.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Action/Action.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/ActionStatus.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Place/AdministrativeArea.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/AggregateRating.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/AlignmentObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/AlignmentObjectOrCourseOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Answer.swift"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/AppIcon_60@2x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/AppIcon_60@3x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/AppIcon_76.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/AppIcon_76@2x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/AppIcon_83.5@2x.png"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/AreaServed.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Article.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Audience.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/AudioObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Brand.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/BrandOrOrganization.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/BroadcastService.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Comment.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/ContactPoint.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/ContactPointOption.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ContactPointOrPlace.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Place/Country.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/CountryOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Course.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Event/CourseInstance.swift"
              },
              {
                "status": 4,
                "filePath": "Crazy Monkey Twin Cities.xcodeproj/xcshareddata/xcschemes/CrazyMonkeyTwinCitiesiOS.xcscheme"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/CreativeWork.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/CreativeWorkOrProductOrURL.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/CreativeWorkOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/CreativeWorkOrURL.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/DataFeed.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Dataset.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/DateOnly.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/DateOnlyOrDateTime.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/DateTime.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/DateTimeOrTextOrURL.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/DayOfWeek.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Demand.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Distance.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/DistanceOrQuantitativeValue.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/Duration.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Organization/EducationalOrganization.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/EducationalOrganizationOrOrganization.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/EntryPoint.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Enumeration.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Event/Event.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/EventStatus.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/Gender.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/GenderOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/GeoCoordinates.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/GeoCoordinatesOrGeoShape.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/GeoShape.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/Identifier.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/ImageObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ImageObjectOrPhotograph.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ImageObjectOrURL.swift"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/CodeQuickKit/Info.plist"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/SOSwift/Info.plist"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Info.plist"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Intangible.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/IntegerOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/InteractionCounter.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/Interactivity.swift"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPadNotifications20pt.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPadNotifications20pt@2x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPadSettings29pt.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPadSettings29pt@2x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPadSpotlight40pt.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPadSpotlight40pt@2x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPhoneNotifications20pt@2x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPhoneNotifications20pt@3x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPhoneSettings29pt@2x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPhoneSettings29pt@3x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPhoneSpotlight40pt@2x.png"
              },
              {
                "status": 4,
                "filePath": "CrazyMonkeyTwinCitiesiOS/Assets.xcassets/AppIcon.appiconset/iPhoneSpotlight40pt@3x.png"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/ItemList.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/ItemListOrder.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ItemListOrderOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ItemListOrMusicRecording.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Language.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/LanguageOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/LICENSE"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/ListItem.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ListItemOrTextOrThing.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/LocationFeatureSpecification.swift"
              },
              {
                "status": 4,
                "filePath": "Pods/Manifest.lock"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Map.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/MapOrURL.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/MapType.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/MediaObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/MonetaryAmount.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/MonetaryAmountOrPriceSpecification.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/MusicAlbum.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Organization/MusicGroup.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/MusicGroupOrPerson.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/MusicPlaylist.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/MusicRecording.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/NewsArticle.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/Number.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/NumberOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Offer.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/OfferCatalog.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Enumerations/OfferItemCondition.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/OpeningHoursSpecification.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Organization/Organization.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/OrganizationOrPerson.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/OrganizationOrProgramMembership.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/OwnershipInfo.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/OwnershipInfoOrProduct.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Organization/PerformingGroup.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Person/Person.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/PersonOrURL.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Photograph.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Place/Place.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/PlaceOrPostalAddressOrText.swift"
              },
              {
                "status": 4,
                "filePath": "Podfile"
              },
              {
                "status": 4,
                "filePath": "Podfile.lock"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/Pods-Crazy Monkey Twin Cities/Pods-Crazy Monkey Twin Cities-acknowledgements.markdown"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/Pods-Crazy Monkey Twin Cities/Pods-Crazy Monkey Twin Cities-acknowledgements.plist"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/Pods-Crazy Monkey Twin Cities/Pods-Crazy Monkey Twin Cities.debug.xcconfig"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/Pods-Crazy Monkey Twin Cities/Pods-Crazy Monkey Twin Cities.release.xcconfig"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOS/Pods-CrazyMonkeyTwinCitiesiOS-acknowledgements.markdown"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOS/Pods-CrazyMonkeyTwinCitiesiOS-acknowledgements.plist"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOS/Pods-CrazyMonkeyTwinCitiesiOS-frameworks.sh"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOS/Pods-CrazyMonkeyTwinCitiesiOS.debug.xcconfig"
              },
              {
                "status": 4,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOS/Pods-CrazyMonkeyTwinCitiesiOS.release.xcconfig"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Pods-CrazyMonkeyTwinCitiesiOSTests-acknowledgements.markdown"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Pods-CrazyMonkeyTwinCitiesiOSTests-acknowledgements.plist"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Pods-CrazyMonkeyTwinCitiesiOSTests-dummy.m"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Pods-CrazyMonkeyTwinCitiesiOSTests-frameworks.sh"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Pods-CrazyMonkeyTwinCitiesiOSTests-resources.sh"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Pods-CrazyMonkeyTwinCitiesiOSTests-umbrella.h"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Pods-CrazyMonkeyTwinCitiesiOSTests.debug.xcconfig"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Pods-CrazyMonkeyTwinCitiesiOSTests.modulemap"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/Pods-CrazyMonkeyTwinCitiesiOSTests/Pods-CrazyMonkeyTwinCitiesiOSTests.release.xcconfig"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/PostalAddress.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/PostalAddressOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/PriceSpecification.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Product/Product.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Product/ProductModel.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ProductModelOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ProductOrService.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ProductOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ProductOrTextOrURL.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/ProgramMembership.swift"
              },
              {
                "status": 4,
                "filePath": "Pods/Pods.xcodeproj/project.pbxproj"
              },
              {
                "status": 4,
                "filePath": "Crazy Monkey Twin Cities.xcodeproj/project.pbxproj"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/PropertyValue.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/PropertyValueOrText.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Event/PublicationEvent.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/QualitativeValue.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/QuantitativeValue.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Quantity.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Question.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Rating.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/README.md"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Review.swift"
              },
              {
                "status": 1,
                "filePath": "CrazyMonkeyTwinCitiesiOSTests/SchemaTests.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/Service.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/ServiceChannel.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Action/SOAction.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Place/SOAdministrativeArea.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOAggregateRating.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOAlignmentObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOAnswer.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOArticle.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOAudience.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOAudioObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOBrand.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOBroadcastService.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOComment.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOContactPoint.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Place/SOCountry.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOCourse.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Event/SOCourseInstance.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOCreativeWork.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SODemand.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SODistance.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Organization/SOEducationalOrganization.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOEntryPoint.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOEnumeration.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Event/SOEvent.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/SoftwareApplication.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/SoftwareApplicationOrWebsite.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOGeoCoordinates.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOGeoShape.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOImageObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOIntangible.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOInteractionCounter.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOItemList.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOLanguage.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOListItem.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOLocationFeatureSpecification.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOMap.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOMediaObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOMonetaryAmount.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOMusicAlbum.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Organization/SOMusicGroup.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOMusicPlaylist.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOMusicRecording.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SONewsArticle.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOOffer.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOOfferCatalog.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOOpeningHoursSpecification.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Organization/SOOrganization.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOOwnershipInfo.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Organization/SOPerformingGroup.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Person/SOPerson.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOPhotograph.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Place/SOPlace.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOPostalAddress.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOPriceSpecification.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Product/SOProduct.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Product/SOProductModel.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOProgramMembership.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOPropertyValue.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Event/SOPublicationEvent.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOQualitativeValue.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOQuantitativeValue.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOQuantity.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOQuestion.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SORating.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOReview.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOService.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/Intangible/SOStructuredValue.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/SOSwift/SOSwift-dummy.m"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/SOSwift/SOSwift-prefix.pch"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/SOSwift/SOSwift-umbrella.h"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/SOSwift/SOSwift.modulemap"
              },
              {
                "status": 1,
                "filePath": "Pods/Target Support Files/SOSwift/SOSwift.xcconfig"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/SOThing.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/SOThing+Internal.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Implementation/CreativeWork/SOVideoObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Intangible/StructuredValue.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/TextOrThing.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/TextOrURL.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/Thing.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/Time.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/Value.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/DataType/ValueReference.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/VideoObject.swift"
              },
              {
                "status": 1,
                "filePath": "Pods/SOSwift/Sources/Schema.org/CreativeWork/Website.swift"
              }
            ],
            "XCSCommitContributor": {
              "XCSContributorEmails": [
                "richard@richardpiazza.com"
              ],
              "XCSContributorName": "Richard Piazza",
              "XCSContributorDisplayName": "Richard Piazza"
            },
            "XCSCommitHash": "827db74b09982586692c30c38d66b3d857852053",
            "XCSCommitMessage": "Updated App Icon; added SOSwift for schema.org (json-ld) parsing\n",
            "XCSCommitIsMerge": "NO",
            "XCSCommitTimestamp": "2017-05-27T20:42:59.000Z",
            "XCSCommitTimestampDate": [
              2017,
              5,
              27,
              20,
              42,
              59,
              0
            ]
          },
          {
            "XCSBlueprintRepositoryID": "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
            "XCSCommitCommitChangeFilePaths": [
              {
                "status": 4,
                "filePath": "Crazy Monkey Twin Cities.xcodeproj/xcshareddata/xcschemes/CrazyMonkeyTwinCitiesiOS.xcscheme"
              }
            ],
            "XCSCommitContributor": {
              "XCSContributorEmails": [
                "richard@richardpiazza.com"
              ],
              "XCSContributorName": "Richard Piazza",
              "XCSContributorDisplayName": "Richard Piazza"
            },
            "XCSCommitHash": "9add709cbdffdde4da9d4d87f770273deae8f835",
            "XCSCommitMessage": "Disabled empty tests.\n",
            "XCSCommitIsMerge": "NO",
            "XCSCommitTimestamp": "2017-04-12T13:10:01.000Z",
            "XCSCommitTimestampDate": [
              2017,
              4,
              12,
              13,
              10,
              1,
              0
            ]
          }
        ]
      },
      "integration": "7b0bfdf8f209bf9b85b8aa02051031e7",
      "botID": "7b0bfdf8f209bf9b85b8aa0205102b39",
      "botTinyID": "BF9D28C",
      "endedTimeDate": [
        2017,
        6,
        7,
        18,
        5,
        11,
        801
      ],
      "doc_type": "commit",
      "tinyID": "F17CD3A"
    }
  ]
}
```

__Request__: `[GET] /integrations/{id}/issues`

__Response__: `200`

```json
 {
     "buildServiceErrors":[
         {
             "_id":"7b0bfdf8f209bf9b85b8aa02051074ba",
             "_rev":"3-ebd0fd58747f777f585a2edecb20fa16",
             "message":"Error Domain=IBMessageChannelErrorDomain Code=4 \"Failed to communicate with Interface Builder\" UserInfo={NSLocalizedDescription=Failed to communicate with Interface Builder, NSLocalizedFailureReason=The agent crashed}",
             "type":"buildServiceError",
             "issueType":"buildServiceError",
             "commits":[],
             "integrationID":"7b0bfdf8f209bf9b85b8aa02051031e7",
             "age":0,
             "status":0,
             "issueAuthors":[]
         }
     ],
     "buildServiceWarnings":[],
     "triggerErrors":[],
     "errors":{
         "unresolvedIssues":[],
         "freshIssues":[],
         "resolvedIssues":[],
         "silencedIssues":[]
     },
     "warnings":{
         "unresolvedIssues":[],
         "freshIssues":[],
         "resolvedIssues":[],
         "silencedIssues":[]
     },
     "testFailures":{
         "unresolvedIssues":[],
         "freshIssues":[],
         "resolvedIssues":[],
         "silencedIssues":[]
     },
     "analyzerWarnings":{
         "unresolvedIssues":[],
         "freshIssues":[],
         "resolvedIssues":[],
         "silencedIssues":[]
     }
 }
```

__Request__: `[GET] /integrations/{id}/coverage`

__Response__: `200`

## Documents

### _Repository Blueprint_

```json
{
    "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey":[],
    "DVTSourceControlWorkspaceBlueprintLocationsKey":{
        "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":{
            "DVTSourceControlBranchIdentifierKey":"master",
            "DVTSourceControlLocationRevisionKey":"cdfd4c217d5b85530c2b81849d327e400af84015",
            "DVTSourceControlBranchOptionsKey":4,
            "DVTSourceControlBranchRemoteNameKey":"origin",
            "DVTSourceControlWorkspaceBlueprintLocationTypeKey":"DVTSourceControlBranch"
        }
    },
    "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey":"3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
    "DVTSourceControlWorkspaceBlueprintIdentifierKey":"8C2D69B0-B9A6-48BF-BB17-B7ABB0D34F2D",
    "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey":{
        "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":"CrazyMonkey/"
    },
    "DVTSourceControlWorkspaceBlueprintNameKey":"Crazy Monkey Twin Cities",
    "DVTSourceControlWorkspaceBlueprintVersion":205,
    "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey":"Crazy Monkey Twin Cities.xcworkspace",
    "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey":[
        {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey":"bitbucket.org:richardpiazza/com.crazymonkeytwincities.ios.git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey":"com.apple.dt.Xcode.sourcecontrol.Git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey":"3B5CFDF38F1AD11BC1804F5A657156F5835DCED9"
        }
    ]
}
```

### _BotDocument_

```json
{
   "_id":"7b0bfdf8f209bf9b85b8aa0205102b39",
   "_rev":"5-935dc8a5892b549b159cb001ccc271e5",
   "group":{
       "name":"D4A38F79-6573-46B5-877C-B7A5E662DC9F"
   },
   "configuration":{
       BOT CONFIGURATION
   },
   "requiresUpgrade":false,
   "name":"CrazyMonkeyTwinCitiesiOS Bot",
   "type":1,
   "sourceControlBlueprintIdentifier":"7559BA65-0DE8-44CE-8BAF-542529CDF63A",
   "integration_counter":2,
   "doc_type":"bot",
   "tinyID":"BF9D28C",
   "lastRevisionBlueprint":{
       "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey":[],
       "DVTSourceControlWorkspaceBlueprintLocationsKey":{
           "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":{
               "DVTSourceControlBranchIdentifierKey":"master",
               "DVTSourceControlLocationRevisionKey":"cdfd4c217d5b85530c2b81849d327e400af84015",
               "DVTSourceControlBranchOptionsKey":4,
               "DVTSourceControlBranchRemoteNameKey":"origin",
               "DVTSourceControlWorkspaceBlueprintLocationTypeKey":"DVTSourceControlBranch"
           }
       },
       "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey":"3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
       "DVTSourceControlWorkspaceBlueprintIdentifierKey":"8C2D69B0-B9A6-48BF-BB17-B7ABB0D34F2D",
       "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey":{
           "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":"CrazyMonkey/"
       },
       "DVTSourceControlWorkspaceBlueprintNameKey":"Crazy Monkey Twin Cities",
       "DVTSourceControlWorkspaceBlueprintVersion":205,
       "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey":"Crazy Monkey Twin Cities.xcworkspace",
       "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey":[
           {
               "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey":"bitbucket.org:richardpiazza/com.crazymonkeytwincities.ios.git",
               "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey":"com.apple.dt.Xcode.sourcecontrol.Git",
               "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey":"3B5CFDF38F1AD11BC1804F5A657156F5835DCED9"
           }
       ]
   }
}
```

### _Configuration_

```json
{
    "triggers":[],
    "hourOfIntegration":0,
    "performsUpgradeIntegration":false,
    "disableAppThinning":false,
    "provisioningConfiguration":{
        "addMissingDevicesToTeams":false,
        "manageCertsAndProfiles":false
    },
    "periodicScheduleInterval":0,
    "deviceSpecification":{
        "filters":[
            {
                "platform":{"_id":"55c38846721f430c8fa94d67030020e0","displayName":"iOS","_rev":"15-7382c20978c7c104397747a672826a8b","simulatorIdentifier":"com.apple.platform.iphonesimulator","identifier":"com.apple.platform.iphoneos","buildNumber":"14E8301","version":"10.3.1"},
                "filterType":0,
                "architectureType":0
            }
        ],
        "deviceIdentifiers":[]
    },
    "buildEnvironmentVariables":{},
    "schemeName":"CrazyMonkeyTwinCitiesiOS",
    "additionalBuildArguments":[],
    "codeCoveragePreference":2,
    "performsTestAction":true,
    "scheduleType":3,
    "useParallelDeviceTesting":true,
    "performsArchiveAction":true,
    "builtFromClean":3,
    "performsAnalyzeAction":true,
    "exportsProductFromArchive":true,
    "weeklyScheduleDay":0,
    "runOnlyDisabledTests":false,
    "testingDestinationType":0,
    "minutesAfterHourToIntegrate":0,
    "testLocalizations":[],
    "sourceControlBlueprint":{
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey":{
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":{
                "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey":"DVTSourceControlSSHKeysAuthenticationStrategy"
            }
        },
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey":[
            {
                "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey":true,
                "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey":"bitbucket.org:richardpiazza/com.crazymonkeytwincities.ios.git",
                "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey":"978C1BF26F146B5C3BECAA4646747C40",
                "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey":"3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
                "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey":"com.apple.dt.Xcode.sourcecontrol.Git"
            }
        ],
        "DVTSourceControlWorkspaceBlueprintLocationsKey":{
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":{
                "DVTSourceControlBranchIdentifierKey":"master",
                "DVTSourceControlBranchOptionsKey":4,
                "DVTSourceControlWorkspaceBlueprintLocationTypeKey":"DVTSourceControlBranch"
            }
        },
        "DVTSourceControlWorkspaceBlueprintWorkingCopyRepositoryLocationsKey":{},
        "DVTSourceControlWorkspaceBlueprintVersion":205,
        "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey":"Crazy Monkey Twin Cities.xcworkspace",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey":"C83C0E6A-F936-4C52-B475-8147D9488784",
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey":[],
        "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey":{
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":0
        },
        "DVTSourceControlWorkspaceBlueprintNameKey":"Crazy Monkey Twin Cities",
        "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey":{
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":"CrazyMonkey/"
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey":"3B5CFDF38F1AD11BC1804F5A657156F5835DCED9"
    }
}
```

### _IntegrationDocument_

```json
{
    "_id":"7b0bfdf8f209bf9b85b8aa02051031e7",
    "_rev":"12-0d12e2a154a73f026507dcc703db65fc",
    "bot":{
        BOT
    },
    "number":1,
    "currentStep":"completed",
    "result":"build-failed",
    "queuedDate":"2017-06-07T18:04:24.757Z",
    "success_streak":0,
    "shouldClean":false,
    "assets":{
        "xcodebuildLog":{
            "size":2058743,
            "fileName":"xcodebuild.log",
            "allowAnonymousAccess":false,
            "relativePath":"7b0bfdf8f209bf9b85b8aa0205102b39-CrazyMonkeyTwinCitiesiOS Bot/1/xcodebuild.log"
        },
        "sourceControlLog":{
            "size":3882,
            "fileName":"sourceControl.log",
            "allowAnonymousAccess":false,
            "relativePath":"7b0bfdf8f209bf9b85b8aa0205102b39-CrazyMonkeyTwinCitiesiOS Bot/1/sourceControl.log"
        },
        "buildServiceLog":{
            "size":14323,
            "fileName":"buildService.log",
            "allowAnonymousAccess":false,
            "relativePath":"7b0bfdf8f209bf9b85b8aa0205102b39-CrazyMonkeyTwinCitiesiOS Bot/1/buildService.log"
        }
    },
    "doc_type":"integration",
    "tinyID":"D33300B",
    "buildServiceFingerprint":"90:0E:2D:F7:F1:36:19:43:0D:8A:74:F2:AD:BA:32:7F:15:C6:2F:55",
    "tags":[],
    "startedTime":"2017-06-07T18:04:25.763Z",
    "revisionBlueprint":{
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey":[],
        "DVTSourceControlWorkspaceBlueprintLocationsKey":{
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":{
                "DVTSourceControlBranchIdentifierKey":"master",
                "DVTSourceControlLocationRevisionKey":"cdfd4c217d5b85530c2b81849d327e400af84015",
                "DVTSourceControlBranchOptionsKey":4,
                "DVTSourceControlBranchRemoteNameKey":"origin",
                "DVTSourceControlWorkspaceBlueprintLocationTypeKey":"DVTSourceControlBranch"
            }
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey":"3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey":"8C2D69B0-B9A6-48BF-BB17-B7ABB0D34F2D",
        "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey":{
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9":"CrazyMonkey/"
        },
        "DVTSourceControlWorkspaceBlueprintNameKey":"Crazy Monkey Twin Cities",
        "DVTSourceControlWorkspaceBlueprintVersion":205,
        "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey":"Crazy Monkey Twin Cities.xcworkspace",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey":[
            {
                "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey":"bitbucket.org:richardpiazza/com.crazymonkeytwincities.ios.git",
                "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey":"com.apple.dt.Xcode.sourcecontrol.Git",
                "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey":"3B5CFDF38F1AD11BC1804F5A657156F5835DCED9"
            }
        ]
    },
    "endedTime":"2017-06-07T18:11:11.297Z",
    "endedTimeDate":[
        2017,
        6,
        7,
        18,
        11,
        11,
        297
    ],
    "duration":405.534,
    "ccPercentage":0,
    "ccPercentageDelta":0
}
```
