## 0.2.2+3
### Component updates
#### FoDropdownList, FoDropdownSelect, FoDropdownSelectMulti, FoTextInput
* Now using abstract class FoDropdownOptionRenderable instead of FoDropdownOption


## 0.2.2+2

### Component updates
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

### Component updates
* FoTabPanel now colored according to theme primary color
* FoFileUpload, FoImageFile, FoImageMap, FoModal, FoNotification, FoNumberInput, FoPanel, FoQuiz, FoRating now has in-house components instead of material ones

### Bugfixes
* FoTextInput font-size mixins now applies to action button aswell

## 0.2.1
### General
* Added example/ to .gitignore

### Component updates
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