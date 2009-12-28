// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// search button effect
$(function() {
    $('#search_submit_button').click(function() {
                                       $(this).closest('form').submit();
                                     })
  });

// fade out div#flash
$(document).ready(function(){
                    $(".message.notice").fadeOut(2500);
                  });


// count 140 characters
$(function() {
    $('#flit_message').keydown(function() {
                                 var content_length = $(this).val().length;
                                 var remaining = 140 - content_length;
                                 $('#char_count').html(remaining);
                                 if (remaining < 21 && remaining > 9) {
                                   $('#chart_count').removeClass('red');
                                   $('#char_count').addClass('dark_red');
                                 } else if (remaining <= 9) {
                                   $('#chart_count').removeClass('dark_red');
                                   $('#char_count').addClass('red');
                                 } else {
                                   $('#char_count').removeClass('dark_red').removeClass('red');
                                 }
                               })
  });


// ticker
$(document).ready(function(){

                    var first = 7000;
                    var speed = 700;
                    var pause = 7000;

                    function removeFirst(){
                      first = $('ul#listticker li:first').html();
                      $('ul#listticker li:first')
                        .animate({opacity: 0}, speed)
                        .fadeOut('slow', function() {$(this).remove();});
                      addLast(first);
                    }

                    function addLast(first){
                      last = '<li style="display:none">'+first+'</li>';
                      $('ul#listticker').append(last)
                      $('ul#listticker li:last')
                        .animate({opacity: 1}, speed)
                        .fadeIn('slow')
                    }

                    interval = setInterval(removeFirst, pause);
                  });




// unfollow via ajax
$(function() {
  $('.ajax_button').click(function() {
    $.ajax({
      type: "POST",
      url: "/unfollow/" + $(this).attr('name'),
      success: function(msg){
        $('#' + msg).slideUp('slow');
      }
  });
})
});


/*
//follow via ajax
$(function() {
  $('.ajax_button').click(function() {
    $.ajax({
       type: "POST",
       url: "/" + $(this).attr('name') + "/follow_via_ajax",
       success: function(msg){
         elm = $('#btn_' + msg);
         if (elm.val() == "Follow") {
           elm.val("Follow");
         } else {
           elm.val("Unfollow");
         }
       }
     });
  })
});

*/

// Focus first element
$(document).ready(function() {
  $("input[type='text']:first", document.forms[0]).focus();
});

