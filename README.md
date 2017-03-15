# FoComponents 0.0.1

## fo-icon

### Description

SVG icon

### Input Properties

  * fo**Src:** Specify an icon id from within *icons.svg*
  * fo**Title:** Icon title and aria-label 

### Example

```html
<fo-icon foSrc="coins" foTitle="Coins"></fo-icon>
```

### Remarks

The caller must provide a svg file containing icons,
in *[public_html]/gfx/icons/icons.svg*

## fo-popup

### Description 

A popup dialog with a title and text content covering the window.

### Input Properties

  * fo**Text:** Text content
  * fo**Title:** Header title
  * fo**IsConfirm:** [bool] specifying whether or not the dialog has "Ok" and "Cancel" buttons

### Example

```html
<fo-popup #popup [foIsConfirm]="true" (close)="parseResponse($event)></fo-popup>
<button (click)="popup.open($event, strText, strTitle)">Click me!</button>    
```

### Remarks

If the popup is a confirm dialog (specified by the **isConfirm** property), the popup dialog fires a "close"-event when 
closed. The event payload is set to true if the user confirmed by pressing 
"Ok", and false otherwise.
