# LocationListing

## Version

1.0

## Build and Runtime Reference
+ Xcode 12.5
+ iOS 13.0
+ Mac OS 11.3 


## Open the Project

`git clone https://github.com/bill0930/LocationListing.git` 

`cd LocationListing && pod install && open LocationListing.xcworkspace` 

## Configuring the Project

<!-- Configuring the Xcode project requires a GoogleMapAPIKey
- Please **contact me** or **check my email** **for the GOOGLE APIKEY**, it should be something like (AIzP**0Nw)
- `Shift` + `Command` + `O`  or `File` -> `Open Quickly` , find `Config.swift`
- Paste the API Key as a string for accessing GoogleMapSDK service 

After pasting the GoogleMap SDK API Key, you could start to try out the app with simulator or building to a real device

```swift
// Config.Swift
//...
case .googleMapSDK:
        return "AIzP********0Nw"
``` -->

## About LocationListing

LocationListing is a Demo project for demostrating of MVVM architecure and the use of Common SDKs.

The requirement is as follows:

- Retrieve list of people from the [API](https://next.json-generator.com/api/json/get/41P1_UhSI) (Cache it)
- Display list of people. 
- Show details when user select an item in the list.
- Add marker on the map based on the provided latitude/longitude in location.
- Display the person name on the marker when it is tapped.

![simulator.gif](Resources/simulator.gif)


## Written in Swift Only

The whole application is written in Swift 5.

## Application Architecture

The architecture I choose is **MVVM** (Model-View-ViewModel), this is a common architecture since it could separate some controller's logics to ViewModel, so as to reduce some coupling structure.

### Folder Strcture


- LocationListing
  - /Config
    - This folder includes APIKEYs and Constants for accessing other services
  - /UI
    - This folder inclues common custom UI components, such as alert, toast etc..
  - /Helpers
    - This folder inclues custom Extensions for convienience. e.g Date+Extension for parsing the datatime format
  - /Modules
    - This folder includes the actual implementation for each modules, right now we have total 4 modules `Root`, `PersonList` `SingleLocationMap` `MultiLocationmap` in this project
  - /Service
    - This folders includes the concerte implementation of `Storage Layer`, `Networking Layer` for API fetching, RealmDB Caching, and storage accessing. Those service could be injected into ViewModel so each module could access differenct service.


- AppDelegate & SceneDeleagte


### Library Used:
```Ruby
  # Podfile
  pod 'SnapKit', '~> 5.0.0'             # AutoLayout
  pod 'Moya', '~> 14.0'                 # Network Layer Abstration 
  pod 'GoogleMaps', '= 4.2.0'           
  pod 'GooglePlaces', '4.2.0'
  pod 'SwiftLint'                       # Code Style Linting
  pod 'SkeletonView', '=1.15.0'         # Loading Animation
  pod 'SDWebImage'                      # Image Fetching and Caching 
  pod 'RealmSwift', '=10.7.4'           # RealmDB Caching the response
  pod 'ObjectMapper', '~> 4.2.0'        # Mapping JSON <-> Object
  pod 'Loaf', '~> 0.7.0'                # Toast notificatin
```


## Unit Tests
Only APIService has been tested.

The below code snippet is testing getting and mapping the response from `DPI.personList` endpoint
```swift
//  LocationListingTests.swift
    func testDAPIGetPersonListAndMapping() {
        let promise = expectation(description: "DPI.getPersonList.mapping")

        sut.dapiService.provider.request(DAPI.personsList) { result in
            switch result {
            case .success(let response):
                if let json = try? response.mapJSON() {
                    if let persons = Mapper<Person>().mapArray(JSONObject: json) {
                        XCTAssertTrue(persons.count > 0, "persons.count == 0")
                        promise.fulfill()
                    } else {
                        XCTFail("🔴Mapper<Person>().mapArray(JSONObject: json) FAIL")
                    }
                } else {
                    XCTFail("🔴response.mapJSON() FAIL")
                }
            case .failure(let error):
                XCTFail("🔴error with \(error)")
            }
        }
        wait(for: [promise], timeout: 10)
    }
```
