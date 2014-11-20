/**
 * Created by savannah on 10/30/14.
 */

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
    element.append("can't be blank");
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
    });
  },

  formatRant: function (rant, user) {

    return '<div class="rant-wrapper" style="display: none">' +
      '<h3>' + rant.title + '</h3>' +
      '<div class="rant-blurb">' +
      '<div class="left-blurb">' +
      '<a href="/users/' + user.id + '">' + user.first_name + '</a>' +
      '<img src="' + user.avatar + '" />' +
      '</div>' +
      '<a href="/rants/' + rant.id + '" class="right-blurb">' +
      marked(rant.rant.substring(0, 300)) +
      '</a>' +
      '</div>' +
      '<p class="rant-link-container">' +
      '<a href="rants/' + rant.id + '" data-method="delete" rel="no-follow" class="rant-link">Delete</a>' +
      '</p>' +
      '</div>'
  },

  linkHashtags: function(text) {
    var tags = text.scan(/#\w+/);

    tags.forEach(function(tag){
    })
  },

  fadeInRant: function () {
    $('.rant-wrapper:last-child').fadeIn(3000);
  },

  linkRantShow: function (elements) {
    elements.click(function () {
      var id = $(this).attr("id");
      document.location.href = "/rants/" + id;
    });
  }
};