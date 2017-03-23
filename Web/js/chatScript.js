$(document).ready(function(){

    $('.chat_head').click(function(){
        $('.chat_body').slideToggle();
    });

    $('textarea').keypress(
       function(e){
          if (e.keyCode == 13) {
            e.preventDefault();
            var msg = $(this).val();
            $(this).val('');
            console.log(msg);
            $('.msg_body').scrollTop($('.msg_body')[0].scrollHeight);
        }
    });
});