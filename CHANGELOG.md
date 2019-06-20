# 1.3.3+1
### Component updates
#### Icon
* Removed tiny bottom margin

# 1.3.3
### Component updates
#### Carousel
* Step buttons are now hidden on small screen, and replaced by swipe gesture
* Increased step button size and added fade when they are not hovered

# 1.3.2
### Bugfixes
#### TextInput
* Fixed issue where leading- and trailingIcons didnt align properly

#### Quiz
* Increased quiz option highlight brightness

# 1.3.1
### Button
* Now properly highlights selected button 
* Set hover brightness to 120% (down from 150%)
* Hovering a white button no longer increases its brightness
* Added mixin 'fo-button-vertical-padding'

### DataTable
* Fixed issue where icon sizes was too large

# 1.3.0
### General
* BREAKNIG: Updated angular dependency to 6.0.0-alpha and angular_components to 0.14.0-alpha

### Component updates
#### Button
* BREAKING: Removed backgroundColorHover argument from fo-button-colors mixin

#### DataTable
* Row selector no longer truncates numbers > 100
* Fixed icon sizing

#### DropdownSelect, DropdownMultiSelect
* Selected value icon now primaryColor

#### Modal 
* Header/Footer now hidden unless populated
* Added buttonColor and buttonBackgroundColor inputs

#### Quiz
* Made more pretty
* Added buttonColor


# 1.2.4
### Component updates
#### DropdownSelect
* Options implementing renderIcon now renders icon in selectedValue aswell as in dropdown

#### ImageFile & FileUpload
* Dashed border now greyColorBright by default (instead of greyColor)

#### FoLabel
* Added maxWidth 100%

# 1.2.3+1
### Component updates
#### DropdownSelectMulti
* From now on only emit selectedIdsChange when change is internal

# 1.2.3
### Component updates
#### ImageFile
* Added placeholder input

#### ImageFile, FileUpload
* Dashed border now 2px wide (up from 1px)

#### DropdownSelectMulti
* No longer emitting selectedIdsChange onInit

# 1.2.2
### Component updates
#### Notification, Panel
* Minor tweaks to icon sizes
  
#### ImageFile
* Added fo-image-file-min-height mixin

### Bugfixes
#### ImageMap
* Fixed issue where not all marked zones was alert-color

# 1.2.1
### Component updates

#### Button, Dropdown, DropdownList, DropdownSelect, DropdownSelectMulti, TextAreaInput, TextInput
* Added css directive 'square' which will remove rounded corners

#### DropdownSelect, DropdownSelectMulti
* Added css directive 'noFocusShadow' to not highlight on focus

#### NumberInput
* Removed focus highlight shadow

# 1.2.0
### Component updates
#### Button
* Added leadingIcon and trailingIcon
* Added some left margin to icon

#### FileUpload, ImageFile
* User can now specify whether or not to use material icons (default: true)

#### Other
* Added example folder with link to examples

# 1.1.6
### Component updates
#### DataTable
* Confirm delete buttons are no longer dense and has all borders

#### DropdownOption 
* Added ability to renders optional leading image
* Made secondaryLabel slightly smaller (0.9em)

#### Modal
* Added fo-modal-padding mixin

#### TextInput
* Clear icon can now be specified whether or not is material
* Outputs an event when clear icon is clicked

# 1.1.5
### Component updates
* Added top and bottom css directives to Carousel

### Bugfixes
* Fixed DropdownSelect action button size when using dropdown-select-font-size mixin
* Dropdown is now properly positioned when it has a fixed parent

# 1.1.4
### Bugfixes
* Fixed issue where number input added two units on each touch event

### Component updates
#### Carousel
* added css directive bottomNavigationOnSmall

#### DropdownSelect
* Increased dropdown icon size when using fo-dropdown-font-size mixin
 
#### Modal
* Added fo-modal-font-size mixin 

# 1.1.3+1
### Bugfixes
#### DataTable
* Fixed broken material icons
* Rowcount selector now has fixed width to make sure the dropdown is always wide enough

# 1.1.3
### Component updates
#### Dropdown
* Added short delay to prevent dropdown to immediately auto-close when spawned by click event
* Added anchorRight input 
* constrainToViewPort now takes document scrollbars into account
* Scroll and resize subscriptions now properly cancelled onDestroy

# 1.1.2+2
### Bugfixes
* Updated SDK constraints in pubspec.yaml
* Fixed style issue in DataTable modal (when deleting a resource)
* FoDropDown constrainToViewPort now constraints top aswell as bottom

# 1.1.2+1
### Bugfixes
* Updated SDK constraints in pubspec.yaml

### Component updates
* Added fo-label-color mixin
* Added fo-tab-panel-colors mixin

# 1.1.2
### Bugfixes
* Fixed issue where dropdown sometimes crashed due to internal error

### Component updates
* Added [offsetTop] input to DropdownList


# 1.1.1
### Component updates
* Extracted dropdown logic from DropdownList into separate DropdownComponent

### Bugfixes
* Modal component overlay now has proper z-index
* Fixed issue with broken size input on single-color Icons
* DropdownList mixin now properly resizes option icon container

# 1.1.0+1
### Component updates
* Icon no longer requires colorCount input to support colors (instead all icons has support for 16 colors)

# 1.1.0
### Bugfixes
* Now exporting CarouselSlide

### Component updates
#### Panel
* Button style now only applied to close button

