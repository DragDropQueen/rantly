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
  changeFavoriteLinks: function () {
    var href = FAVORITE.unfavoriteElement.attr('href');

    $("a[href='" + href + "']").each(function () {
      FAVORITE.deincrementFavoriteCount(this);
      $(this).text('Favorite');
      FAVORITE.favorite($(this));
    });
  },
  changeUnfavoriteLinks: function () {
    var href = FAVORITE.favoriteElement.attr('href');

    $("a[href='" + href + "']").each(function () {
      FAVORITE.incrementFavoriteCount(this);
      $(this).text('Unfavorite');
      FAVORITE.unfavorite($(this));
    });
  },
  incrementFavoriteCount: function (element) {
    var div = $(element).siblings('span').find('#favorite-count');
    var count = (parseInt(div.attr('class')) + 1).toString();

    console.log(count);

    div.empty();

    div.append(count);
  },
  deincrementFavoriteCount: function (element) {
    var div = $(element).siblings('span').find('#favorite-count');
    var count = (div.attr('class'));

    div.empty();

    div.append(count)
  }
};

RANT = {
  rantPostHandler: function () {
    $('#rant-button').click(function (e) {
      e.preventDefault();
      e.stopPropagation();

      $('.error').empty();

      var url = $(this).parent('form').attr('action');

      $.post(url, RANT.produceJson(), function (rant) {
        RANT.clearFieldsAndSetFlash(rant)
      }).fail(function () {
        RANT.handleErrors()
      })
    })
  },
  clearFieldsAndSetFlash: function (rant) {
    RANT.postRant(rant);
    RANT.setFlash();
    $('#rant_rant').val('');
    $('#rant_title').val('');
  },
  produceJson: function () {
    return {rant: {
      rant: $('#rant_rant').val(),
      title: $('#rant_title').val()
    }}
  },
  setFlash: function () {
    $('.flash')
      .empty()
      .show()
      .append('Your rant has been posted!')
      .fadeOut(5000)
  },
  handleErrors: function () {
    if ($('#rant_rant').val() === '') {
      RANT.appendEmptyError($('.rant-error'));
    } else {
      RANT.validateRantLength();
    }

    if ($('#rant_title').val() === '') {
      RANT.appendEmptyError($('.title-error'));
    } else {
      RANT.validateTitleLength();
    }
  },
  appendEmptyError: function (element) {
    element.append("can't be blank")
  },
  validateTitleLength: function () {
    if ($('#rant_title').val().length > 50) {
      $('.title-error').append('is too long (maximum 50 characters)')
    }
  },
  validateRantLength: function () {
    if ($('#rant_rant').val().length < 140) {
      $('.rant-error').append('is too short (minimum 140 characters)')
    }
  },
  postRant: function (rant) {
    $.getJSON('/users/' + rant.user_id, function (user) {
      $('.dashboard-div').append(RANT.formatRant(rant, user));
      RANT.fadeInRant();
    })
  },
  formatRant: function (rant, user) {
    return '<div class="rant-wrapper" style="display: none">' +
      '<div class="rant-blurb">' +
      '<div class="left-blurb">' +
      '<a href="/users/' + user.id + '">' + user.first_name + '</a>' +
      '<img src="' + user.avatar + '" />' +
      '</div>' +
      '<a href="/rants/' + rant.id + '" class="right-blurb">' +
      rant.rant.substring(0, 300) +
      '... </a>' +
      '</div>' +
      '<p class="rant-link-container">' +
      '<a href="rants/' + rant.id + '" data-method="delete" rel="no-follow" class="rant-link">Delete</a>' +
      '</p>' +
      '</div>'
  },
  fadeInRant: function(){
    $('.rant-wrapper:last-child').fadeIn(3000);
  }
};

SITE = {
  common: {
    init: function () {
      FOLLOW.follow($('.follow-link'));
      FOLLOW.unfollow($('.unfollow-link'));

      FAVORITE.favorite($('.favorite-link'));
      FAVORITE.unfavorite($('.unfavorite-link'));

      RANT.rantPostHandler()
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