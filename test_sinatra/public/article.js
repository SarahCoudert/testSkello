$( document ).ready(function() {
	$("div.up").on("click", function() {
		let article_id = $(this).attr("data-article-id")
		let comment_id = $(this).attr("data-comment-id")
		$.ajax({
			type: "POST",
			url: "/upvote/" + article_id + "/" + comment_id,
			success: function(){
				selector = "#vote_" + comment_id
				em = $(selector);
				em.text(parseInt(em.text()) + 1)
			}
		});
	});

	$("div.down").on("click", function() {
		let article_id = $(this).attr("data-article-id")
		let comment_id = $(this).attr("data-comment-id")
		$.ajax({
			type: "POST",
			url: "/downvote/" + article_id + "/" + comment_id,
			success: function(){
				selector = "#vote_" + comment_id
				em = $(selector);
				em.text(parseInt(em.text()) - 1)
			}
		});
	});

});