#### Icon
* Now supports multiple colors using input colorCount

#### Modal
* No longer using MaterialModal under the hood
* Breaking: Renamed input 'title' to 'header'
* Breaking: Replaced 'fixedWidth' and 'fixedHeight' inputs with pure-css attributes 'fullWidth' and 'fullHeight'
* Breaking: Replaced 'largePadding' input with pure css attribute 'dense'

# 1.0.5
### Component updates
#### Notification
* FoButton style now only applied to close button

#### Icon
* Added boolean input [material]. If set to true, FoIcon will become a proxy to MaterialIcon (defaults to false)

#### DropdownList, DropdownSelect, DropdownMultiSelect, TextInput
* Added boolean input [materialIcons]. If set to false, rendered icons are FoIcons (defaults to true)

### Bugfixes
* TextAreaInput now has proper border color when input isn't valid

# 1.0.4
### General
* Replaced ngOnChanges with interal logic due to it becomign deprecated in angular
* Removed instances of changeDetectionStrategy.Stateful

### Component updates
#### Carousel
* Slight style adjustments to Next/Previous buttons
#### DropdownSelect
* Removed crazy workaround to set selectedId on init

# 1.0.3+4
### Component updates
#### TextAreaInput
* Added inputElement ref

# 1.0.3+1
### Component updates
#### TextInput
* Added inputElement ref

# 1.0.3
### Bugfixes
* TextInput with options no longer showing options if a value is set initially
* TextInput now properly updates view when value is changed externally
* TextInput no longer crashes when autofilled
* DataTable table now has z-index so that batchOperation is shown under

### Component updates
#### TextInput, DropdownSelect, DropdownMultiSelect, DropdownList
* Added constrainToViewPort input

# 1.0.2+1
### Bugfixes
* DropdownSelect now initializes properly with selectedId


# 1.0.2
### General
* Theme now changes material-toggle color

### Component Updates
#### Button
* Decreased icon size for [dense]
* 
#### DataTable
* Removed focus shadow from filter text input

#### DropdownSelect
* Null check for options on click
* selectedId no longer always resets to null on init

#### DropdownList
* null option is now hidden if filterstring isn't empty

#### ImageMap
* Fixed issue where zones wasnt scaled properly with image

#### TextInput
* Got type attribute
* Added datePickerBindings to providers (needed by autofocus)
* ActionButton now disabled if value is empty
* ActionButton now triggered on enter

# 1.0.1+1
### Bugfixes
* Fixed issue where FoDropdownSelectMulti generics sometimes didn't work properly

# 1.0.1
### General
* Added FoTextAreaInput example in docs

### Component Updates
#### FoDropdownSelectMulti
* Added support for generics (selectedIds can now have any type)

## 1.0.0
### General
* Everything public is now properly exported in lib/fo_components.dart
* Bumped dart sdk constraints '>=2.2.0 <3.0.0' (previously '>=2.0.0 <3.0.0')

### Component Updates
#### FoDropdownSelect & FoDropdownSelectMulti
* Added optional search filter ([showSearch]="true")

### Removed
* FoYoutubePlayer

### Bugfixes
* FoDropdownSelectMulti selectedIds didn't get reflected properly when updated from elsewhere

## 0.2.2+3
### Component updates
#### FoDropdownList, FoDropdownSelect, FoDropdownSelectMulti, FoTextInput
* Now using abstract class FoDropdownOptionRenderable instead of FoDropdownOption


## 0.2.2+2

### Component Updates
#### FoDropdownSelect
* Added [allowNullSelection] option
* Adjusted option category margins

## 0.2.2+1

### General
* Added a docs start page
* Improved docs layout

### Bugfixes
* Fixed an issue where grid_css wasn't imported properly in some cases
* FoImageMapZone zone origins are now properly reset after draws

## 0.2.2

### General
* Added documentation for FoFileUpload, FoIcon, FoImageFile, FoImageMap, FoTabPanel FoModal, FoNotification, FoNumberInput, FoPanel, FoQuiz, and FoRating
* Added dense attribute example for FoTextInput
* Removed deprecated components FoSelect, FoMultiSelect, FoMultiInput, FoYoutubeComponent
* Added disabled checkbox to affected components in docs
* Improved navigation in docs

### New Components
* FoDropdownSelectMultiComponent

### Component Updates
* FoTabPanel now colored according to theme primary color
* FoFileUpload, FoImageFile, FoImageMap, FoModal, FoNotification, FoNumberInput, FoPanel, FoQuiz, FoRating now has in-house components instead of material ones

### Bugfixes
* FoTextInput font-size mixins now applies to action button aswell

## 0.2.1
### General
* Added example/ to .gitignore

### Component Updates
* Added FoDropdownSelect disabled input
* Replaced material components in FoDataTableComponent with in-house components
* Better dense directive for button, dropdownselect and textinput
* Added actionButton logic to dropdownselect

### Other
* Removed value field from FoDropdownOption


## 0.2.0
### General
* Added example/ and docs/ folders (docs/ is published on github pages)
* Added CHANGELOG.md
* Removed FoProviders
* Improved package description
* Replaced github dependencies with pub ones
* Removed fo_model dependency

### New Components
* MaterialTextInput
* MaterialDropdownSelect

### Deprecated Components
* FoMultiSelectComponent
* FoMultiInputComponent
* FoSelectComponent
* FoTimeInputComponent

### Removed Components
* FoTimeInputComponent