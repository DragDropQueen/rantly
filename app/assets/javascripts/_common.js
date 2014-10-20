/**
 * Created by savannah on 10/19/14.
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
    $.post(url).success(FOLLOW.changeLinkToUnfollow());
  },
  deleteFollow: function (url) {
    $.ajax({
      url: url,
      method: 'DELETE',
      success: FOLLOW.changeLinkToFollow()
    })
  },
  changeLinkToFollow: function(){
    FOLLOW.findOtherFollowLinks();
    FOLLOW.unfollowElement.text('Follow');
    FOLLOW.follow(FOLLOW.unfollowElement);
  },
  changeLinkToUnfollow: function(){
    FOLLOW.findOtherUnfollowLinks();
    FOLLOW.followElement.text('Unfollow');
    FOLLOW.unfollow(FOLLOW.followElement);
  },
  findOtherFollowLinks: function(){
    var href = FOLLOW.unfollowElement.attr('href');

    $("a[href='" + href + "']").each(function(){
      $(this).text('Follow');
      FOLLOW.follow($(this));
    });
  },
  findOtherUnfollowLinks: function(){
    var href = FOLLOW.followElement.attr('href');

    $("a[href='" + href + "']").each(function(){
      $(this).text('Unfollow');
      FOLLOW.unfollow($(this));
    });
  }
};

SITE = {
  common: {
    init: function () {
      FOLLOW.follow($('.follow-link'));
      FOLLOW.unfollow($('.unfollow-link'));
    }
  },
  users: {}
};

UTIL = {
  exec: function (controller, action) {
    var ns = SITE,
      action = (action === undefined) ? "init" : action;

    if (controller !== "" && ns[controller] && typeof ns[controller][action] == "function") {
      ns[controller][action]();
    }
  },

  init: function () {
    var body = document.body,
      controller = body.getAttribute("data-controller"),
      action = body.getAttribute("data-action");

    UTIL.exec("common");
    UTIL.exec(controller);
    UTIL.exec(controller, action);
  }
};

$(document).ready(UTIL.init);