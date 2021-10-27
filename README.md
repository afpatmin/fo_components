# FoComponents
### A collection of AngularDart components for dealing with data and user input in admin-like apps
Components Gallery: https://afpatmin.github.io/fo_components/

## Icons
FoComponents uses [Material Icons](https://google.github.io/material-design-icons/) by default. Include the following snippet in the `<head>` section of your `index.html`:
```html
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
```

## Custom theme
FoComponents inherits font/typography of the host application. We also encourage you to set your own color theme using the `fo-colors` mixin.
```scss
@import "package:fo_components/mixins";
@include fo-colors($primaryColor: red, $secondaryColor: green, $alertColor: red);
```

Many of the components can also be customized individually, see _mixins.scss under each component for details.