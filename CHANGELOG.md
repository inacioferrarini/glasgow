# Changelog #

# Version 0.1.6 #
## Swiftlint ##
Applied Swiftlint in unit tests.
Applied Swiftlint in code.

## Rakefile ##
Renamed documentation task from 'jazzy' to 'docs'.
Renamed 'Documentation' folder back to 'docs'.
Updated documentation to be hosted on github.

## Readme ##
Updated documentation coverage badge.


# Version 0.1.4 #
## DataProvider: ##
Adds func title(section: Int) -> SectionTitleType?

## ArrayDataProvider: ##
Renames parameter names in order to keep it neutral and, at the sime time, relate it better with IndexPath. `rows` and `sectionsAndRows` were named to simply `section` and `sections`.
Removes private(set) from `elements`.
Removes update methods, since `elements` can be updated directly.
Updates unit tests due to ArrayDataProvider updates.
Adds property to store sections' titles.
Adds func title(section: Int) -> SectionTitleType?
Adds property to initializers.

## ArrayDataprovider: ##
Renames Generic Type `Type` parameter to `ElementType`.

## CoreDataProvider: ##
Adds func title(section: Int) -> SectionTitleType?
Updates on initializer.
Renames Entity to EntityType.
Renames value to entity.
Renames `ValueType` to `EntityType`.

## Overall ##
Updates documentation.
Updates coverage reports.
Updates tests to match changes.
Renames `docs` folder to `Documentation` (trying to make cocoapods get it right).


## Version 0.1.3 ##
### Core Data ###
#### CoreDataStack ####
Property `managedObjectContext` made open.

#### NSManagedObject+Fetch ####
Initial version.


### Data Providers ###
#### Refreshable ####
Initial version.

#### Providers ####
Updated to use `Refreshable`.

#### DataSource ####
Updated to use `Refreshable`.

#### Data Proviers ####
Compatible with `IndexPath`.


### ArrayDataProvider ###
Updated to match `DataProvider`.
Added update capability.
Supports multiple sections.
Changed signature to include `rows` and `sectionsAndRows` in order to make usage clear.


### Networking ###
#### AppBaseApi ####
Minor improvements in general.
Adds POST capabilities.


### Overall ###
Minor improvements.


## Version 0.1.2 ##
### DataSources ###
Usage simplified through usae of `DataProvider`, `ArrayDataProvider` and `CoreDataProvider`.

### TableView Delegates ###
Initial version,
Documentation.

### Test Helper Classes ###
Duplicated test classes removed.


### Storyboards ###
Overall structured simplified in order to provide better storyboard compatibility, since storyboard structure is not capable to handle classes with generic signature.

### DataBasedViewController ###
No longer adheres to `AppContextAware`.


## Version 0.1.1 ##
### ArrowTransformer ###
Public init added.

### ArrowArrayTransformer ###
Public init added.

### ArrayDataSource ###
Minor improvements for `refresh()`


## Version 0.1.0 ##
First public version.