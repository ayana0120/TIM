window.onload = function() {
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
};
