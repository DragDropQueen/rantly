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
    $.post(url).success(FOLLOW.changeFollowLinks());
  },
  deleteFollow: function (url) {
    $.ajax({
      url: url,
      method: 'DELETE',
      success: FOLLOW.changeUnfollowLinks()
    })
  },
  changeUnfollowLinks: function(){
    var href = FOLLOW.unfollowElement.attr('href');

    $("a[href='" + href + "']").each(function(){
      $(this).text('Follow');
      FOLLOW.follow($(this));
    });
  },
  changeFollowLinks: function(){
    var href = FOLLOW.followElement.attr('href');

    $("a[href='" + href + "']").each(function(){
      $(this).text('Unfollow');
      FOLLOW.unfollow($(this));
    });
  }
};

FAVORITE = {
  favoriteElement: null,
  unfavoriteElement: null,
  favorite: function (elements) {
    elements.one('click', function (e) {
      e.preventDefault();
      e.stopPropagation();

      FAVORITE.favoriteElement = $(this);
      url = $(this).attr('href');
      FAVORITE.postFavorite(url);
    })
  },
  unfavorite: function (elements) {
    elements.one('click', function (e) {
      e.preventDefault();
      e.stopPropagation();

      FAVORITE.unfavoriteElement = $(this);
      url = $(this).attr('href');
      FAVORITE.deleteFavorite(url);
    })
  },
  postFavorite: function (url) {
    $.post(url).success(FAVORITE.changeUnfavoriteLinks());
  },
  deleteFavorite: function (url) {
    $.ajax({
      url: url,
      method: 'DELETE',
      success: FAVORITE.changeFavoriteLinks()
    })
  },
  changeFavoriteLinks: function(){
    var href = FAVORITE.unfavoriteElement.attr('href');

    $("a[href='" + href + "']").each(function(){
      FAVORITE.deincrementFavoriteCount(this);
      $(this).text('Favorite');
      FAVORITE.favorite($(this));
    });
  },
  changeUnfavoriteLinks: function(){
    var href = FAVORITE.favoriteElement.attr('href');

    $("a[href='" + href + "']").each(function(){
      FAVORITE.incrementFavoriteCount(this);
      $(this).text('Unfavorite');
      FAVORITE.unfavorite($(this));
    });
  },
  incrementFavoriteCount: function(element){
    var div = $(element).siblings('span').find('#favorite-count');
    var count = (parseInt(div.attr('class')) + 1).toString();

    console.log(count);

    div.empty();

    div.append(count);
  },
  deincrementFavoriteCount: function(element){
    var div = $(element).siblings('span').find('#favorite-count');
    var count = (div.attr('class'));

    div.empty();

    div.append(count)
  }
};

SITE = {
  common: {
    init: function () {
      FOLLOW.follow($('.follow-link'));
      FOLLOW.unfollow($('.unfollow-link'));

      FAVORITE.favorite($('.favorite-link'));
      FAVORITE.unfavorite($('.unfavorite-link'));
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