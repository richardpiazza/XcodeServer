import Foundation

let botsJson: String = """
{
  "count": 7,
  "results": [
    {
      "_id": "705d82e27dbb120dddc09af79100116b",
      "_rev": "53-c91b13095876e9dc3589007a44bed648",
      "group": {
        "name": "C9E8D88B-E1F5-461D-97BE-A624EC4BCBDE"
      },
      "configuration": {
        "triggers": [
          {
            "phase": 1,
            "scriptBody": "#!/bin/bash\\n\\nPROJECT_NAME=\\"Dynumite\\"\\nGIT_USER_NAME=\\"Xcode Server\\"\\nGIT_USER_EMAIL=\\"xcodeserver@richardpiazza.com\\"\\n\\necho \\"Checking Git Global Configuration\\"\\nUSERNAME=`git config --global --get user.name`\\nUSEREMAIL=`git config --global --get user.email`\\n\\nif [ -z \\"$USERNAME\\" ];\\nthen\\necho \\"Setting Git Global user.name\\"\\n`git config --global user.name \\"$GIT_USER_NAME\\"`\\nelse\\necho \\"Git Global user.name: $USERNAME\\"\\nfi\\n\\nif [ -z \\"$USEREMAIL\\" ];\\nthen\\necho \\"Setting Git Global user.email\\"\\n`git config --global user.email \\"$GIT_USER_EMAIL\\"`\\nelse\\necho \\"Git Global user.email: $USEREMAIL\\"\\nfi\\n",
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
            "scriptBody": "#!/bin/bash\\n\\nPROJECT_NAME=\\"Dynumite\\"\\nPROJECT_PLATFORM=\\"macOS\\"\\n\\necho \\"Tagging Repository\\"\\n\\nif [ -n \\"$XCS_INTEGRATION_NUMBER\\" ];\\nthen\\necho \\"Source Directory: $XCS_SOURCE_DIR\\"\\necho \\"Project Directory: $PROJECT_NAME\\"\\necho \\"Integration: $XCS_INTEGRATION_NUMBER\\"\\nTAG=\\"$PROJECT_PLATFORM-$XCS_INTEGRATION_NUMBER\\"\\nGITSOURCE=\\"$XCS_SOURCE_DIR/$PROJECT_NAME\\"\\n`git -C \\"$GITSOURCE\\" tag -a \\"$TAG\\" -m \\"$PROJECT_PLATFORM Build $XCS_INTEGRATION_NUMBER\\"`\\n`git -C \\"$GITSOURCE\\" push origin tag \\"$TAG\\"`;\\nelse\\necho \\"No XCS Integration Number\\";\\nfi\\n",
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
    {
      "_id": "7165830f996e973601a81f0b2897b844",
      "_rev": "80-2f7c6eff684551f63e664b3a843c9745",
      "group": {
        "name": "8DE6BE03-BC3F-4654-8A74-4D0C7F58D2A2"
      },
      "configuration": {
        "triggers": [],
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
                "_id": "bba9b6ff6d6f0899a63d1e347e0035bd",
                "displayName": "tvOS",
                "_rev": "59-da6dc40a65151d597f467f5833e7e9ae",
                "simulatorIdentifier": "com.apple.platform.appletvsimulator",
                "identifier": "com.apple.platform.appletvos",
                "buildNumber": "14T328",
                "version": "10.0"
              },
              "filterType": 2,
              "architectureType": 0
            }
          ],
          "deviceIdentifiers": []
        },
        "buildEnvironmentVariables": {},
        "schemeName": "Pocket Bot tvOS",
        "additionalBuildArguments": [],
        "codeCoveragePreference": 2,
        "performsTestAction": false,
        "scheduleType": 3,
        "useParallelDeviceTesting": true,
        "performsArchiveAction": true,
        "builtFromClean": 3,
        "performsAnalyzeAction": true,
        "exportsProductFromArchive": true,
        "runOnlyDisabledTests": false,
        "minutesAfterHourToIntegrate": 0,
        "weeklyScheduleDay": 0,
        "testingDestinationType": 0,
        "hourOfIntegration": 0,
        "sourceControlBlueprint": {
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey": {
            "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey": "DVTSourceControlAuthenticationStrategy"
            }
          },
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "ssh://bitbucket.org/richardpiazza/com.richardpiazza.pocketbot.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "6D9FFC92170BF5EE19CA25700175BFFFBA40751A"
            }
          ],
          "DVTSourceControlWorkspaceBlueprintLocationsKey": {
            "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": {
              "DVTSourceControlBranchIdentifierKey": "develop",
              "DVTSourceControlBranchOptionsKey": 4,
              "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
            }
          },
          "DVTSourceControlWorkspaceBlueprintWorkingCopyRepositoryLocationsKey": {},
          "DVTSourceControlWorkspaceBlueprintVersion": 205,
          "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Pocket Bot.xcodeproj",
          "DVTSourceControlWorkspaceBlueprintIdentifierKey": "8039AE4F-CDE6-4D1D-B4E2-C19ECB4441D3",
          "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/tsolomko/BitByteData.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "F37C1DCCC130D51D8E1259D0AF0ADE5ED2A05653"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/CodeQuickKit.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "3CBDEDAE95CE25E53B615AC684AAEE3F90A98DFE"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.coordinatedmvc.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "1349BE41A9109ACE33A1171255B735C79CD55ABB"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/GraphPoint.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "A1F5D049FD4665DE5191D03CED810C575819E7F6"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/kishikawakatsumi/KeychainAccess",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "AFADF01AFBA46DFD7A5AFD980110E89E8E63AACD"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/ProcedureKit/ProcedureKit",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "3A999A0044F026F7ADF66A6D83E1CB8EDCDF46AF"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/SessionPlus.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "26A9143C2D27DF35FA861D3CD39E30C6024AB28B"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/XcodeServer.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "E52D14185CC53451EAD5F8C6AAF1C74E0581D237"
            }
          ],
          "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey": {
            "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": 0
          },
          "DVTSourceControlWorkspaceBlueprintNameKey": "Pocket Bot",
          "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
            "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": "PocketBot/"
          },
          "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "6D9FFC92170BF5EE19CA25700175BFFFBA40751A"
        }
      },
      "requiresUpgrade": false,
      "name": "Pocket Bot tvOS",
      "type": 1,
      "sourceControlBlueprintIdentifier": "6B17D6EC-7502-4689-B3DF-FC654D3D38E0",
      "integration_counter": 39,
      "doc_type": "bot",
      "tinyID": "3288641",
      "lastRevisionBlueprint": {
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
        "DVTSourceControlWorkspaceBlueprintLocationsKey": {
          "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": {
            "DVTSourceControlBranchIdentifierKey": "develop",
            "DVTSourceControlLocationRevisionKey": "9b70549acd8ed905bb5923f0e0588c33d273cfda",
            "DVTSourceControlBranchOptionsKey": 4,
            "DVTSourceControlBranchRemoteNameKey": "origin",
            "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
          }
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "6D9FFC92170BF5EE19CA25700175BFFFBA40751A",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey": "1EE91EBB-C388-4381-BCCC-8AC517397029",
        "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
          "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": "PocketBot/"
        },
        "DVTSourceControlWorkspaceBlueprintNameKey": "Pocket Bot",
        "DVTSourceControlWorkspaceBlueprintVersion": 205,
        "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Pocket Bot.xcodeproj",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
          {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "ssh://bitbucket.org/richardpiazza/com.richardpiazza.pocketbot.git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "6D9FFC92170BF5EE19CA25700175BFFFBA40751A"
          }
        ]
      }
    },
    {
      "_id": "af6b157df3d9eafd03c8d2695a000cec",
      "_rev": "43-6cb24bf6ed8167ad01cece1bdee64b28",
      "group": {
        "name": "34B8B598-579F-4AA1-B2DD-F48F38253F64"
      },
      "configuration": {
        "triggers": [
          {
            "phase": 1,
            "scriptBody": "#!/bin/bash\\n\\nGIT_USER_NAME=\\"Xcode Server\\"\\nGIT_USER_EMAIL=\\"xcodeserver@richardpiazza.com\\"\\n\\necho \\"Checking Git Global Configuration\\"\\nUSERNAME=`git config --global --get user.name`\\nUSEREMAIL=`git config --global --get user.email`\\n\\nif [ -z \\"$USERNAME\\" ];\\nthen\\necho \\"Setting Git Global user.name\\"\\n`git config --global user.name \\"$GIT_USER_NAME\\"`\\nelse\\necho \\"Git Global user.name: $USERNAME\\"\\nfi\\n\\nif [ -z \\"$USEREMAIL\\" ];\\nthen\\necho \\"Setting Git Global user.email\\"\\n`git config --global user.email \\"$GIT_USER_EMAIL\\"`\\nelse\\necho \\"Git Global user.email: $USEREMAIL\\"\\nfi\\n",
            "type": 1,
            "name": "GIT Setup",
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
            "scriptBody": "#!/bin/bash\\n\\nPROJECT_NAME=\\"Mindset\\"\\nPROJECT_PLATFORM=\\"iOS\\"\\n\\necho \\"Tagging Repository\\"\\n\\nif [ -n \\"$XCS_INTEGRATION_NUMBER\\" ];\\nthen\\necho \\"Source Directory: $XCS_SOURCE_DIR\\"\\necho \\"Project Directory: $PROJECT_NAME\\"\\necho \\"Integration: $XCS_INTEGRATION_NUMBER\\"\\nTAG=\\"$PROJECT_PLATFORM-$XCS_INTEGRATION_NUMBER\\"\\nGITSOURCE=\\"$XCS_SOURCE_DIR/$PROJECT_NAME\\"\\n`git -C \\"$GITSOURCE\\" tag -a \\"$TAG\\" -m \\"$PROJECT_PLATFORM Build $XCS_INTEGRATION_NUMBER\\"`\\n`git -C \\"$GITSOURCE\\" push origin tag \\"$TAG\\"`;\\nelse\\necho \\"No XCS Integration Number\\";\\nfi\\n",
            "type": 1,
            "name": "Tag Repository",
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
        "hourOfIntegration": 0,
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
                "_id": "9630e858952ff70121601479aa0018e8",
                "displayName": "iOS",
                "_rev": "136-2caf05a522a81eae92c02b77d532c1fd",
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
            "a4ff07a438b65b4d93a49914e6007a64",
            "2478c325aea64ed6e16f38ed6e00ba4a",
            "2478c325aea64ed6e16f38ed6e00b0e7",
            "69561babb98bc6d688806fc96e00147d",
            "a4ff07a438b65b4d93a49914e6007e9c",
            "a4ff07a438b65b4d93a49914e600742d",
            "a4ff07a438b65b4d93a49914e60084f6",
            "69561babb98bc6d688806fc96e00246a"
          ]
        },
        "buildEnvironmentVariables": {},
        "schemeName": "Mindset",
        "additionalBuildArguments": [],
        "codeCoveragePreference": 2,
        "performsTestAction": true,
        "scheduleType": 3,
        "useParallelDeviceTesting": false,
        "performsArchiveAction": true,
        "builtFromClean": 1,
        "performsAnalyzeAction": true,
        "exportsProductFromArchive": true,
        "weeklyScheduleDay": 0,
        "runOnlyDisabledTests": false,
        "testingDestinationType": 0,
        "minutesAfterHourToIntegrate": 0,
        "testLocalizations": [],
        "sourceControlBlueprint": {
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey": {
            "0518FB9511F40D87A1F3126452C97A85BA615DD7": {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey": "DVTSourceControlAuthenticationStrategy"
            }
          },
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.mindset.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "0518FB9511F40D87A1F3126452C97A85BA615DD7"
            }
          ],
          "DVTSourceControlWorkspaceBlueprintLocationsKey": {
            "0518FB9511F40D87A1F3126452C97A85BA615DD7": {
              "DVTSourceControlBranchIdentifierKey": "master",
              "DVTSourceControlBranchOptionsKey": 4,
              "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
            }
          },
          "DVTSourceControlWorkspaceBlueprintWorkingCopyRepositoryLocationsKey": {},
          "DVTSourceControlWorkspaceBlueprintVersion": 205,
          "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Mindset.xcodeproj",
          "DVTSourceControlWorkspaceBlueprintIdentifierKey": "C2D8E9C5-A7C8-4FA0-A253-5BE0C36976B3",
          "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
          "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey": {
            "0518FB9511F40D87A1F3126452C97A85BA615DD7": 0
          },
          "DVTSourceControlWorkspaceBlueprintNameKey": "Mindset",
          "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
            "0518FB9511F40D87A1F3126452C97A85BA615DD7": "Mindset/"
          },
          "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "0518FB9511F40D87A1F3126452C97A85BA615DD7"
        }
      },
      "requiresUpgrade": false,
      "name": "Mindset iOS",
      "type": 1,
      "sourceControlBlueprintIdentifier": "E79FB8BC-E7D1-4D8A-B261-A1E3AAC247FB",
      "integration_counter": 19,
      "doc_type": "bot",
      "tinyID": "0FF58A4",
      "lastRevisionBlueprint": {
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
        "DVTSourceControlWorkspaceBlueprintLocationsKey": {
          "0518FB9511F40D87A1F3126452C97A85BA615DD7": {
            "DVTSourceControlBranchIdentifierKey": "master",
            "DVTSourceControlLocationRevisionKey": "68ee4929f19607e4a22a2a347f8a4ac7a222cdac",
            "DVTSourceControlBranchOptionsKey": 4,
            "DVTSourceControlBranchRemoteNameKey": "origin",
            "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
          }
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "0518FB9511F40D87A1F3126452C97A85BA615DD7",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey": "CAEF3835-2D22-427A-BDD3-8DC7E7E1A383",
        "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
          "0518FB9511F40D87A1F3126452C97A85BA615DD7": "Mindset/"
        },
        "DVTSourceControlWorkspaceBlueprintNameKey": "Mindset",
        "DVTSourceControlWorkspaceBlueprintVersion": 205,
        "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Mindset.xcodeproj",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
          {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.mindset.git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "0518FB9511F40D87A1F3126452C97A85BA615DD7"
          }
        ]
      }
    },
    {
      "_id": "bba9b6ff6d6f0899a63d1e347e00ff15",
      "_rev": "138-8c5451d38bb2c68eb6d5b9312a7d8d72",
      "group": {
        "name": "14BC8B8F-9938-4F26-A3D7-CFCEC6904973"
      },
      "configuration": {
        "triggers": [
          {
            "phase": 2,
            "scriptBody": "",
            "emailConfiguration": {
              "ccAddresses": [],
              "allowedDomainNames": [],
              "includeCommitMessages": true,
              "includeLogs": true,
              "replyToAddress": "",
              "includeIssueDetails": true,
              "includeBotConfiguration": true,
              "additionalRecipients": [],
              "scmOptions": {
                "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": 1
              },
              "emailCommitters": true,
              "fromAddress": "",
              "type": 3,
              "includeResolvedIssues": true,
              "weeklyScheduleDay": 7,
              "minutesAfterHour": 0,
              "hour": 10
            },
            "type": 2,
            "name": "New Issue Email",
            "conditions": {
              "status": 2,
              "onAllIssuesResolved": true,
              "onWarnings": true,
              "onBuildErrors": true,
              "onAnalyzerWarnings": true,
              "onFailingTests": true,
              "onSuccess": false
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
                "_id": "bba9b6ff6d6f0899a63d1e347e0043d2",
                "displayName": "iOS",
                "_rev": "4-c7830a565f0b66988399cb66f53043a5",
                "simulatorIdentifier": "com.apple.platform.iphonesimulator",
                "identifier": "com.apple.platform.iphoneos",
                "buildNumber": "13E230",
                "version": "9.3"
              },
              "filterType": 2,
              "architectureType": 0
            }
          ],
          "deviceIdentifiers": []
        },
        "buildEnvironmentVariables": {},
        "schemeName": "Pocket Bot",
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
        "testingDestinationType": 0,
        "hourOfIntegration": 0,
        "sourceControlBlueprint": {
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey": {
            "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey": "DVTSourceControlAuthenticationStrategy"
            }
          },
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "ssh://bitbucket.org/richardpiazza/com.richardpiazza.pocketbot.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "6D9FFC92170BF5EE19CA25700175BFFFBA40751A"
            }
          ],
          "DVTSourceControlWorkspaceBlueprintLocationsKey": {
            "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": {
              "DVTSourceControlBranchIdentifierKey": "develop",
              "DVTSourceControlBranchOptionsKey": 4,
              "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
            }
          },
          "DVTSourceControlWorkspaceBlueprintWorkingCopyRepositoryLocationsKey": {},
          "DVTSourceControlWorkspaceBlueprintVersion": 205,
          "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Pocket Bot.xcodeproj",
          "DVTSourceControlWorkspaceBlueprintIdentifierKey": "04F1F186-F8AD-4144-8C84-E826D4498BC0",
          "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/tsolomko/BitByteData.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey": "1627ACA576282D36631B564DEBDFA648",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "F37C1DCCC130D51D8E1259D0AF0ADE5ED2A05653",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustSelfSignedCertKey": true
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/CodeQuickKit.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey": "1627ACA576282D36631B564DEBDFA648",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "3CBDEDAE95CE25E53B615AC684AAEE3F90A98DFE",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustSelfSignedCertKey": true
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.richardpiazza.coordinatedmvc.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "1349BE41A9109ACE33A1171255B735C79CD55ABB"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/GraphPoint.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey": "1627ACA576282D36631B564DEBDFA648",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "A1F5D049FD4665DE5191D03CED810C575819E7F6",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustSelfSignedCertKey": true
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/kishikawakatsumi/KeychainAccess",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey": "1627ACA576282D36631B564DEBDFA648",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "AFADF01AFBA46DFD7A5AFD980110E89E8E63AACD",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustSelfSignedCertKey": true
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/ProcedureKit/ProcedureKit",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey": "1627ACA576282D36631B564DEBDFA648",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "3A999A0044F026F7ADF66A6D83E1CB8EDCDF46AF",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustSelfSignedCertKey": true
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/SessionPlus.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey": "1627ACA576282D36631B564DEBDFA648",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "26A9143C2D27DF35FA861D3CD39E30C6024AB28B",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustSelfSignedCertKey": true
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/XcodeServer.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey": "1627ACA576282D36631B564DEBDFA648",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "E52D14185CC53451EAD5F8C6AAF1C74E0581D237",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustSelfSignedCertKey": true
            }
          ],
          "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey": {
            "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": 0
          },
          "DVTSourceControlWorkspaceBlueprintNameKey": "Pocket Bot",
          "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
            "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": "PocketBot/"
          },
          "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "6D9FFC92170BF5EE19CA25700175BFFFBA40751A"
        }
      },
      "requiresUpgrade": false,
      "name": "Pocket Bot iOS",
      "type": 1,
      "sourceControlBlueprintIdentifier": "9D0F4D8D-D6D1-49D6-9479-3D6712944D45",
      "integration_counter": 156,
      "doc_type": "bot",
      "tinyID": "BF0FE36",
      "lastRevisionBlueprint": {
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
        "DVTSourceControlWorkspaceBlueprintLocationsKey": {
          "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": {
            "DVTSourceControlBranchIdentifierKey": "develop",
            "DVTSourceControlLocationRevisionKey": "e678aec82560ca8b1443655d5c464619aa049a38",
            "DVTSourceControlBranchOptionsKey": 4,
            "DVTSourceControlBranchRemoteNameKey": "origin",
            "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
          }
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "6D9FFC92170BF5EE19CA25700175BFFFBA40751A",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey": "40A7576F-F40C-4BEE-AE7F-B3D5F2FE5BF3",
        "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
          "6D9FFC92170BF5EE19CA25700175BFFFBA40751A": "PocketBot/"
        },
        "DVTSourceControlWorkspaceBlueprintNameKey": "Pocket Bot",
        "DVTSourceControlWorkspaceBlueprintVersion": 205,
        "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Pocket Bot.xcodeproj",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
          {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "ssh://bitbucket.org/richardpiazza/com.richardpiazza.pocketbot.git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "6D9FFC92170BF5EE19CA25700175BFFFBA40751A"
          }
        ]
      }
    },
    {
      "_id": "bba9b6ff6d6f0899a63d1e347e040bb4",
      "_rev": "214-7e5d7a48de5d66f5f81be8e26875b5f5",
      "group": {
        "name": "039222D2-0C7B-40F4-AF57-BC40DA5B39B2"
      },
      "configuration": {
        "triggers": [],
        "testingDeviceIDs": [],
        "performsUpgradeIntegration": false,
        "disableAppThinning": true,
        "provisioningConfiguration": {
          "addMissingDevicesToTeams": true,
          "manageCertsAndProfiles": true
        },
        "periodicScheduleInterval": 0,
        "deviceSpecification": {
          "filters": [
            {
              "platform": {
                "_id": "bba9b6ff6d6f0899a63d1e347e0043d2",
                "displayName": "iOS",
                "_rev": "4-c7830a565f0b66988399cb66f53043a5",
                "simulatorIdentifier": "com.apple.platform.iphonesimulator",
                "identifier": "com.apple.platform.iphoneos",
                "buildNumber": "13E230",
                "version": "9.3"
              },
              "filterType": 2,
              "architectureType": 0
            }
          ],
          "deviceIdentifiers": []
        },
        "buildEnvironmentVariables": {},
        "schemeName": "Bakeshop",
        "additionalBuildArguments": [],
        "codeCoveragePreference": 2,
        "performsTestAction": true,
        "scheduleType": 3,
        "useParallelDeviceTesting": false,
        "performsArchiveAction": true,
        "archiveExportOptions": {
          "name": "ExportOptions.plist",
          "createdAt": "2020-06-23T23:04:39.066Z",
          "exportOptions": {
            "iCloudContainerEnvironment": "Production"
          }
        },
        "builtFromClean": 1,
        "performsAnalyzeAction": true,
        "exportsProductFromArchive": true,
        "runOnlyDisabledTests": false,
        "minutesAfterHourToIntegrate": 0,
        "testingDestinationType": 0,
        "weeklyScheduleDay": 0,
        "hourOfIntegration": 0,
        "sourceControlBlueprint": {
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey": {
            "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF": {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey": "DVTSourceControlAuthenticationStrategy"
            }
          },
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "github.com:richardpiazza/Bakeshop.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey": "1627ACA576282D36631B564DEBDFA648",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git"
            }
          ],
          "DVTSourceControlWorkspaceBlueprintLocationsKey": {
            "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF": {
              "DVTSourceControlBranchIdentifierKey": "develop",
              "DVTSourceControlBranchOptionsKey": 4,
              "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
            }
          },
          "DVTSourceControlWorkspaceBlueprintWorkingCopyRepositoryLocationsKey": {},
          "DVTSourceControlWorkspaceBlueprintVersion": 205,
          "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Bakeshop.xcodeproj",
          "DVTSourceControlWorkspaceBlueprintIdentifierKey": "B1A2417E-B53D-493E-8830-D756DF3347F4",
          "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/CodeQuickKit",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "3CBDEDAE95CE25E53B615AC684AAEE3F90A98DFE"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/MiseEnPlace",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "E72555C40C59CF258F530ADBA0314A60534D9864"
            },
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey": true,
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "https://github.com/richardpiazza/ProcedureKit/",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "3A999A0044F026F7ADF66A6D83E1CB8EDCDF46AF"
            }
          ],
          "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey": {
            "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF": 0
          },
          "DVTSourceControlWorkspaceBlueprintNameKey": "Bakeshop",
          "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
            "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF": "Bakeshop/"
          },
          "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF"
        }
      },
      "requiresUpgrade": false,
      "name": "Bakeshop iOS",
      "type": 1,
      "sourceControlBlueprintIdentifier": "9FFA6BCF-20B2-4FA5-809C-62A6FB948977",
      "integration_counter": 169,
      "doc_type": "bot",
      "tinyID": "5B52DA8",
      "lastRevisionBlueprint": {
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
        "DVTSourceControlWorkspaceBlueprintLocationsKey": {
          "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF": {
            "DVTSourceControlBranchIdentifierKey": "develop",
            "DVTSourceControlLocationRevisionKey": "6326065e4e681e7ece55a872b7328b88061cc8ee",
            "DVTSourceControlBranchOptionsKey": 4,
            "DVTSourceControlBranchRemoteNameKey": "origin",
            "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
          }
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey": "A98EC2A4-F9D7-4053-8ECE-34BEBE0ED066",
        "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
          "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF": "Bakeshop/"
        },
        "DVTSourceControlWorkspaceBlueprintNameKey": "Bakeshop",
        "DVTSourceControlWorkspaceBlueprintVersion": 205,
        "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Bakeshop.xcodeproj",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
          {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "github.com:richardpiazza/Bakeshop.git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "6139C8319FDE4527BFD4EA6334BA1CE5BC0DE9DF"
          }
        ]
      }
    },
    {
      "_id": "c50a58f76e7104f98942443df600c26c",
      "_rev": "50-79944d9b2668e7ab53b7543640d62a01",
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
        "hourOfIntegration": 0,
        "performsUpgradeIntegration": false,
        "disableAppThinning": false,
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
        "builtFromClean": 3,
        "performsAnalyzeAction": true,
        "exportsProductFromArchive": true,
        "weeklyScheduleDay": 0,
        "runOnlyDisabledTests": false,
        "testingDestinationType": 0,
        "minutesAfterHourToIntegrate": 0,
        "testLocalizations": [],
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
          "DVTSourceControlWorkspaceBlueprintIdentifierKey": "16445E2A-3559-46E1-B8F7-D1F037EED0D9",
          "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
          "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey": {
            "F0ECD473CD0A2C01179E1CA74CE111F216666C90": 0
          },
          "DVTSourceControlWorkspaceBlueprintNameKey": "Structured",
          "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
            "F0ECD473CD0A2C01179E1CA74CE111F216666C90": "Structured/"
          },
          "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "F0ECD473CD0A2C01179E1CA74CE111F216666C90"
        }
      },
      "requiresUpgrade": false,
      "name": "Structured iOS",
      "type": 1,
      "sourceControlBlueprintIdentifier": "9C556F71-26F4-464E-A0B3-09EA9950921B",
      "integration_counter": 21,
      "doc_type": "bot",
      "tinyID": "25975A7",
      "lastRevisionBlueprint": {
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
        "DVTSourceControlWorkspaceBlueprintLocationsKey": {
          "F0ECD473CD0A2C01179E1CA74CE111F216666C90": {
            "DVTSourceControlBranchIdentifierKey": "master",
            "DVTSourceControlLocationRevisionKey": "f7cb8ace7d40fa8501c1180b0f061d1707287023",
            "DVTSourceControlBranchOptionsKey": 4,
            "DVTSourceControlBranchRemoteNameKey": "origin",
            "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
          }
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "F0ECD473CD0A2C01179E1CA74CE111F216666C90",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey": "89974684-11D2-4A63-800A-C78B87ED2A35",
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
      }
    },
    {
      "_id": "ffe2a262684f526813c8865982004e72",
      "_rev": "71-dd223741c05a90408b803a551cde4226",
      "group": {
        "name": "CB1DF27D-8AAE-4877-8189-453D091025AE"
      },
      "configuration": {
        "triggers": [
          {
            "phase": 1,
            "scriptBody": "#!/bin/bash\\n\\nGIT_USER_NAME=\\"Xcode Server\\"\\nGIT_USER_EMAIL=\\"xcodeserver@richardpiazza.com\\"\\n\\necho \\"Checking Git Global Configuration\\"\\nUSERNAME=`git config --global --get user.name`\\nUSEREMAIL=`git config --global --get user.email`\\n\\nif [ -z \\"$USERNAME\\" ];\\nthen\\necho \\"Setting Git Global user.name\\"\\n`git config --global user.name \\"$GIT_USER_NAME\\"`\\nelse\\necho \\"Git Global user.name: $USERNAME\\"\\nfi\\n\\nif [ -z \\"$USEREMAIL\\" ];\\nthen\\necho \\"Setting Git Global user.email\\"\\n`git config --global user.email \\"$GIT_USER_EMAIL\\"`\\nelse\\necho \\"Git Global user.email: $USEREMAIL\\"\\nfi\\n",
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
            "scriptBody": "#!/bin/bash\\n\\nPROJECT_NAME=\\"CrazyMonkey\\"\\nPROJECT_PLATFORM=\\"iOS\\"\\n\\necho \\"Tagging Repository\\"\\n\\nif [ -n \\"$XCS_INTEGRATION_NUMBER\\" ];\\nthen\\necho \\"Source Directory: $XCS_SOURCE_DIR\\"\\necho \\"Project Directory: $PROJECT_NAME\\"\\necho \\"Integration: $XCS_INTEGRATION_NUMBER\\"\\nTAG=\\"$PROJECT_PLATFORM-$XCS_INTEGRATION_NUMBER\\"\\nGITSOURCE=\\"$XCS_SOURCE_DIR/$PROJECT_NAME\\"\\n`git -C \\"$GITSOURCE\\" tag -a \\"$TAG\\" -m \\"$PROJECT_PLATFORM Build $XCS_INTEGRATION_NUMBER\\"`\\n`git -C \\"$GITSOURCE\\" push origin tag \\"$TAG\\"`;\\nelse\\necho \\"No XCS Integration Number\\";\\nfi\\n",
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
                "_id": "786d4c9f6ea03b6122926eec6e004dd1",
                "displayName": "iOS",
                "_rev": "80-5361f90ab56ddc4aa8982f0c94a961c6",
                "simulatorIdentifier": "com.apple.platform.iphonesimulator",
                "identifier": "com.apple.platform.iphoneos",
                "buildNumber": "14E269",
                "version": "10.3"
              },
              "filterType": 3,
              "architectureType": 0
            }
          ],
          "deviceIdentifiers": [
            "69561babb98bc6d688806fc96e00147d",
            "2478c325aea64ed6e16f38ed6e009319",
            "2478c325aea64ed6e16f38ed6e00ba4a",
            "1e2435b8f14b4299696f6c51de00649d",
            "2478c325aea64ed6e16f38ed6e00b0e7",
            "1e2435b8f14b4299696f6c51de0053ce",
            "1e2435b8f14b4299696f6c51de00479f",
            "69561babb98bc6d688806fc96e00246a"
          ]
        },
        "buildEnvironmentVariables": {},
        "schemeName": "CrazyMonkeyTwinCitiesiOS",
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
        "weeklyScheduleDay": 0,
        "minutesAfterHourToIntegrate": 0,
        "hourOfIntegration": 0,
        "testingDestinationType": 0,
        "sourceControlBlueprint": {
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey": {
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9": {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey": "DVTSourceControlAuthenticationStrategy"
            }
          },
          "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
            {
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.crazymonkeytwincities.ios.git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
              "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9"
            }
          ],
          "DVTSourceControlWorkspaceBlueprintLocationsKey": {
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9": {
              "DVTSourceControlBranchIdentifierKey": "master",
              "DVTSourceControlBranchOptionsKey": 4,
              "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
            }
          },
          "DVTSourceControlWorkspaceBlueprintWorkingCopyRepositoryLocationsKey": {},
          "DVTSourceControlWorkspaceBlueprintVersion": 205,
          "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Crazy Monkey Twin Cities.xcworkspace",
          "DVTSourceControlWorkspaceBlueprintIdentifierKey": "EE6D0D34-3FF0-4D31-B8CC-0D85AC7DE7DE",
          "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
          "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey": {
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9": 9223372036854776000
          },
          "DVTSourceControlWorkspaceBlueprintNameKey": "Crazy Monkey Twin Cities",
          "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
            "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9": "CrazyMonkey/"
          },
          "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9"
        }
      },
      "requiresUpgrade": false,
      "name": "Crazy Monkey iOS",
      "type": 1,
      "sourceControlBlueprintIdentifier": "23D21139-0210-4344-9C27-3D84C4ED0693",
      "integration_counter": 33,
      "doc_type": "bot",
      "tinyID": "678C5C6",
      "lastRevisionBlueprint": {
        "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey": [],
        "DVTSourceControlWorkspaceBlueprintLocationsKey": {
          "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9": {
            "DVTSourceControlBranchIdentifierKey": "master",
            "DVTSourceControlLocationRevisionKey": "e44d90bbb58001647dc6536124755ccdd2ea15ef",
            "DVTSourceControlBranchOptionsKey": 4,
            "DVTSourceControlBranchRemoteNameKey": "origin",
            "DVTSourceControlWorkspaceBlueprintLocationTypeKey": "DVTSourceControlBranch"
          }
        },
        "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey": "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9",
        "DVTSourceControlWorkspaceBlueprintIdentifierKey": "C5EAAB03-C492-4EDF-BE1E-A372F98A2F39",
        "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey": {
          "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9": "CrazyMonkey/"
        },
        "DVTSourceControlWorkspaceBlueprintNameKey": "Crazy Monkey Twin Cities",
        "DVTSourceControlWorkspaceBlueprintVersion": 205,
        "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey": "Crazy Monkey Twin Cities.xcworkspace",
        "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey": [
          {
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey": "bitbucket.org:richardpiazza/com.crazymonkeytwincities.ios.git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey": "com.apple.dt.Xcode.sourcecontrol.Git",
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey": "3B5CFDF38F1AD11BC1804F5A657156F5835DCED9"
          }
        ]
      }
    }
  ]
}
"""
