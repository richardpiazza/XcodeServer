#  Tips & Tricks

## Xcode Server

### API URL

`https://{hostname}:20343/api`

### Root Certificate

`/Library/Developer/XcodeServer/Certificates/xcsd.crt`
 
### CouchDB

Web Interface: `http://localhost:10355/_utils/`

Configuration: `/Library/Developer/XcodeServer/Configuration/xcscouch.ini`

* Under the [admins] section is a username=password list.
* The default username for the Xcode Server CouchDB instance is **xcscouchadmin**
* The password is located in the file: `/Library/Developer/XcodeServer/SharedSecrets/XCSDCouchDBSecret`

### XCS Resources (js/etc)

`/Application/Xcode.app/Contents/Developer/usr/share/xcs`

## Core Data

### Compile Core Data Model to `.momd`

```bash
/Applications/Xcode.app/Contents/Developer/usr/bin/momc {Source.xcdatamodeld} {Destination.momd}
```

## Simulator

### Send URL to Simulator

```bash
xcrun simctl openurl booted "{urlscheme}://{url_encoded_variables}"
```

## Swift

### Swift Build/Test with specific Target

```bash
swift test -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"
```

## Disk Space

_Run these commands under your user account and the ‘xcodeserver’ account._

### Removing old/unavailable simulators

```bash
sudo xcrun simctl delete unavailable
```

### Remove Old Device Support

```bash
~/Library/Developer/Xcode/*OS DeviceSupport
```

### Remove Xcode SDK downloads

```bash
~/Library/Caches/com.apple.dt.Xcode/Downloads
```

### Remove CoreSimulator Runtimes

```bash
/Library/Developer/CoreSimulator/Profiles/Runtimes
```
