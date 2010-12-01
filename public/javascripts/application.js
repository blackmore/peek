// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
	$("#search_start_date").datepicker();
	$("#search_end_date").datepicker();
	var $overlay = $('<div class="ui-widget-overlay"><div id="loading">Loading</div></div>').hide().appendTo('body');
	
	//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	// Sets up the search form
	// checkboxes
	$('*:checkbox').attr('checked', true);
	
	// Date fields
	var myDate = new Date();
	var thirtyDaysAgo = new Date();
	thirtyDaysAgo.setDate(thirtyDaysAgo.getDate()-30);
	var displayDate = (myDate.getMonth()+1) + '/' + (myDate.getDate()) + '/' + myDate.getFullYear();
	var displayThirtyDaysAgo = (thirtyDaysAgo.getMonth()+1) + '/' + (thirtyDaysAgo.getDate()) + '/' + thirtyDaysAgo.getFullYear();
	$("#search_end_date").val(displayDate);
	$("#search_start_date").val(displayThirtyDaysAgo);
	
	
	// ajax loading mask 
	$("#custom_search").bind("ajaxStart", function(){
	    $overlay.fadeIn();
	}).bind("ajaxStop", function(){
	    $overlay.fadeOut();
	});


});