# 3.1.3+1 - 3.1.3+4
* Modal and TabPanel now uses ChangeDetectionStrategy.Default
* Fixed crash when panel starts out as expanded
* ReorderList: Imposed limit on how often reorder event can occur (once every 200ms)

# 3.1.3
* Quiz: Fixed issue where multiselect didn't work as expected
* Panel: Expanding/collapsing panel is now animated
* Panel: Added optional headerIcon input
* Panel now uses ChangeDetectionStrategy.Default
* Some minor improvements to reorderlist

# 3.1.1+4
* Fixed null-safety problem in Quiz
* Quiz can now be themed using mixin

# 3.1.1+3
* Tweaked NumberInput layout
* Added expandedChange output to Panel

# 3.1.1+2
* Increased margin on Toggle label to 0.5em (up from 0.3em)
* Fixed crash on reorderlist when dropping an item on its original position
* Reorderitem now have css class '.fo-dragging' whenever it is being dragged
* Reorderitem now have css class '.fo-dragover' while something is dragged over it

# 3.1.1+1
* Fixed issue where TextareaInput couldn't accept [ngModel]="null"
* Increased width of DatePicker to 300px (up from 250px)
* Improved ProgressBar design so that it works well with different colors
* Improved Toggle design (drop shadow and grey background on slider)
* Check, Radio and Toggle now have display: inline-flex so they inline with text properly

# 3.1.1
* Panel is now expandable, can be disabled, and accepts a secondary input 'description' (shown under header)
* DatePicker now accepts null dates as input
* Changed ChangeDetectionStrategy of TabPanel to OnPush
* TabPanel can now be disabled via input

# 3.1.0+1
* Fixed issue where TextInput didn't handle error messages properly
* Dropdown filter input is now fixed at top of dropdown
* Some updates to docs

# 3.1.0
* Added ProgressBar
* Added ReorderList
* Set white background on Radio and Check components
* Renamed fo-file-upload-border-color mixin to to fo-file-upload-colors

# 3.0.1+2
* Added missing @Input annotation to FoRadio.checked
* FoPanel now uses changeDetectionStrategy.OnPush

# 3.0.1
* Some design improvements on check/radio/toggle components
* Improved documentation a bit (WIP)
# 3.0.0
* Updated angular dependency to 7.0.0 and added null-safety
* Added DatePicker, LoadIndicator, Check-, Radio- and Toggle- components
* Removed ImageMap, Notification, DropdownSelectMulti components
* Removed angular_components dependency
* Removed everything with 'square' and 'focus', might implement these in theme mixin later
* Made dropdown snappier
* Carousel no longer supports radio buttons
* Removed intermediate step from FileUpload
* Renamed fo-image-file-max-height mixin to fo-image-file-height so that it reflects intent better
* Renamed FileUploadComponent to FoFileUploadComponent for consistency
* Toned down shadows
* Changed Modal maxheight to 87vh (down from 95vh to accomodate ios bottom navbar)
* Added index to FoQuestion label
* Calculate and store maxScore in FoQuiz OnInit
* Added method FoQuiz.restart() 
* FoQuiz now uses changeDetection.OnPush
* Visual improvements to FoQuiz
* Deprecated FoQuiz input 'buttonColorActive', only input used now is buttonColor, 'active' button color is now set internally

# 2.1.1
* FoDropdownSelectMulti and FoNumberInput now has OnPush changeDetection
* FoTextareaInput now has OnPush for real
* Fixed issue where FoTextInput/FoTextAreaInput didnt detect changes properly

# 2.1.0
* FoModal, FoTextInput, FoTextareaInput, FoDropdownSelect now has OnPush changeDetection
* Fixed issue where dropdown didn't update height properly when options contains images (see https://github.com/afpatmin/fo_components/issues/78)
* Removed deprecated @JsonKey(nullable) annotation

# 2.0.1+1
* Added attribute FoTextInput.autocomplete
* Updated some dependencies in preparation for null safety

# 2.0.1
* Bugfix: FoQuizOption no longer serializing 'selected' property

# 2.0.0 (BREAKING CHANGES)
* Updated angular dependency to 6.0.0
* Updated min-sdk to 2.10.1
* Removed deprecated DataTableComponent
* Added OnPush changeDetectionStrategy to Label, Dropdown and DropdownOption

