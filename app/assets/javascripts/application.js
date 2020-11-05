// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about splusported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require_tree .

// 画像プレビュー機能
$(document).on('turbolinks:load', function() {
  $(function(){
    $('#item_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".image").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
    });
  });
});

// トグルメニュー領域外をクリック時、トグルを閉じる
$(document).on('click',function(e) {
   if(!$(e.target).closest('#navbarhamburger').length) {
     $('.navbar-collapse').collapse('hide');
   }
});

// items/new&editのプラスマイナスボタンで増減
$(document).on('turbolinks:load', function() {
  $(function(){
    $('#item_quantity').numberSpinner();
  });
});

// Web Speech API
$(document).on('turbolinks:load', function() {
  const speech = new webkitSpeechRecognition();
  speech.lang = 'ja-JP';

  //使用する変数を用意
  const button = document.getElementById('button');
  const item_name = document.getElementById('item_name');


  button.addEventListener('click' , function() {
      // 音声認識をスタート
      speech.start();
  });


  speech.addEventListener('result' , function(e) {
     console.log(e);

     item_name.value = e.results[0][0].transcript;
  });
});