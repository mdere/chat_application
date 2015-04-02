$(function () {
	if ($("#comment_space").length > 0) {
		setTimeout(updateComments, 5000);
	}
});

function updateComments () {
	var after = $("#comment:last-child").attr("data-time");
	$.getScript("/users/updateComments.js?after=" + after)
	setTimeout(updateComments, 5000);
}