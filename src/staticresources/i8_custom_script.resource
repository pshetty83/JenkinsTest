//Custom javascript

//Generic
j$ = jQuery.noConflict();

//---------- OpportunityList Page ----------

//Function for Current Deals search field
j$(document).on('keydown', '[id*=searchCD]', function(event) {
    if(event.keyCode == '13') {
        searchCurrentDeals(this.value);             
    }

});

//Function for Won Deals search field
j$(document).on('keydown', '[id*=searchWD]', function(event) {
    if(event.keyCode == '13') {
        searchWonDeals(this.value);             
    }

});

//Function to navigate to Premium Calculator and pass parameter
function showCalculator(oppid) {
    //alert(oppid);
    var calchtml = "/apex/i8_PremiumCalculator?id=" + oppid
    j$( ":mobile-pagecontainer" ).pagecontainer( "change", calchtml );

} 


//---------- QuotesList page ----------

//Function for Quotes search field
j$(document).on('keydown', '[id*=searchQ]', function(event) {
    if(event.keyCode == '13') {
        searchQuotes(this.value);               
    }

});


//---------- Premium Calculator ----------

//Doctor Visit, Weight, and Smoking Slider related script
j$(document).on("pageinit", "#calculator" ,function(){ 
	console.log('Pageshow');

	//Change the position when the slider handle is moved
    function PositionSwitchHandle(slider){
        var theVal = slider.val();
        var ml = "50%";
        var glowClass = "pos2glow";
        var theText = "Med"
         if (theVal <= 1){
            ml = "16.5%";
            glowClass = "pos1glow";
            theText = "Low"
        } else if (theVal == 3){
            ml = "82.5%";
            glowClass = "pos3glow";
            theText = "High"
        }
        slider.closest(".ui-slider").find(".ui-slider-handle").css("left", ml).text(theText);  
        slider.parents(".glow").removeClass("pos1glow pos2glow pos3glow").addClass(glowClass);
    }

    /*---- Doctor Visits slider----*/
    j$("#docVisitsContainer .ui-slider-track").on('click', '.docVistsBackColor', function(e){
        //make sure switch is in correct position
        var val = 1;
        if (j$(this).hasClass("pos2")) {val = 2;}
        if (j$(this).hasClass("pos3")) {val = 3;}
        j$('[id*=docVisits]').val(val).slider( "refresh" );        
    });
    
    console.log(j$('#sw1').length);

    if( j$('#sw1').length > 0 && j$('#sw2').length > 0 && j$('#sw3').length > 0){
    	j$('#sw1').remove();
    	j$('#sw2').remove();
    	j$('#sw3').remove();
    }

    var switchBack  = '<div id="sw1" class="docVistsBackColor pos1">Low</div>';
        switchBack += '<div id="sw2" class="docVistsBackColor pos2">Medium</div>';
        switchBack += '<div id="sw3" class="docVistsBackColor pos3">High</div>'; 

   	j$("#docVisitsContainer .ui-slider-track").prepend(switchBack);

    PositionSwitchHandle(j$('[id*=docVisits]'));

    j$('[id*=docVisits]').on("change", function(){
        PositionSwitchHandle(j$(this));
    });

    /*---- /Doctor Visits slider ----*/

    /*---- Smoking slider----*/
    j$("#smokingContainer .ui-slider-track").on('click', '.docVistsBackColor', function(e){
        //make sure switch is in correct position
        var val = 1;
        if (j$(this).hasClass("pos2")) {val = 2;}
        if (j$(this).hasClass("pos3")) {val = 3;}
        j$('[id*=smoking]').val(val).slider( "refresh" );        
    });
    
    console.log(j$('#sw1').length);

    if( j$('#s1').length > 0 && j$('#s2').length > 0 && j$('#s3').length > 0){
    	j$('#s1').remove();
    	j$('#s2').remove();
    	j$('#s3').remove();
    }

    var sBack  = '<div id="s1" class="docVistsBackColor pos1">Low</div>';
        sBack += '<div id="s2" class="docVistsBackColor pos2">Medium</div>';
        sBack += '<div id="s3" class="docVistsBackColor pos3">High</div>'; 

   	j$("#smokingContainer .ui-slider-track").prepend(sBack);

    PositionSwitchHandle(j$('[id*=smoking]'));

    j$('[id*=smoking]').on("change", function(){
        PositionSwitchHandle(j$(this));
    });

    /*---- /Smoking slider ----*/    

    /*---- Coverage Amount Slider----*/

    if( j$('.caTickmarks').length > 0){
    	j$('.caTickmarks').remove();
    }

    var caticks  = '<div class="caTickmarks "><span>0</span></div>';
    caticks += '<div class="caTickmarks "><span>200K</span></div>';
    caticks += '<div class="caTickmarks "><span>400K</span></div>';
    caticks += '<div class="caTickmarks "><span>600K</span></div>';
    caticks += '<div class="caTickmarks "><span>800K</span></div>';
    caticks += '<div class="caTickmarks "><span>1000K</span></div>';
	j$("#caContainer .ui-slider-track").prepend(caticks);

	/*---- /Coverage Amount slider ----*/    

    /*----Weight Slider----*/

    if( j$('.sliderTickmarks').length > 0){
    	j$('.sliderTickmarks').remove();
    }

    var ticks  = '<div class="sliderTickmarks "><span>0</span></div>';
    ticks += '<div class="sliderTickmarks "><span>100</span></div>';
    ticks += '<div class="sliderTickmarks "><span>200</span></div>';
    ticks += '<div class="sliderTickmarks "><span>300</span></div>';
    ticks += '<div class="sliderTickmarks "><span>400</span></div>';
    ticks += '<div class="sliderTickmarks "><span>500</span></div>';
	j$("#weightContainer .ui-slider-track").prepend(ticks);

	/*---- /Weight slider ----*/

	/*---- Hide Premium Text ----*/
	function getURLParameter(name) {
	    return decodeURI(
	        (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]);
	}

	var id = getURLParameter("id"); 
    if(id.length>0){
    	j$("#premiumTextVal").hide();
    	j$('[id*=otprem]').show();
    }else
    {
     	j$("#premiumTextVal").show();
    	j$('[id*=otprem]').hide();   	
    }
});

var app = angular.module('premcalc', []);

app.controller('PremiumController',function ($scope) {
    $scope.change = function() {

    	var covAmount = 0;
    	var docVisits = 1;
    	var custWeightAmt = 0;
    	var smokingFreq = 1;

    	if($scope.Amount > 0)
    		covAmount = $scope.Amount*.12/1000;

    	if($scope.DocVisits > 1)
    		docVisits = $scope.DocVisits

    	if($scope.TheWeight > 0)
    		custWeightAmt = $scope.TheWeight/10;

    	if($scope.SmokeFreq > 1)
    		smokingFreq = $scope.SmokeFreq

		$scope.premiumCalc = parseFloat(covAmount) + parseFloat(docVisits*50) + parseFloat(custWeightAmt) + parseFloat(smokingFreq*50);

		/*j$('[id*=premiumText]').val($scope.premiumCalc);
		j$('[id*=amountText]').val($scope.Amount);
		j$('[id*=docText]').val($scope.DocVisits);
		j$('[id*=weightText]').val($scope.TheWeight);
		j$('[id*=smokeText]').val($scope.SmokeFreq);*/



    };	
	
	console.log($scope.premiumCalc);		    
});	
