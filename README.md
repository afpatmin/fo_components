#FoComponents 0.0.1
##fo-icon
###Description
SVG icon
###Attributes
  * foSrc: Which icon id from within *icons.svg*
  * foTitle: Icon title and aria-label 

###Example
```html
<fo-icon foSrc="coins" foTitle="Coins"></fo-icon>
```

###Remarks
The caller must provide a svg file containing icons,
in *[public_html]/gfx/icons/icons.svg*

##fo-popup
###Description 
A popup dialog with a title and text content covering the window.
###Attributes
  * foText: Text content
  * foTitle: Header title

###Example
```html
<fo-popup #popup foText="{{strText}}" foTitle="Information"></fo-popup>
<button (click)="popup.open()">Click me!</button>    
```

###Remarks
No more than one popup window can be open at a time