DynamicBackgrounds
======================

A custom UIView subclass that display a dynamic background similar to one shipped on a brand of mobile phone.

Synopsis
========
This class requires the the QuartzCore framework. Add a view of class GCDynamicBackgroundView to your application to get a dynamic disc animation.  

<pre>
    GCDynamicBackgroundView *backgroundView = [[GCDynamicBackgroundView alloc] init];
    // add object to view hiearych
    // set frames or add constraints

    // Set the start and end colors
    backgroundView.startColor = [UIColor redColor];
    backgroundView.endColor = [UIColor redColor];
</pre>

