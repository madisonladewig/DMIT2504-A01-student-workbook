// I'm switching from declaring 'routeNameString' => PageWidget() directly in main.dart
// to having a routing 'table' in a dedicates routes file where I assign variable names to the route strings.

// Yes, this means we now go from route variable -> route name string string -> widget, which is a lot of intermediary layers.


const homeRoute = '/';