# 1.10.4+1 & 1.10.4+2
* Bugfix: TextareaInput could not scroll
* Bugfix: Elastic TextareaInput height now evaluated after view init

# 1.10.4
* Feat: added input 'elastic' to TextAreaInput. Makes the component resize height automatically based on input

# 1.10.3+5
* Bugfix: Dropdown sometimes blocked content underneath even when dropdown was closed

# 1.10.3+4
* Style/Bugfix: fo-modal-padding mixin no longer causes footer to have 0 horizontal padding

# 1.10.3+3
* Style/Bugfix: fo-modal-padding mixin no longer causes header/button to have 0 horizontal padding

# 1.10.3+2
* Style: minor adjustments to textInput and dropdown selects
* Style: TextInput text color now set to darker gray instead of primaryColor and icon color is set to PrimaryColor instead of SecondaryColor

# 1.10.3+1
* ImageFile no longer repeats (whoops)

# 1.10.3
* Added css directive [cover] to ImageFile
* Added default height 40px to ImageFile

# 1.10.2+4
* Bugfix: Fixed a crash in TextInput with dropdown options introduced with 1.10.2+1
* Style: Minor style/alignment adjustments to TextInput and DropdownSelect 

# 1.10.2+3
* Bugfix: TextInput no longer adding dropdown to template when options is null

# 1.10.2+2
* Bugfix: Modal padding mixin did double padding

# 1.10.2+1
* Bugfix: TextInput and TextAreaInput sometimes didn't update error output

# 1.10.2
* ImageFile now cropping and maintaining size

# 1.10.1
* Bugfix: Modal close button no longer inherits horizontal-padding
* Style: Modal close button font size now 1em (up from 0.7em)

# 1.10.0
* Breaking: Changed signature of TextInput's SelectionChangeEvent (added 'value' member) 

# 1.9.1+4
* Added mixin fo-dropdown-select-horizontal-padding

# 1.9.1+3
* NumberInput now hints inputMode

# 1.9.1+2
* Bugfix: Eliminated whitespace below textarea
* Removed scrollbar from textarea

# 1.9.1+1
* Bugfix: fixed #76 (button alignment with icons)
* Added mixin fo-text-input-horizontal-padding 

# 1.9.1
* Bugfix: fixed #75 (bad background color for InputComponents with leading-/trailingicons)
* Style: made ImageFile delete button more dense

# 1.9.0+1
#### Carousel
* Minor style fixes

# 1.9.0
#### Carousel
* Breaking: Replaced internal media rule with @input [arrowsBelow] so that the client app can decide 
* changeDetection is now ChangeDetectionStrategy.default instead of onPush
* No longer disabled while sliding
* Now using flex for alignment
* Minor style fixes

# 1.8.1+2
* Bugfix: removed all old imports to grid_css/constants

# 1.8.1+1
* Maintenance: updated grid_css to 2.0.0
* Removed targetPosition input from DropdownList

# 1.8.1
* Maintenance: updated grid_css to 1.0.1
* Removed grid/grid.css import from data-table
* Added deprecation-notice to DataTable

# 1.8.0+3
* Added mixin fo-button-horizontal-padding

# 1.8+0+2
* Fixed the issue described in 1.8.0+1 for real this time

# 1.8.0+1
* Fixed style issue with dropdown border being visible longer than animation

# 1.8.0
* Breaking: removed targetPosition input from dropdown (no longer supported)

# 1.7.7+3
* Dropdown now sets height to 0 on close

# 1.7.7+2
* Dropdown Bugfix #2 rounding error

# 1.7.7+1
* Bugfix when dropdown height in other unit than px

# 1.7.7
* Added animation to dropdown

# 1.7.6+4
* Added transform: translateZ(1px) to Modal 

# 1.7.6+3
* EmailValidator now requires lowercase

# 1.7.6+2
#### DropdownSelectMulti
* Added dropdownMaxHeight input

# 1.7.6+1
#### TextInput, NumberInput
* Tiny pixel perfect adjustments

# 1.7.6
#### TextInput, NumberInput
* Minor height adjustments pixel perfect

