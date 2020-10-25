import Foundation

let integrationJson: String = """
{
  "_id": "2ce4a2fd2f57d53039edddc51e0009cf",
  "_rev": "12-d029c673378d46d4fcdd7fddd21364b8",
  "bot": {
    "_id": "705d82e27dbb120dddc09af79100116b",
    "_rev": "53-c91b13095876e9dc3589007a44bed648",
    "group": {
      "name": "C9E8D88B-E1F5-461D-97BE-A624EC4BCBDE"
    },
    "configuration": {
      "triggers": [
        {
          "phase": 1,
          "scriptBody": "#!/bin/bash\n\nPROJECT_NAME=\"Dynumite\"\nGIT_USER_NAME=\"Xcode Server\"\nGIT_USER_EMAIL=\"xcodeserver@richardpiazza.com\"\n\necho \"Checking Git Global Configuration\"\nUSERNAME=`git config --global --get user.name`\nUSEREMAIL=`git config --global --get user.email`\n\nif [ -z \"$USERNAME\" ];\nthen\necho \"Setting Git Global user.name\"\n`git config --global user.name \"$GIT_USER_NAME\"`\nelse\necho \"Git Global user.name: $USERNAME\"\nfi\n\nif [ -z \"$USEREMAIL\" ];\nthen\necho \"Setting Git Global user.email\"\n`git config --global user.email \"$GIT_USER_EMAIL\"`\nelse\necho \"Git Global user.email: $USEREMAIL\"\nfi\n",
          "type": 1,
          "name": "GIT Configuration",
          "conditions": {
            "status": 2,
            "onAllIssuesResolved": false,
            "onWarnings": true,
            "onBuildErrors": true,
            "onAnalyzerWarnings": true,
            "onFailingTests": true,
            "onSuccess": true
          }
        },
        {
          "phase": 1,
          "scriptBody": "#!/bin/bash\n\nPROJECT_NAME=\"Dynumite\"\nPROJECT_PLATFORM=\"macOS\"\n\necho \"Tagging Repository\"\n\nif [ -n \"$XCS_INTEGRATION_NUMBER\" ];\nthen\necho \"Source Directory: $XCS_SOURCE_DIR\"\necho \"Project Directory: $PROJECT_NAME\"\necho \"Integration: $XCS_INTEGRATION_NUMBER\"\nTAG=\"$PROJECT_PLATFORM-$XCS_INTEGRATION_NUMBER\"\nGITSOURCE=\"$XCS_SOURCE_DIR/$PROJECT_NAME\"\n`git -C \"$GITSOURCE\" tag -a \"$TAG\" -m \"$PROJECT_PLATFORM Build $XCS_INTEGRATION_NUMBER\"`\n`git -C \"$GITSOURCE\" push origin tag \"$TAG\"`;\nelse\necho \"No XCS Integration Number\";\nfi\n",
          "type": 1,
          "name": "Tag Repository",
          "conditions": {
            "status": 2,
            "onAllIssuesResolved": false,
            "onWarnings": true,
            "onBuildErrors": true,
            "onAnalyzerWarnings": true,
            "onFailingTests": true,
            "onSuccess": true
          }
        }
      ],
      "testingDeviceIDs": [],
      "performsUpgradeIntegration": false,
      "disableAppThinning": false,
      "provisioningConfiguration": {
        "addMissingDevicesToTeams": true,
        "manageCertsAndProfiles": true
      },
      "periodicScheduleInterval": 0,
      "deviceSpecification": {
        "filters": [
          {
            "platform": {
              "buildNumber": "16C58",
              "_id": "bba9b6ff6d6f0899a63d1e347e002e75",
              "_rev": "76-781e55904aad9fb279290bdc07343362",
              "displayName": "macOS",
              "identifier": "com.apple.platform.macosx",
              "version": "1.1"
            },
            "filterType": 0,
            "architectureType": 1
          }
        ],
        "deviceIdentifiers": []
      },
      "buildEnvironmentVariables": {},
      "schemeName": "Dynumite",
      "additionalBuildArguments": [],
      "codeCoveragePreference": 2,
      "performsTestAction": true,
      "scheduleType": 3,
      "useParallelDeviceTesting": false,
      "performsArchiveAction": true,
      "builtFromClean": 3,
      "performsAnalyzeAction": true,
      "exportsProductFromArchive": true,
      "runOnlyDisabledTests": false,
      "minutesAfterHourToIntegrate": 0,
      "weeklyScheduleDay": 0,
      "testingDestinationType": 7,
      "hourOfIntegration": 0,
      "sourceControlBlueprint": {
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey": {
          "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71": {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey": "DVTSourceControlAuthenticationStrategy"
          }
        },
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
          {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.dynumite.git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71"
          }
        ],
        "DVTSourceControlWorkspaceBlueprintLocationsKey": {
          "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71": {
            "DVTSourceControlBranchIdentifierKey": "master",
            "DVTSourceControlBranchOptionsKey": 4,
            "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
          }
        },
        "DVTSourceControlWorkspaceBlueprintWorkingCopyRepositoryLocationsKey": {},
        "DVTSourceControlWorkspaceBlueprintVersion": 205,
        "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Dynumite.xcworkspace",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey": "9EEE5B4F-5999-41B3-A760-61B843AB234E",
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
        "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey": {
          "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71": 9223372036854776000
        },
        "DVTSourceControlWorkspaceBlueprintNameKey": "Dynumite",
        "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
          "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71": "Dynumite/"
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71"
      }
    },
    "requiresUpgrade": false,
    "name": "Dynumite macOS",
    "type": 1,
    "sourceControlBlueprintIdentifier": "457B388C-D46F-4EBE-BD63-B7745A5D0A65",
    "integration_counter": 24,
    "doc_type": "bot",
    "tinyID": "F3991C2",
    "lastRevisionBlueprint": {
      "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
      "DVTSourceControlWorkspaceBlueprintLocationsKey": {
        "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71": {
          "DVTSourceControlBranchIdentifierKey": "master",
          "DVTSourceControlLocationRevisionKey": "6c50db852ea47eb1aacc525bb835c19e15bd71fd",
          "DVTSourceControlBranchOptionsKey": 4,
          "DVTSourceControlBranchRemoteNameKey": "origin",
          "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
        }
      },
      "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71",
      "DVTSourceControlWorkspaceBlueprintIdentifierKey": "C5D1606F-6FB4-40C2-97DA-0E32201EABA4",
      "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
        "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71": "Dynumite/"
      },
      "DVTSourceControlWorkspaceBlueprintNameKey": "Dynumite",
      "DVTSourceControlWorkspaceBlueprintVersion": 205,
      "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Dynumite.xcworkspace",
      "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
        {
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.dynumite.git",
          "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71"
        }
      ]
    }
  },
  "number": 24,
  "currentStep": "completed",
  "result": "trigger-error",
  "queuedDate": "2020-07-13T12:27:49.342Z",
  "success_streak": 0,
  "shouldClean": false,
  "doc_type": "integration",
  "tinyID": "27635C3",
  "buildServiceFingerprint": "A3:BD:DE:BE:C9:FE:49:85:F6:93:F5:00:DA:65:55:83:A5:7D:75:E6",
  "tags": [],
  "startedTime": "2020-07-13T12:27:49.925Z",
  "revisionBlueprint": {
    "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
    "DVTSourceControlWorkspaceBlueprintLocationsKey": {
      "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71": {
        "DVTSourceControlBranchIdentifierKey": "master",
        "DVTSourceControlLocationRevisionKey": "6c50db852ea47eb1aacc525bb835c19e15bd71fd",
        "DVTSourceControlBranchOptionsKey": 4,
        "DVTSourceControlBranchRemoteNameKey": "origin",
        "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
      }
    },
    "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71",
    "DVTSourceControlWorkspaceBlueprintIdentifierKey": "40CE01B4-72A6-474A-8A7C-23889CC35254",
    "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
      "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71": "Dynumite/"
    },
    "DVTSourceControlWorkspaceBlueprintNameKey": "Dynumite",
    "DVTSourceControlWorkspaceBlueprintVersion": 205,
    "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Dynumite.xcworkspace",
    "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
      {
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.dynumite.git",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71"
      }
    ]
  },
  "assets": {
    "triggerAssets": [
      {
        "size": 122,
        "fileName": "trigger-before-0.log",
        "allowAnonymousAccess": false,
        "triggerName": "GIT Configuration",
        "relativePath": "705d82e27dbb120dddc09af79100116b-Dynumite macOS/24/trigger-before-0.log"
      },
      {
        "size": 769,
        "fileName": "trigger-before-1.log",
        "allowAnonymousAccess": false,
        "triggerName": "Tag Repository",
        "relativePath": "705d82e27dbb120dddc09af79100116b-Dynumite macOS/24/trigger-before-1.log"
      }
    ],
    "sourceControlLog": {
      "size": 2752,
      "fileName": "sourceControl.log",
      "allowAnonymousAccess": false,
      "relativePath": "705d82e27dbb120dddc09af79100116b-Dynumite macOS/24/sourceControl.log"
    },
    "buildServiceLog": {
      "size": 3610,
      "fileName": "buildService.log",
      "allowAnonymousAccess": false,
      "relativePath": "705d82e27dbb120dddc09af79100116b-Dynumite macOS/24/buildService.log"
    }
  },
  "endedTime": "2020-07-13T12:28:00.066Z",
  "endedTimeDate": [
    2020,
    7,
    13,
    12,
    28,
    0,
    66
  ],
  "duration": 10.141,
  "ccPercentage": 0,
  "ccPercentageDelta": 0
}
"""
