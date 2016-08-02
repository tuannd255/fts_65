// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

var flash = function(){
  setTimeout(function(){
    $('.alert').slideUp(500);
  }, 2000);
  var x = $(window).height();
  var y = x - 60;
  $('.content').css('min-height', x);
  $('.page-content').css('min-height', x);
  $('.signin').css('min-height', y);
};

$(document).ready(flash);
$(document).on('page:load', flash);
$(document).on('page:change', flash);

var add = function() {
  $('form').on('click', '.remove_fields', function(event) {
    $(this).closest('.field').remove();
    return event.preventDefault();
  });
  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
    checkbox();
  });
};

$(document).on('page:change', add);

function addForm() {
  var association = 'answers';
  var regexp = new RegExp('new_' + association, 'g');
  var new_id = new Date().getTime();
  $('.add_answer').before(window[association + '_field'].
    replace(regexp, new_id));
  $('.correct-choose').hide();
  $('.remove-choose').hide();
  $('.add_answer').hide();
}

function changeType() {
  var options = $('.field');
  for(i = 0; i < options.length; i++){
    $(options[i].querySelector('.remove-choose > a')).
      prev('input[type=hidden]').val('1');
    $(options[i].querySelector('.remove-choose > a')).addClass('hidden');
  }
  options.addClass('hidden');
}
var prev;
$(document).on('focus', '.question-type', function() {
  prev = this.value;
});

function remove_fields(link) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest('.field').hide();
}

$(document).on('change load', '.question-1 .question-type', function() {
   if($(this).val() == 'single_choice') {
    $('input[type="checkbox"]').prop('checked', false);
    changeType();
    $('.add_answer').show();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', false);
    })
    if(prev == 'text'){
      changeType();
    }
  } else if($(this).val() == 'multiple_choice') {
    $('input[type="checkbox"]').prop('checked', false);
    changeType();
    $('.add_answer').show();
    if(prev == 'text'){
      changeType();
    }
  } else if($(this).val() == 'text') {
    var x = $(this).val();
    changeType();
    addForm();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', true);
    })
  }
  prev = $(this).val();
});

var remote = function(){
  $('.td-question form').on('click', '.add_field', function(){
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });
};

var check_single = function() {
  var type = $('.question-type').val();
  if(type == 'single_choice'){
    $('input[type="checkbox"]').on('click', function() {
      $('input[type="checkbox"]').not(this).prop('checked', false);
    })
  }
  else if(type == 'text'){
    $('.correct-choose').hide();
    $('.remove-choose').hide();
    $('.add_answer').hide();
  }
};

$(document).on('change', check_single);
$(document).on('load', check_single);

$(document).on('change load', '.question-2 .question-type', function() {
  if($(this).val() == 'single_choice') {
    $('input[type="checkbox"]').prop('checked', false);
    $('.add_answer').show();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', false);
    });
    if(prev == 'text'){
      changeType();
    }
  } else if ($(this).val() == 'multiple_choice') {
    $('input[type="checkbox"]').prop('checked', false);
    $('.add_answer').show();
    if(prev == 'text'){
      changeType();
    }
  } else if($(this).val() == 'text') {
    var x = $(this).val();
    changeType();
    addForm();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', true);
    })
  }
  prev = $(this).val();
});
