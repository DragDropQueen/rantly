/**
 * Created by savannah on 10/30/14.
 */

FOLLOW = {
  followElement: null,
  unfollowElement: null,
  follow: function (elements) {
    elements.one('click', function (e) {
      e.preventDefault();
      e.stopPropagation();

      FOLLOW.followElement = $(this);
      url = $(this).attr('href');
      FOLLOW.postFollow(url);
    })
  },
  unfollow: function (elements) {
    elements.one('click', function (e) {
      e.preventDefault();
      e.stopPropagation();

      FOLLOW.unfollowElement = $(this);
      url = $(this).attr('href');
      FOLLOW.deleteFollow(url);
    })
  },
  postFollow: function (url) {
    $.post(url).success(FOLLOW.changeFollowLinks());
  },
  deleteFollow: function (url) {
    $.ajax({
      url: url,
      method: 'DELETE',
      success: FOLLOW.changeUnfollowLinks()
    })
  },
  changeUnfollowLinks: function () {
    var href = FOLLOW.unfollowElement.attr('href');

    $("a[href='" + href + "']").each(function () {
      $(this).text('Follow');
      FOLLOW.follow($(this));
    });
  },
  changeFollowLinks: function () {
    var href = FOLLOW.followElement.attr('href');

    $("a[href='" + href + "']").each(function () {
      $(this).text('Unfollow');
      FOLLOW.unfollow($(this));
    });
  }
};