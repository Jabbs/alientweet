// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require_tree .

$('document').ready(function() {
	
	$('.hashtag').click(function() {
		var text = $(this).text();
		document.getElementById("tweet_copy").value += text;
  });
	
	// https://bootstrap-datepicker.readthedocs.org/en/release/
	$('.datepicker').datepicker()

	$('#new_tweet').parsley();
	$('.edit_tweet').parsley();
	
	$('.tweet-copy').click(function() {
		$(this).find("textarea").select();
  });
	$('.tweet-url').click(function() {
		$(this).find("input").select();
  });

});