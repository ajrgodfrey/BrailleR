
This file documents the full object structure which is available to the whisker template.
Trailing asterisk indicates items introduced in the mustache preprocessing step.

Lists have a "sep" field to assist with natural language description of the list. 
Sep is blank for the final list item, "and" for the penultimate one, and "," otherwise.

```    
annotations  
* title  
* subtitle  
* caption 

xaxis 
*	samescale         # do all facets have the same scale (currently only present if same on both axes)  
*	xlabel      
*	xticklabels       # if samescale present.  This is a vector
*	xtickitems (list) * 
	+ itemnum *
	+ label           # the tick label
	+ sep

yaxis  
*	samescale         # do all facets have the same scale (currently only present if same on both axes)  
*	ylabel  
*	yticklabels       # if samescale present.  This is a vector
*	ytickitems (list) * 
	+ itemnum *
	+ label           # the tick label
	+ sep

legends (list)		  # this includes colour, fill, shape, etc
*	aes
*	mapping
*	scalediscrete
*	scalefrom         # If scalediscrete not present
*	scaleto           # if scalediscrete not present
*	scalelevels       # if scalediscrete present
*	hidden            # If this legend has been hidden

npanels  
panelrows             # What variable(s) are varying in the facet rows. Missing if not faceted.  
panelcols             # What variable(s) are varying in the facet columns. Missing if not faceted.  
singlepanel *  
singlerow *  
singlecol *  
panelgrid *  
nlayers  
singlelayer *  
panels (list)  

*	panelnum		
*	row               # What row of the panel grid is this panel in
*	col               # What col of the panel grid is this panel in
*	vars (list)       # What data is included in this panel
    +	varname
    +	value			
*	samescale         # Duplicated from xaxis,yaxis
*	xlabel            # if samescale not present, axis labelling for this panel
*	ylabel            # if samescale not present, axis labelling for this panel
*	xticklabels       # if samescale not present, axis labelling for this panel
*	xtickitems (list) * 
	+ itemnum *
	+ label           # the tick label
	+ sep
*	yticklabels       # if samescale not present, axis labelling for this panel
*	ytickitems (list) * 
	+ itemnum *
	+ label           # the tick label
	+ sep
	
* panellayers (list)

	+ layernum
	+ type            # One of hline, bar, line, point, box, smooth, unknown
	+ hlinetype *
	+ bartype *
	+ boxtype *
	+ linetype *
	+ pointtype *
	+ smoothtype *
	+ unknowntype *
	+ layeraes (list) # Non-default aesthetics that were specified for this layer
		+ aes
		+ mapping
		+ position
	+ badtransform	  # A transform used in this layer has no inverse, can't report original values
	+ transform	      # If badtransform present, the name of the tranform
	+ data         	  # Raw plot data for this layer & panel. Used by MakeAccessibleSVG, not by VI
	+ scaledata	      # Plot data converted back to original scale
	+ n *             # Number of items present
	+ s *             # If number of items > 1 (useful for pluralizing)
	+ largecount *    # If no item details will be provided because there are too many
	+ items (list) *  # Plot data converted to lists for mustache
		+ itemnum
		+ sep *       # text separator
		+ yintercept  # if type hline
		+ x           # if type point or line or box, or type bar with constant width bars  
		+ y           # if type point or line
		+ xmin        # if type bar with non-constant-width bars
		+ xmax        # if type bar with non-constant-width bars
		+ ymin        # if type box or bar
		+ lower       # if type box
		+ middle      # if type box
		+ upper       # if type box
		+ ymax        # if type box or bar
		+ noutliers   # if type box
	+ method          # if type smooth
	+ ci              # if type smooth   
```