# 1.7.5+8
#### TextInput
* Fixed bad padding on ActionButton

# 1.7.5+7
#### ImageFile
* Removed box shadow from uploaded image, and imroved delete button design

# 1.7.5+6
#### TextInput
* Added input hideErrorsOnBlur (default: true) to control if error messages are shown when input doesn't have focus

# 1.7.5+5
#### TextInput
* Error messages are now only shown when the input has focus, red border otherwise

# 1.7.5+4
#### Dropdown
* Fixed visibleChange output logic

# 1.7.5+3
#### Quiz
* Made step buttons wider (70px -> 100px)

# 1.7.5+2
#### NumberInput
* Now enforces step constraint even from manual input (closes https://github.com/afpatmin/fo_components/issues/72)
* max value now defaults to 1000 (down from 9999)

#### Other
* Bumped build_runner dependency to 1.7.2

# 1.7.5+1
#### Quiz
* Updated Intl messages so that they can be extracted properly

# 1.7.5
#### Quiz
* Improved flow and design

# 1.7.4
#### TextInput
* ActionButton can now have icon or label

# 1.7.3+1
#### DataTable
* Fixed issues with batchOperations dropdown

# 1.7.3
#### Carousel
* Added a small threshold (40px) to horizontal dragging on mobile so that a user can scroll vertically without triggering vertical slide

# 1.7.2+2
#### TextAreaInput
* TextArea with error now has alertColor border

# 1.7.2+1
#### TabPanel
* Fixed broken vertical-padding mixin

# 1.7.2
#### TextAreaInput
* Added input 'canResize'

#### DropdownSelect
* Fix issue where selected value didn't get updated on options changes

#### Rating
* Made MaterialIcons into FoIcons

# 1.7.1
#### Panel
* Made close button prettier

# 1.7.0
#### DropdownOptionRenderable
* Breaking: Added required field 'renderTags'. Use tags to filter options on other values than just the renderLabel

#### Dropdown
* Breaking: Removed input "anchorRight" from Dropdown
* Improved dropdown (simplified logic by using absolute instead of fixed position)

# 1.6.8
#### Modal
* Adjusted close button vertical padding

#### DataTable
* Adjusted buttons, text input and dropdown select vertical paddings

#### TabPanel
* Added mixin tab-panel-vertical-padding

#### TextInput
* Fixed issue where dropdown options didn't always get properly selected

# 1.6.7
#### TextInput, FoButton, DropdownSelect, TabPanel
* Removed dense css directive (use mixins to control padding)

#### DropdownSelect
* Minor style updates to DropdownSelect (removed outer padding and aligned arrow icon better)

# 1.6.6
#### TextInput
* Made disabled input look better (everything is greyed out instead of just middle part)

#### DropdownSelectMulti
* Add button now stretched properly when vertical padding mixin is used
* Fixed issue where changes to options didn't register

#### Modal
* Improved error text design
* ..now has a header if either header text isn't null or showCloseButton is true
* Removed dense css attribute, use fo-modal-padding to control padding
* Added fo-modal-width mixin

# 1.6.5+1
#### Dropdown
* Fixed issue where list could not be scrolled on touch devices

# 1.6.5
#### Dropdown
* Put z-index on relative element instead of fixed - should resolve z-index issues on iOS

# 1.6.4
#### NumberInput
* Fixed issue where view didn't updated on value changes

# 1.6.3
#### Modal
* Changed close button left margin to 1.5em (from 0.2em)

# 1.6.2
#### DropdownList
* Fixed issue where touch events propagated to elements underneath the list

#### ImageFile
* Removed default label ('image')

#### FileUpload
* Decreased border width 2px -> 1px

# 1.6.1+1
#### TextInput, TextAreaInput
* Set default border color of error output to #cdd2d9;

# 1.6.1
#### TextInput, TextAreaInput
* Some minor changes to colors
* Error output border no longer affected by color mixin

#### TextAreaInput
* Changed vertical paddding 0.5em -> 0.25em

# 1.6.0
#### ImageFile
* (BREAKING) Replaced mixin fo-image-file-border-color with fo-image-file-colors
* Added addIcon input
* Minor style updates

# 1.5.12

#### Button

* Changed disabled text and border colors

#### ImageFile

* Added dense attribute to upload button

# 1.5.11

#### TextInput

* Fixed issue where actionButton didn't take up full height

# 1.5.10

#### TextInput

* Made input background color white

# 1.5.9

#### Dropdown

* Fixed issue with left positioning when parent is fixed

# 1.5.8

#### DropdownList (TextInput and DropdownSelect options)

* Selection now responding mousedown/touchstart instead of full click

# 1.5.7+6

#### DropdownSelect

* fo-dropdown-select-icon-size no longer affect dropdown list icons, use separate mixin for that

# 1.5.7+4 & 1.5.7+5

#### DropdownSelect

* fo-dropdown-select-icon-size mixin now also affects dropdown list icons

# 1.5.7+3

#### DropdownSelect

* Added mixin fo-dropdown-select-icon-size

# 1.5.7+2

#### DropdownSelect 

* Removed z-index

# 1.5.7+1

#### TextInput

* Fixed broken margins on textInput from previous patch

# 1.5.7

#### DropdownSelect

* Added dropdownMaxHeight input
* Fixed a bunch of issues with z-index

#### Dropdown

* Fixed issue where height was too large by default
* Fixed issue where left offset was broke when fixedParent left isnt 0

#### TextInput

* Added leadingText input
* Minor margin adjustments

# 1.5.6+1

#### Other

* Bumped grid_css to ^1.0.0

# 1.5.6

#### Carousel

* Removed default left/right offsets on arrow buttons
* Fixed issue where clicking a slide sometimes triggered it to step

#### DropdownList

* Selecting a value click event no longer propagates to elements behind

# 1.5.5

#### DropdownSelect

* Added mixin fo-dropdown-select-vertical-padding
* Minor layout tweaks
* z-index now explicitly set to 1
* Selected value icon is now primaryColor
* Fixed issue where dropdown list was offset by 1

#### DropdownList

  + Category dividers are now full width

# 1.5.4+1

#### NumberInput

* Added square css directive to NumberInput

# 1.5.4

#### NumberInput

* Made add/subtract buttons wider
* Added mixin fo-number-input-button-width
* Added mixin fo-number-input-input-width

# 1.5.3

#### NumberInput

* Added materialIcons input
* Fixed issue where setting text-input-padding mixin propagated into NumberInput
* Removed default label "value"

# 1.5.2+1

#### DropdownList

* Style tweaks

# 1.5.2

#### Dropdown

* Added mixin fo-dropdown-border-color
* Added maxHeight input

#### DropdownList

* Added maxHeight input

#### TextInput

* Fixed issue where dropdown width wasn't calculated correctly when input has icons
* Added dropdownMaxHeight input

# 1.5.1+2

#### TextInput

* Fixed issue where textColor from mixin didn't get set properly
* Fixed issue where fo-text-input-vertical-padding wasn't applied properly

# 1.5.1+1

#### TextInput

* Replaced transparent css directive with another argument to fo-text-input-colors mixin (default: white)

# 1.5.1

#### TextInput

* (BREAKING) Updated fo-text-input-colors mixin to include alertColor
* Added css directive 'transparent' which the input have no background color
* Added mixin fo-text-input-vertical-padding

# 1.5.0

#### Dropdown

* added noShadow css directive to popup

# 1.4.9+2

* Same as 1.4.9+1 but with json_annotation

# 1.4.9+1

* Fixed sass_builder dependency issue (moved back from devv_dependencies to dependencies)

# 1.4.9

#### Carousel

* Added loop input
* (BREAKING) Replaced css directive noSlideAnimation with animateSlides input (default: true), and removed animate noFadeAnimation
* (BREAKING) Slides are no longer animated when set externally

#### DropdownList

* Improved category labels design

#### ErrorOutput

* Now has correct width (takes border into account)

#### Other

* Bumped some dependencies (build_runner, json_serializable)

# 1.4.8

#### Dropdown

* Fixed issue where position wasn't set properly when anchor/target was translated

#### Carousel

* Added materialIcons input
* Added nextIcon and prevIcon inputs
* No longer using fo-button for next/prev buttons

# 1.4.7

#### Carousel

* Added noFadeAnimation and noSlideAnimation css directives

# 1.4.6

#### TextAreaInput

* Font size now inherited from parent rather than monospace

# 1.4.5

#### TextInput

* (BREAKING): selectionChange output now fires SelectionChangeEvent objects rather than FoDropdownOptionRenderables

# 1.4.4+1

#### TextInput

* selectionChange output now fires before the actual ngModel value is set

# 1.4.4

#### Modal

* Fixed font size so that it can be set normally: `fo-modal { font-size: 32px; }` 

#### TextInput

* Added filterOptions input (default: true)

# 1.4.3

#### TextInput

* Added showDropdownOnFocus input (default: false)

#### TextInput, DropdownSelect

* Added showDropdownCategoryLabels input (default: true)

#### DropdownList

* Added showCategoryLabels input (default: true)

#### DropdownOption 

* Made icon container smaller (1.8em -> 1.2em)

# 1.4.2+4 & 1.4.2+5

#### NumberInput

* Fixed trailing space issue for real this time

# 1.4.2+3

#### NumberInput

* Fixed trailing space issue

# 1.4.2+2

#### Button

* Fixed some icon alignment issues

# 1.4.2+1

#### Modal

* Tweaked alignments slightly

#### NumberInput

* Fixed alignment on number input

# 1.4.2

#### Modal

* Added materialIcon input for close button

# 1.4.1

* BREAKING: Removed all *-font-size mixins. To set font-size, just do it the normal way (fo-text-input { font-size: 24px; })

# 1.4.0+1

* Fixed some problems with inconsistency using dense attribute

# 1.4.0

#### DropdownSelectMulti

* BREAKING: Removed dropdown-select-multi-font-size mixin, now incorporated into dropdown-select-font-size

#### DropdownSelect/TextInput

* BREAKING: No longer relying on line-height to style, only vertical padding (1rem default, 0.5rem for dense attribute)
* BREAKING: Changed how leading/tralining/clearIcons are aligned/sized
* BREAKING: Replaced two mixins with single: fo-dropdown-select-colors
* Added fo-text-input-colors mixin

#### DropdownList

* FilterContainer now hidden completely if search attribute not set

#### DropdownSelect

* Removed clearSize attribute from actionButton
* Fixed issue where square attribute didn't propagate to actionButton
* Now has proper cursor pointer

#### DropdownOption

* Label color now defaults to grey (use mixin to change it)

#### ImageFile

* Some adjustments to vertical alignment

# 1.3.8

#### Button

* Changed how button height and internal alignment is specifed
* White button border color now #eed2e9

#### TextInput

* Clear icon now always visible

# 1.3.7+1

#### Button

* Changed label color when disabled from white to darkened disabled background color

# 1.3.7

#### DropdownSelect / DropdownSelectMulti

* Added placeholder input (similar to text input placeholders)
* Added mixins fo-dropdown-select-dropdown-icon-color and fo-dropdown-select-selected-value-color

#### DropdownOption

* Label is only semi-bold if secondaryLabel is set

#### Dropdown

* Removed small margin from top

# 1.3.6+1

#### TextInput

* Icon now affected by font-size mixin

#### Dropdown

* Fixed issue where icon td wasn't wide enough when using mixin

# 1.3.6

#### Dropdown & DropdownList

* offsetTop and offsetHorizontal are now both null by default

### DropdownList

* Made some style adjustments for list items

# 1.3.5+5

#### DropdownList

* Added targetPosition and offsetHorizontal inputs

# 1.3.5+4

#### Dropdown

* Added targetPosition input which places a target indicator at the top, use at your own risk.

# 1.3.5+2

#### Dropdown

* Added offsetHorizontal input which offsets the dropdown position horizontally

# 1.3.5+1

#### Dropdown

* Should now respect viewport constraints even with fixed parent

# 1.3.5

#### Button

* Text overflow is now ellipsis

#### Dropdown

* Now handles offsetTop properly when parent is fixed

# 1.3.4

#### DropdownSelectMulti

* Output container no longer showing when no values are selected

#### Icon

* Made icon align-center internally

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
* Removed instances of changeDetectionStrategy. Stateful

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

