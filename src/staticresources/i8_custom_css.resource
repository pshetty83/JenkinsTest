/*Custom CSS*/

/*---------- GLobal ----------*/
/* Responsive Table */
.ui-table-reflow.ui-responsive { display: table !important; } 

/* Table Elements */
.oppty-list thead th,
.oppty-list tbody tr:last-child {
    border-bottom: 1px solid #d6d6d6; /* non-RGBA fallback */
    border-bottom: 1px solid rgba(0,0,0,.1);    
}
.oppty-list tbody th,
.oppty-list tbody td {
    border-bottom: 1px solid #e6e6e6; /* non-RGBA fallback  */
    border-bottom: 1px solid rgba(0,0,0,.05);
}
.oppty-list tbody tr:last-child th,
.oppty-list tbody tr:last-child td {
    border-bottom: 0;
}
.oppty-list tbody tr:nth-child(odd) td,
.oppty-list tbody tr:nth-child(odd) th {
    background-color: #eeeeee; /* non-RGBA fallback  */
    background-color: rgba(0,0,0,.04);
}

/* Remove the box shadow on buttons*/
.ui-page-theme-a .ui-btn:focus,
html .ui-bar-a .ui-btn:focus,
html .ui-body-a .ui-btn:focus,
html body .ui-group-theme-a .ui-btn:focus,
html head + body .ui-btn.ui-btn-a:focus,
/* Focus buttons and text inputs with div wrap */
.ui-page-theme-a .ui-focus,
html .ui-bar-a .ui-focus,
html .ui-body-a .ui-focus,
html body .ui-group-theme-a .ui-focus,
html head + body .ui-btn-a.ui-focus,
html head + body .ui-body-a.ui-focus {
    -webkit-box-shadow: none;   
    -moz-box-shadow: none;      
    box-shadow: none;           
}

/* No Margin for the search box in the header*/
.ui-input-search {
    margin: 0;
}

/*---------- Opportunity List Page ----------*/



/*---------- Quotes List Page ----------*/


/*---------- Premium Calculator List Page ----------*/

/* Style the Doctor Visit and smoking Slider Handle */
#docVisitsContainer .ui-slider-handle, #smokingContainer .ui-slider-handle{
    -webkit-transition:left 0.1s;
    transition: left 0.1s;
    width: 60px;
    margin-left: -30px;
}

/* Style the different switches of Doctor Visits and Smoking Slider Track*/
.docVistsBackColor{
    height: 100%;
    width: 33.33%;    
    float: left;
    color: white;
    text-align: center;
    font-size: 10px;
    font-weight: normal;
    text-shadow: 0px 1px 2px #333;
}

/* Stretching the slider track*/
#docVisitsContainer .ui-slider-track, #smokingContainer .ui-slider-track{
    margin-left: 0px;
    width:85%;
}


/* Round the corners of the left switch */
#docVisitsContainer .ui-slider-track > div.docVistsBackColor:first-child,
#smokingContainer .ui-slider-track > div.docVistsBackColor:first-child{
    border-top-left-radius: 0.3125em;
    border-bottom-left-radius: 0.3125em;
}

/* Round the corners of the right switch */
#docVisitsContainer .ui-slider-track > div.docVistsBackColor:last-of-type,
#smokingContainer .ui-slider-track > div.docVistsBackColor:last-of-type{
    border-top-right-radius: 0.3125em;
    border-bottom-right-radius: 0.3125em;   
}

/* Switches background color */
.pos1 { background-color: #4AB471;}
.pos2 { background-color: #F3AE4E;}
.pos3 { background-color: #CF5C60;}

/* Slider Handler color based on the backgroun switch */
.pos1glow .ui-slider .ui-btn:focus{ box-shadow: 0 0 12px #4AB471;}
.pos2glow .ui-slider .ui-btn:focus{ box-shadow: 0 0 12px #F3AE4E;}
.pos3glow .ui-slider .ui-btn:focus{ box-shadow: 0 0 12px #CF5C60;}	

/* Style the Coverage Amount and Weight Slider Tick Marks*/
.sliderTickmarks, .caTickmarks{
    -webkit-box-sizing: border-box; 
    box-sizing: border-box;
    height: 100%;
    width: 20%;    
    float: left;
    border-right: 1px solid #888;
}
.sliderTickmarks span, .caTickmarks span{
    position: relative;
    left: 100%;
    top: 125%;
    margin-left: -10px;
    font-size: 12px;
    font-weight: normal;
}

#caContainer .ui-slider-track, #weightContainer .ui-slider-track{
	width:65%;
	margin-left: 130px;

}

#weightContainer .ui-slider-track > div.sliderTickmarks:first-child, #caContainer .ui-slider-track > div.caTickmarks:first-child{
    border-right: 0;
    width: 0;
}
#weightContainer .ui-slider-track > div.sliderTickmarks:first-child span, #caContainer .ui-slider-track > div.caTickmarks:first-child span{
    margin-left: -5px;
}
#weightContainer .ui-slider-track > div.sliderTickmarks:last-of-type, #caContainer .ui-slider-track > div.caTickmarks:last-of-type{
     border-right: 0;
}	

/*Graph*/
circle,
path {
  cursor: pointer;
}

circle {
  fill: none;
  pointer-events: all;
}

/*Pop Up */
.customPopup{
            background-color: white;
            border-style: solid;
            border-width: 2px;
            left: 50%;
            padding:10px;
            position: absolute;
            z-index: 9999;
            /* These are the 3 css properties you will need to tweak so the pop 
            up displays in the center of the screen. First set the width. Then set 
            margin-left to negative half of what the width is. You can also add 
            the height property for a fixed size pop up.*/
            width: 500px;
            margin-left: -250px;
            top:100px;
        }

.customPopupApp{
            background-color: #344A5F;
            border-style: solid;
            border-width: 1px;
            left:10%;
            padding:10px;
            position: absolute;
            z-index: 9999;
            /* These are the 3 css properties you will need to tweak so the pop 
            up displays in the center of the screen. First set the width. Then set 
            margin-left to negative half of what the width is. You can also add 
            the height property for a fixed size pop up.*/
            width: 75%;
            height:70%;
            margin-left: 0px;
            top:100px;
        }        
