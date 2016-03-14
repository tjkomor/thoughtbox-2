$(document).ready(function () {
  readStatus();
  sortTitle();
  sortReadStatus();
  searchLinks();
});

var readStatus = function () {
  $('tr').delegate('#read', 'click', function() {
    $link = $(this).closest('tr');
    toggleReadStatus($link.data('id'));
    $link.toggleClass('true');
    if ($link.hasClass('true')) {
      $(this).text('Yes');
    } else {
      $(this).text('No');
    }
  });
};

var toggleReadStatus = function (id) {
  $.ajax({
    type: 'PATCH',
    url: '/api/v1/links/' + id,
    success: function() {
      console.log("success");
    }
  });
};

var sortTitle = function () {
  $('.sortTitle').on('click', function() {
    var $links = $('.link');
    alphabeticalSort = $links.sort(function (first, second) {
      first = $(first).data('title').toLowerCase();
      second = $(second).data('title').toLowerCase();
      if (first < second) return -1;
      if (first > second) return 1;
      return 0;
    });
    $links.remove();
    $('.table').append(alphabeticalSort);
    readStatus();
  });
};

var sortReadStatus = function () {
  $('.sortReadStatus').on('click', function() {
    var $links = $('.link');
    sortedLinks = $links.sort(function (first, second) {
      first = $(first).hasClass('true');
      second = $(second).hasClass('true');
      if (first < second) return -1;
      if (first > second) return 1;
      return 0;
    });
    $links.remove();
    $('.table').append(sortedLinks);
    readStatus();
  });
};

var searchLinks = function() {
  $('#search').on('keyup', function (e) {
    var searchTerm = $('#search').val().toLowerCase();
    var $links = $('.link');
    $links.hide();
    var filteredLinks = _.filter($links, function(link) {
      return $(link).data('title').toLowerCase().includes(searchTerm);
    });
    $(filteredLinks).show();
    if (searchTerm === null) { $links.show(); }
  });
};
