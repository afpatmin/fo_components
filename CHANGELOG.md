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