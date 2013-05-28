$(document).ready(function(){
	$("#comment-button").on('click',function(){
		$('#comments-whole').slideDown('fast');
		$('#comment-button').slideUp('fast');
	});
});