import Foundation

let structured18Json: String = """
{
  "_id": "4dce4862459fab67e33ff9cae7004b04",
  "_rev": "20-40ee3abb3c071d73c6f44b1233d10c0a",
  "bot": {
    "_id": "c50a58f76e7104f98942443df600c26c",
    "_rev": "43-fc6a8f5a08db502c3ae61bbfee17d30a",
    "group": {
      "name": "CEC6F229-4C41-49FE-9E65-C43A5EA25294"
    },
    "configuration": {
      "triggers": [
        {
          "phase": 1,
          "scriptBody": "#!/bin/bash\\n\\nPROJECT_NAME=\\"Structured\\"\\nGIT_USER_NAME=\\"Xcode Server\\"\\nGIT_USER_EMAIL=\\"xcodeserver@richardpiazza.com\\"\\n\\necho \\"Checking Git Global Configuration\\"\\nUSERNAME=`git config --global --get user.name`\\nUSEREMAIL=`git config --global --get user.email`\\n\\nif [ -z \\"$USERNAME\\" ];\\nthen\\necho \\"Setting Git Global user.name\\"\\n`git config --global user.name \\"$GIT_USER_NAME\\"`\\nelse\\necho \\"Git Global user.name: $USERNAME\\"\\nfi\\n\\nif [ -z \\"$USEREMAIL\\" ];\\nthen\\necho \\"Setting Git Global user.email\\"\\n`git config --global user.email \\"$GIT_USER_EMAIL\\"`\\nelse\\necho \\"Git Global user.email: $USEREMAIL\\"\\nfi\\n",
          "type": 1,
          "name": "Git Setup",
          "conditions": {
            "status": 2,
            "onAllIssuesResolved": true,
            "onWarnings": true,
            "onBuildErrors": true,
            "onAnalyzerWarnings": true,
            "onFailingTests": true,
            "onSuccess": true
          }
        },
        {
          "phase": 1,
          "scriptBody": "#!/bin/bash\\n\\nPROJECT_NAME=\\"Structured\\"\\nPROJECT_PLATFORM=\\"iOS\\"\\n\\necho \\"Tagging Repository\\"\\n\\nif [ -n \\"$XCS_INTEGRATION_NUMBER\\" ];\\nthen\\necho \\"Source Directory: $XCS_SOURCE_DIR\\"\\necho \\"Project Directory: $PROJECT_NAME\\"\\necho \\"Integration: $XCS_INTEGRATION_NUMBER\\"\\nTAG=\\"$PROJECT_PLATFORM-$XCS_INTEGRATION_NUMBER\\"\\nGITSOURCE=\\"$XCS_SOURCE_DIR/$PROJECT_NAME\\"\\n`git -C \\"$GITSOURCE\\" tag -a \\"$TAG\\" -m \\"$PROJECT_PLATFORM Build $XCS_INTEGRATION_NUMBER\\"`\\n`git -C \\"$GITSOURCE\\" push origin tag \\"$TAG\\"`;\\nelse\\necho \\"No XCS Integration Number\\";\\nfi\\n",
          "type": 1,
          "name": "Git Tag",
          "conditions": {
            "status": 2,
            "onAllIssuesResolved": true,
            "onWarnings": true,
            "onBuildErrors": true,
            "onAnalyzerWarnings": true,
            "onFailingTests": true,
            "onSuccess": true
          }
        }
      ],
      "testLocalizations": [],
      "performsUpgradeIntegration": false,
      "disableAppThinning": true,
      "provisioningConfiguration": {
        "addMissingDevicesToTeams": false,
        "manageCertsAndProfiles": false
      },
      "periodicScheduleInterval": 0,
      "deviceSpecification": {
        "filters": [
          {
            "platform": {
              "_id": "9630e858952ff70121601479aa0018e8",
              "displayName": "iOS",
              "_rev": "92-26e37ea3373a53499a3fa047a618ee0e",
              "simulatorIdentifier": "com.apple.platform.iphonesimulator",
              "identifier": "com.apple.platform.iphoneos",
              "buildNumber": "15C107",
              "version": "11.2"
            },
            "filterType": 3,
            "architectureType": 0
          }
        ],
        "deviceIdentifiers": [
          "2478c325aea64ed6e16f38ed6e009319",
          "1e2435b8f14b4299696f6c51de00649d",
          "2478c325aea64ed6e16f38ed6e00ba4a",
          "2478c325aea64ed6e16f38ed6e00b0e7",
          "69561babb98bc6d688806fc96e00147d",
          "a4ff07a438b65b4d93a49914e600742d",
          "1e2435b8f14b4299696f6c51de0053ce",
          "1e2435b8f14b4299696f6c51de00479f",
          "69561babb98bc6d688806fc96e00246a"
        ]
      },
      "buildEnvironmentVariables": {},
      "schemeName": "Structured",
      "additionalBuildArguments": [],
      "codeCoveragePreference": 2,
      "performsTestAction": true,
      "scheduleType": 3,
      "useParallelDeviceTesting": false,
      "performsArchiveAction": true,
      "archiveExportOptions": {
        "name": "ExportOptions.plist",
        "createdAt": "2018-01-23T17:46:06.098Z",
        "exportOptions": {
          "method": "app-store",
          "teamID": "EX6YK9HKXA",
          "uploadBitcode": true,
          "stripSwiftSymbols": true,
          "iCloudContainerEnvironment": "Production",
          "signingCertificate": "iPhone Distribution",
          "signingStyle": "manual",
          "uploadSymbols": true,
          "provisioningProfiles": {
            "com.richardpiazza.structured": "iOS Distribution: com.richardpiazza.structured"
          }
        }
      },
      "builtFromClean": 3,
      "performsAnalyzeAction": true,
      "sourceControlBlueprint": {
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey": {
          "F0ECD473CD0A2C01179E1CA74CE111F216666C90": {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey": "DVTSourceControlAuthenticationStrategy"
          }
        },
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
          {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.structured.git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "F0ECD473CD0A2C01179E1CA74CE111F216666C90"
          }
        ],
        "DVTSourceControlWorkspaceBlueprintLocationsKey": {
          "F0ECD473CD0A2C01179E1CA74CE111F216666C90": {
            "DVTSourceControlBranchIdentifierKey": "master",
            "DVTSourceControlBranchOptionsKey": 4,
            "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
          }
        },
        "DVTSourceControlWorkspaceBlueprintWorkingCopyRepositoryLocationsKey": {},
        "DVTSourceControlWorkspaceBlueprintVersion": 205,
        "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Structured.xcworkspace",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey": "67F4DF0A-7385-49C1-9D0C-AE3892DF4108",
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
        "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey": {
          "F0ECD473CD0A2C01179E1CA74CE111F216666C90": 0
        },
        "DVTSourceControlWorkspaceBlueprintNameKey": "Structured",
        "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
          "F0ECD473CD0A2C01179E1CA74CE111F216666C90": "Structured/"
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "F0ECD473CD0A2C01179E1CA74CE111F216666C90"
      },
      "exportsProductFromArchive": true,
      "weeklyScheduleDay": 0,
      "runOnlyDisabledTests": false,
      "minutesAfterHourToIntegrate": 0,
      "testingDestinationType": 0,
      "hourOfIntegration": 0
    },
    "requiresUpgrade": false,
    "name": "Structured iOS",
    "type": 1,
    "sourceControlBlueprintIdentifier": "4ABBB20D-A0B5-49BA-86E8-62372A0B53CB",
    "integration_counter": 18,
    "doc_type": "bot",
    "tinyID": "25975A7",
    "lastRevisionBlueprint": {
      "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
      "DVTSourceControlWorkspaceBlueprintLocationsKey": {
        "F0ECD473CD0A2C01179E1CA74CE111F216666C90": {
          "DVTSourceControlBranchIdentifierKey": "master",
          "DVTSourceControlLocationRevisionKey": "6ab8dc5f677cf1e5efebce256e5bf06cac7e56c0",
          "DVTSourceControlBranchOptionsKey": 4,
          "DVTSourceControlBranchRemoteNameKey": "origin",
          "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
        }
      },
      "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "F0ECD473CD0A2C01179E1CA74CE111F216666C90",
      "DVTSourceControlWorkspaceBlueprintIdentifierKey": "DC72B26B-8788-486E-9E81-61E094F45E5C",
      "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
        "F0ECD473CD0A2C01179E1CA74CE111F216666C90": "Structured/"
      },
      "DVTSourceControlWorkspaceBlueprintNameKey": "Structured",
      "DVTSourceControlWorkspaceBlueprintVersion": 205,
      "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Structured.xcworkspace",
      "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
        {
          "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.structured.git",
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "F0ECD473CD0A2C01179E1CA74CE111F216666C90"
        }
      ]
    }
  },
  "number": 18,
  "currentStep": "completed",
  "result": "build-failed",
  "queuedDate": "2019-04-20T18:32:17.586Z",
  "success_streak": 0,
  "shouldClean": false,
  "assets": {
    "xcodebuildOutput": {
      "size": 1910369,
      "fileName": "xcodebuild_result.xcresult.zip",
      "allowAnonymousAccess": false,
      "isDirectory": true,
      "relativePath": "c50a58f76e7104f98942443df600c26c-Structured iOS/18/xcodebuild_result.xcresult.zip"
    },
    "buildServiceLog": {
      "size": 45541,
      "fileName": "buildService.log",
      "allowAnonymousAccess": false,
      "relativePath": "c50a58f76e7104f98942443df600c26c-Structured iOS/18/buildService.log"
    },
    "xcodebuildLog": {
      "size": 3687952,
      "fileName": "xcodebuild.log",
      "allowAnonymousAccess": false,
      "relativePath": "c50a58f76e7104f98942443df600c26c-Structured iOS/18/xcodebuild.log"
    },
    "triggerAssets": [
      {
        "size": 122,
        "fileName": "trigger-before-0.log",
        "allowAnonymousAccess": false,
        "triggerName": "Git Setup",
        "relativePath": "c50a58f76e7104f98942443df600c26c-Structured iOS/18/trigger-before-0.log"
      },
      {
        "size": 275,
        "fileName": "trigger-before-1.log",
        "allowAnonymousAccess": false,
        "triggerName": "Git Tag",
        "relativePath": "c50a58f76e7104f98942443df600c26c-Structured iOS/18/trigger-before-1.log"
      }
    ],
    "sourceControlLog": {
      "size": 4750,
      "fileName": "sourceControl.log",
      "allowAnonymousAccess": false,
      "relativePath": "c50a58f76e7104f98942443df600c26c-Structured iOS/18/sourceControl.log"
    }
  },
  "doc_type": "integration",
  "controlledChanges": {
    "configuration": {
      "builtFromClean": {
        "before": 1,
        "after": 3
      },
      "deviceSpecification": {
        "before": {
          "filters": [
            {
              "platform": {
                "_id": "9630e858952ff70121601479aa0018e8",
                "displayName": "iOS",
                "_rev": "92-26e37ea3373a53499a3fa047a618ee0e",
                "simulatorIdentifier": "com.apple.platform.iphonesimulator",
                "identifier": "com.apple.platform.iphoneos",
                "buildNumber": "15C107",
                "version": "11.2"
              },
              "filterType": 3,
              "architectureType": 0
            }
          ],
          "deviceIdentifiers": [
            "9630e858952ff70121601479aa00c123",
            "9630e858952ff70121601479aa00815f",
            "9630e858952ff70121601479aa002ac8",
            "9630e858952ff70121601479aa00642a",
            "9630e858952ff70121601479aa00ab5d",
            "9630e858952ff70121601479aa008948",
            "9630e858952ff70121601479aa00d6ad"
          ]
        },
        "after": {
          "filters": [
            {
              "platform": {
                "_id": "9630e858952ff70121601479aa0018e8",
                "displayName": "iOS",
                "_rev": "92-26e37ea3373a53499a3fa047a618ee0e",
                "simulatorIdentifier": "com.apple.platform.iphonesimulator",
                "identifier": "com.apple.platform.iphoneos",
                "buildNumber": "15C107",
                "version": "11.2"
              },
              "filterType": 3,
              "architectureType": 0
            }
          ],
          "deviceIdentifiers": [
            "2478c325aea64ed6e16f38ed6e009319",
            "1e2435b8f14b4299696f6c51de00649d",
            "2478c325aea64ed6e16f38ed6e00ba4a",
            "2478c325aea64ed6e16f38ed6e00b0e7",
            "69561babb98bc6d688806fc96e00147d",
            "a4ff07a438b65b4d93a49914e600742d",
            "1e2435b8f14b4299696f6c51de0053ce",
            "1e2435b8f14b4299696f6c51de00479f",
            "69561babb98bc6d688806fc96e00246a"
          ]
        }
      }
    }
  },
  "tinyID": "605B9D5",
  "buildServiceFingerprint": "AC:7A:F2:D2:92:C5:3D:95:01:4A:97:95:B5:6A:E7:A1:0F:93:8A:9F",
  "tags": [],
  "startedTime": "2019-04-20T18:32:18.026Z",
  "revisionBlueprint": {
    "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
    "DVTSourceControlWorkspaceBlueprintLocationsKey": {
      "F0ECD473CD0A2C01179E1CA74CE111F216666C90": {
        "DVTSourceControlBranchIdentifierKey": "master",
        "DVTSourceControlLocationRevisionKey": "45e33bdd9e9257ba68fd0b0e5c4e1339e3688247",
        "DVTSourceControlBranchOptionsKey": 4,
        "DVTSourceControlBranchRemoteNameKey": "origin",
        "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
      }
    },
    "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "F0ECD473CD0A2C01179E1CA74CE111F216666C90",
    "DVTSourceControlWorkspaceBlueprintIdentifierKey": "15AA3E4E-5A60-4B98-9B24-C4376CFC4735",
    "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
      "F0ECD473CD0A2C01179E1CA74CE111F216666C90": "Structured/"
    },
    "DVTSourceControlWorkspaceBlueprintNameKey": "Structured",
    "DVTSourceControlWorkspaceBlueprintVersion": 205,
    "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Structured.xcworkspace",
    "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
      {
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.structured.git",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "F0ECD473CD0A2C01179E1CA74CE111F216666C90"
      }
    ]
  },
  "buildResultSummary": {
    "analyzerWarningCount": 0,
    "testFailureCount": 0,
    "testsChange": 0,
    "errorCount": 0,
    "testsCount": 0,
    "testFailureChange": 0,
    "warningChange": 0,
    "regressedPerfTestCount": 0,
    "warningCount": 0,
    "errorChange": 0,
    "improvedPerfTestCount": 0,
    "analyzerWarningChange": 0,
    "codeCoveragePercentage": 0,
    "codeCoveragePercentageDelta": 0
  },
  "endedTime": "2019-04-20T18:37:34.957Z",
  "endedTimeDate": [
    2019,
    4,
    20,
    18,
    37,
    34,
    957
  ],
  "duration": 316.931,
  "ccPercentage": 0,
  "ccPercentageDelta": 0,
  "testedDevices": [
    {
      "osVersion": "12.2",
      "connected": true,
      "simulator": true,
      "modelCode": "iPad8,1",
      "deviceType": "com.apple.iphone-simulator",
      "modelName": "iPad Pro (11-inch)",
      "revision": "4-6c792fcb76fa1e73b4b2f7f5d184e5cf",
      "modelUTI": "com.apple.ipad-pro-11-1",
      "modelCodename": "iPad Pro (11-inch)",
      "name": "iPad Pro (11-inch)",
      "trusted": true,
      "doc_type": "device",
      "supported": true,
      "identifier": "D1519D86-AE2D-4954-BB66-8A770ACF1731",
      "wireless": false,
      "enabledForDevelopment": true,
      "platformIdentifier": "com.apple.platform.iphonesimulator",
      "ID": "69561babb98bc6d688806fc96e00246a",
      "architecture": "x86_64",
      "retina": false,
      "isServer": false,
      "tinyID": "2C1851A"
    },
    {
      "osVersion": "12.2",
      "activeProxiedDevice": {
        "modelUTI": "com.apple.watch-series4-1",
        "connected": true,
        "wireless": false,
        "modelCode": "Watch4,4",
        "simulator": true,
        "modelCodename": "Apple Watch Series 4 - 44mm",
        "osVersion": "5.2",
        "deviceType": "com.apple.iphone-simulator",
        "modelName": "Apple Watch Series 4 - 44mm",
        "identifier": "A3AD8595-F683-4704-8BEF-83188A276E2A",
        "supported": true,
        "architecture": "i386",
        "enabledForDevelopment": true,
        "isServer": false,
        "doc_type": "device",
        "trusted": true,
        "platformIdentifier": "com.apple.platform.watchsimulator",
        "name": "Apple Watch Series 4 - 44mm",
        "retina": false
      },
      "connected": true,
      "simulator": true,
      "modelCode": "iPhone11,4",
      "deviceType": "com.apple.iphone-simulator",
      "modelName": "iPhone Xs Max",
      "revision": "1079-d09d3326cc70d54d02b2da1179f43573",
      "modelUTI": "com.apple.iphone-xs-max-1",
      "modelCodename": "iPhone Xs Max",
      "name": "iPhone Xs Max",
      "trusted": true,
      "doc_type": "device",
      "supported": true,
      "identifier": "0E5E1413-AFAF-4533-8E2B-AEC25A4FA179",
      "wireless": false,
      "enabledForDevelopment": true,
      "platformIdentifier": "com.apple.platform.iphonesimulator",
      "ID": "1e2435b8f14b4299696f6c51de0053ce",
      "architecture": "x86_64",
      "retina": false,
      "isServer": false,
      "tinyID": "4B40A91"
    },
    {
      "osVersion": "12.2",
      "connected": true,
      "simulator": true,
      "modelCode": "iPhone11,8",
      "deviceType": "com.apple.iphone-simulator",
      "modelName": "iPhone Xʀ",
      "revision": "3-d47b8116c2e309343f7ff138be94f61c",
      "modelUTI": "com.apple.iphone-xr-1",
      "modelCodename": "iPhone Xʀ",
      "name": "iPhone Xʀ",
      "trusted": true,
      "doc_type": "device",
      "supported": true,
      "identifier": "40863A01-BE6D-46C6-8D80-D644DBAF050A",
      "wireless": false,
      "enabledForDevelopment": true,
      "platformIdentifier": "com.apple.platform.iphonesimulator",
      "ID": "1e2435b8f14b4299696f6c51de00479f",
      "architecture": "x86_64",
      "retina": false,
      "isServer": false,
      "tinyID": "C752CF8"
    },
    {
      "osVersion": "12.2",
      "connected": true,
      "simulator": true,
      "modelCode": "iPad7,6",
      "deviceType": "com.apple.iphone-simulator",
      "modelName": "iPad (6th generation)",
      "revision": "5-1a4831e65d1d8548c1fd46464e91c326",
      "modelUTI": "com.apple.ipad-6-a1954-1",
      "modelCodename": "iPad (6th generation)",
      "name": "iPad (6th generation)",
      "trusted": true,
      "doc_type": "device",
      "supported": true,
      "identifier": "1A72D2D3-6D1A-4D6C-B5BA-101C023BFC4F",
      "wireless": false,
      "enabledForDevelopment": true,
      "platformIdentifier": "com.apple.platform.iphonesimulator",
      "ID": "a4ff07a438b65b4d93a49914e600742d",
      "architecture": "x86_64",
      "retina": false,
      "isServer": false,
      "tinyID": "3D7D764"
    },
    {
      "osVersion": "12.2",
      "connected": true,
      "simulator": true,
      "modelCode": "iPad8,5",
      "deviceType": "com.apple.iphone-simulator",
      "modelName": "iPad Pro (12.9-inch) (3rd generation)",
      "revision": "4-193fb1273267af66584deac96417c31b",
      "modelUTI": "com.apple.ipad-pro-12point9-1",
      "modelCodename": "iPad Pro (12.9-inch) (3rd generation)",
      "name": "iPad Pro (12.9-inch) (3rd generation)",
      "trusted": true,
      "doc_type": "device",
      "supported": true,
      "identifier": "7B8FE593-1C56-4B0C-B590-887C1637116F",
      "wireless": false,
      "enabledForDevelopment": true,
      "platformIdentifier": "com.apple.platform.iphonesimulator",
      "ID": "69561babb98bc6d688806fc96e00147d",
      "architecture": "x86_64",
      "retina": false,
      "isServer": false,
      "tinyID": "C9CD3D9"
    },
    {
      "osVersion": "12.2",
      "activeProxiedDevice": {
        "modelUTI": "com.apple.watch-42mm-series3-gps-1",
        "connected": true,
        "wireless": false,
        "modelCode": "Watch3,4",
        "simulator": true,
        "modelCodename": "Apple Watch Series 3 - 42mm",
        "osVersion": "4.3",
        "deviceType": "com.apple.iphone-simulator",
        "modelName": "Apple Watch Series 3 - 42mm",
        "identifier": "D29C35FC-CA18-4238-8F5F-C642F937B72D",
        "supported": true,
        "architecture": "i386",
        "enabledForDevelopment": true,
        "isServer": false,
        "doc_type": "device",
        "trusted": true,
        "platformIdentifier": "com.apple.platform.watchsimulator",
        "name": "Apple Watch Series 3 - 42mm",
        "retina": false
      },
      "connected": true,
      "simulator": true,
      "modelCode": "iPhone10,5",
      "deviceType": "com.apple.iphone-simulator",
      "modelName": "iPhone 8 Plus",
      "revision": "2196-2430e2f01b0994b8609849032ade5e76",
      "modelUTI": "com.apple.iphone-8-plus-2",
      "modelCodename": "iPhone 8 Plus",
      "name": "iPhone 8 Plus",
      "trusted": true,
      "doc_type": "device",
      "supported": true,
      "identifier": "C374B956-D9C3-4F76-BA36-B4DBA10EE59D",
      "wireless": false,
      "enabledForDevelopment": true,
      "platformIdentifier": "com.apple.platform.iphonesimulator",
      "ID": "2478c325aea64ed6e16f38ed6e00ba4a",
      "architecture": "x86_64",
      "retina": false,
      "isServer": false,
      "tinyID": "FB7D2A6"
    },
    {
      "osVersion": "12.2",
      "activeProxiedDevice": {
        "modelUTI": "com.apple.watch-38mm-series3-gps-1",
        "connected": true,
        "wireless": false,
        "modelCode": "Watch3,3",
        "simulator": true,
        "modelCodename": "Apple Watch Series 3 - 38mm",
        "osVersion": "4.3",
        "deviceType": "com.apple.iphone-simulator",
        "modelName": "Apple Watch Series 3 - 38mm",
        "identifier": "41122173-40A1-452C-B1B3-6ABC84854C9E",
        "supported": true,
        "architecture": "i386",
        "enabledForDevelopment": true,
        "isServer": false,
        "doc_type": "device",
        "trusted": true,
        "platformIdentifier": "com.apple.platform.watchsimulator",
        "name": "Apple Watch Series 3 - 38mm",
        "retina": false
      },
      "connected": true,
      "simulator": true,
      "modelCode": "iPhone10,4",
      "deviceType": "com.apple.iphone-simulator",
      "modelName": "iPhone 8",
      "revision": "2196-5fca2b6dc1ae3797a8f3ccda9d4014af",
      "modelUTI": "com.apple.iphone-8-2",
      "modelCodename": "iPhone 8",
      "name": "iPhone 8",
      "trusted": true,
      "doc_type": "device",
      "supported": true,
      "identifier": "D220C376-D62F-4F6E-96AF-A2E1787489BE",
      "wireless": false,
      "enabledForDevelopment": true,
      "platformIdentifier": "com.apple.platform.iphonesimulator",
      "ID": "2478c325aea64ed6e16f38ed6e00b0e7",
      "architecture": "x86_64",
      "retina": false,
      "isServer": false,
      "tinyID": "DC06CB2"
    },
    {
      "osVersion": "12.2",
      "activeProxiedDevice": {
        "modelUTI": "com.apple.watch-series4-1",
        "connected": true,
        "wireless": false,
        "modelCode": "Watch4,3",
        "simulator": true,
        "modelCodename": "Apple Watch Series 4 - 40mm",
        "osVersion": "5.2",
        "deviceType": "com.apple.iphone-simulator",
        "modelName": "Apple Watch Series 4 - 40mm",
        "identifier": "BD32C612-F34B-4BC5-83E3-985956F94889",
        "supported": true,
        "architecture": "i386",
        "enabledForDevelopment": true,
        "isServer": false,
        "doc_type": "device",
        "trusted": true,
        "platformIdentifier": "com.apple.platform.watchsimulator",
        "name": "Apple Watch Series 4 - 40mm",
        "retina": false
      },
      "connected": true,
      "simulator": true,
      "modelCode": "iPhone11,2",
      "deviceType": "com.apple.iphone-simulator",
      "modelName": "iPhone Xs",
      "revision": "1079-9b8a6be206b2bd64d1ddcd499fff10c6",
      "modelUTI": "com.apple.iphone-xs-1",
      "modelCodename": "iPhone Xs",
      "name": "iPhone Xs",
      "trusted": true,
      "doc_type": "device",
      "supported": true,
      "identifier": "71DAF270-DFB1-4847-A80C-8B621E0E329C",
      "wireless": false,
      "enabledForDevelopment": true,
      "platformIdentifier": "com.apple.platform.iphonesimulator",
      "ID": "1e2435b8f14b4299696f6c51de00649d",
      "architecture": "x86_64",
      "retina": false,
      "isServer": false,
      "tinyID": "8F4FE1A"
    },
    {
      "osVersion": "12.2",
      "connected": true,
      "simulator": true,
      "modelCode": "iPhone8,4",
      "deviceType": "com.apple.iphone-simulator",
      "modelName": "iPhone SE",
      "revision": "6-fed7874727bf0b4479c79c31154571e1",
      "modelUTI": "com.apple.iphone-se-a1662-aeb1b8",
      "modelCodename": "iPhone SE",
      "name": "iPhone SE",
      "trusted": true,
      "doc_type": "device",
      "supported": true,
      "identifier": "CB8A0CB2-EF95-4853-A193-200A3C26CF42",
      "wireless": false,
      "enabledForDevelopment": true,
      "platformIdentifier": "com.apple.platform.iphonesimulator",
      "ID": "2478c325aea64ed6e16f38ed6e009319",
      "architecture": "x86_64",
      "retina": false,
      "isServer": false,
      "tinyID": "2AE8E3C"
    }
  ],
  "testHierarchy": {},
  "perfMetricNames": [],
  "perfMetricKeyPaths": []
}
"""
