/* =============================================================================
	jQuery Number Spinner ver1.0.3
	Copyright(c) 2015, ShanaBrian
	Dual licensed under the MIT and GPL licenses.
============================================================================= */
(function($) {
	$.fn.numberSpinner = function(options) {
		if ($(this).length === 0) return this;

		if ($(this).length > 1) {
			$.each(this, function() {
				$(this).numberSpinner(options);
			});
			return this;
		}

		var $element      = this,
			settings      = {},
			$upButton     = null,
			$downButton   = null,
			currentNumber = 0,
			checkNumber   = '';

		/**
		 * 初期化
		 */
		var init = function() {
			/*
				max             : 最大値（無制限の場合はfalse） [ number | false ]
				min             : 最小値（無制限の場合はfalse） [ number | false ]
				step            : 増減量 [ number ]
				numberFormat    : カンマ区切りにするかどうか [ true | false ]
				zeroPadding     : ゼロ埋めの桁数（無効の場合はfalse） [ number | false ]
				fixed           : 小数点の桁数を固定するかどうか [ number | false ]
				input           : キーボードやマウスでの入力を許可するかどうか [ true | false ]
				prefix          : 接頭語 [ string ]
				suffix          : 接尾語 [ string ]
				upButtonText    : 増加ボタンの文字列 [ string ]
				downButtonText  : 減少ボタンの文字列 [ string ]
				wrapClass       : 機能させる要素を囲う要素のクラス名 [ string ]
				buttonBoxClass  : 増減ボタンを囲う要素のクラス名 [ string ]
				upButtonClass   : 増加ボタンのクラス名 [ string ]
				downButtonClass : 減少ボタンのクラス名 [ string ]
				maxClass        : 最大値に達した場合に付与するクラス名 [ string ]
				minClass        : 最小値に達した場合に付与するクラス名 [ string ]
				error           : エラー時のクラス名 [ string ]
				buttonOutput    : ボタンの出力先 [ 'after' | 'before' | 'both-ends' | false ]
				upFunction      : 増加した時に実行する関数 [ function ]
				downFunction    : 減少した時に実行する関数 [ function ]
			*/
			settings = $.extend({
				max             : false,
				min             : 1,
				step            : 1,
				numberFormat    : false,
				zeroPadding     : false,
				fixed           : false,
				input           : true,
				prefix          : '',
				suffix          : '',
				upButtonText    : '+',
				downButtonText  : '-',
				wrapClass       : 'number-spinner',
				buttonBoxClass  : 'up-down-buttons',
				upButtonClass   : 'up',
				downButtonClass : 'down',
				maxClass        : 'maximum',
				minClass        : 'minimum',
				errorClass      : 'error',
				buttonOutput    : 'after',
				upFunction      : function() {},
				downFunction    : function() {}
			}, options);

			setup();
		};

		/**
		 * セットアップ
		 */
		var setup = function() {
			var $wrap      = $('<span>'),
				$buttonBox = $('<span>');

			$upButton   = $('#up')
			$downButton = $('#down')

			$wrap.addClass(settings.wrapClass);
			$buttonBox.addClass(settings.buttonBoxClass);
			$upButton.addClass(settings.upButtonClass);
			$downButton.addClass(settings.downButtonClass);

			$upButton.html(settings.upButtonText);
			$downButton.html(settings.downButtonText);

			currentNumber = resetNumber($element.val());

			setNumber(currentNumber);
			if (settings.min !== false && currentNumber < settings.min) {
				setNumber(settings.min);
			}
			if (settings.max !== false && currentNumber > settings.max) {
				setNumber(settings.max);
			}

			$buttonBox.append($upButton, $downButton);
			$element.wrap($wrap);

			if (settings.buttonOutput) {
				if (settings.buttonOutput === 'after') {
					$element.after($buttonBox);
				} else if (settings.buttonOutput === 'before') {
					$element.before($buttonBox);
				} else if (settings.buttonOutput === 'both-ends') {
					$element.after($downButton).before($upButton);
				}
			}

			setEvent();
			changeClass();

			if (!settings.input) $element.prop('readonly', true);
		};

		/**
		 * イベントの付与
		 */
		var setEvent = function() {
			var intervalId   = '',
				moveFlag     = false,
				intervalTime = 100,
				currentTime  = 100;

			/**
			 * 自動増減の実行
			 * @param {"add"|"sub"} mode 増加あるいは減少の指定
			 */
			var autoCalc = function(mode) {
				currentTime  = 100;
				intervalTime = 100;

				clearInterval(intervalId);

				intervalId = setTimeout(function() {
					if (moveFlag) startInterval(mode);
				}, 500);
			};

			/**
			 * 自動増減の開始
			 * @param {"add"|"sub"} mode 増加あるいは減少の指定
			 */
			var startInterval = function(mode) {
				clearInterval(intervalId);

				intervalId = setInterval(function() {
					if (mode === 'add') {
						$element.spinnerUp(settings.upFunction);
					} else if (mode === 'sub') {
						$element.spinnerDown(settings.downFunction);
					}

					if (currentTime % 1000 === 0 && intervalTime > 10) {
						intervalTime /= 1.2;
						startInterval(mode);
					} else if (intervalTime < 11 && intervalTime !== 10) {
						intervalTime = 10;
					}

					currentTime += 100;
				}, intervalTime);
			};

			/**
			 * Intervalをリセット
			 */
			var resetInterval = function() {
				moveFlag = false;
				clearInterval(intervalId);
			};

			if (settings.buttonOutput) {
				// 増加ボタン
				$upButton.on({
					'click' : function() {
						$element.spinnerUp(settings.upFunction);
						return false;
					},
					'mousedown' : function() {
						moveFlag = true;
						autoCalc('add');
					},
					'mouseup' : function() {
						resetInterval();
					},
					'mouseleave' : function() {
						clearInterval(intervalId);
					}
				});

				// 減少ボタン
				$downButton.on({
					'click' : function() {
						$element.spinnerDown(settings.downFunction);
						return false;
					},
					'mousedown' : function() {
						moveFlag = true;
						autoCalc('sub');
					},
					'mouseup' : function() {
						resetInterval();
					},
					'mouseleave' : function() {
						clearInterval(intervalId);
					}
				});
			}

			$element.on({
				'keydown' : function(e) {
					if (moveFlag) return true;

					var eventObj = e || event || null;

					if (!eventObj)  return true;

					var keyCode  = eventObj.keyCode || eventObj.which || '';

					moveFlag = true;

					if (!keyCode)  return true;

					if (keyCode === 38) {
						autoCalc('add');
					} else if (keyCode === 40) {
						autoCalc('sub');
					}
				},
				'keyup' : function(e) {
					var eventObj = e || event || null;

					if (!eventObj)  return true;

					var keyCode  = eventObj.keyCode || eventObj.which || '';

					if (!keyCode)  return true;

					if (keyCode === 38) {
						$element.spinnerUp(settings.upFunction);
					} else if (keyCode === 40) {
						$element.spinnerDown(settings.downFunction);
					}

					resetInterval();
				}
			});

			if (settings.input) {
				$element.on({
					'keyup' : function() {
						var setNumber = resetNumber($(this).val());
						if (settings.max !== false || settings.min !== false) {
							if (settings.max !== false && setNumber > settings.max) {
								setNumber = settings.max;
							}
							if (settings.min !== false && setNumber < settings.min) {
								setNumber = settings.min;
							}
						}
						currentNumber = setNumber;
					},
					'blur' : function() {
						var number = resetNumber($element.val());
						if (number === '') setNumber(currentNumber);
						checkNumber = number;

						checkErrorExec();
					}
				});
			}
		};

		/**
		 * フォーマットされた数字を数値に戻す
		 * @param {number} number 戻す数字
		 */
		var resetNumber = function(number) {
			var prefix = settings.prefix.replace(/([\.\$^\(\)\[\]])/, '\\$1'),
				suffix = settings.suffix.replace(/([\.\$^\(\)\[\]])/, '\\$1');

			number = String(number);

			if (settings.prefix && number.match(new RegExp('^' + prefix))) {
				number = number.replace(new RegExp('^' + prefix), '');
			}

			if (settings.suffix && number.match(new RegExp(suffix + '$'))) {
				number = number.replace(new RegExp(suffix + '$'), '');
			}

			return Number(number.replace(/[\\,]/g, ''));
		};

		/**
		 * クラス名切り替え
		 */
		var changeClass = function() {
			if (settings.max === false && settings.min === false) return;

			if (settings.max !== false && (currentNumber + settings.step) > settings.max) {
				$element.parent().addClass(settings.maxClass).removeClass(settings.minClass);
			} else if (settings.min !== false && (currentNumber - settings.step) < settings.min) {
				$element.parent().addClass(settings.minClass).removeClass(settings.maxClass);
			} else {
				$element.parent().removeClass(settings.maxClass).removeClass(settings.minClass);
			}
		};

		/**
		 * 数字の設定（書き出し）
		 * @param {*} number 設定する数字
		 */
		var setNumber = function(number) {
			var numberTmp = number;

			if (settings.fixed || settings.fixed === 0 && String(numberTmp).indexOf('.') !== -1) {
				numberTmp = String(numberTmp).slice(0, String(numberTmp).indexOf('.') + 1 + settings.fixed);
			}

			if (settings.zeroPadding) {
				numberTmp = zeroPadding(numberTmp, settings.zeroPadding);
			}

			if (settings.numberFormat && String(numberTmp).split('.')[0].length >= 4) {
				numberTmp = numberFormat(numberTmp);
			}

			$element.val(settings.prefix + numberTmp + settings.suffix);
		};

		/**
		 * エラーチェックの実行
		 */
		var checkErrorExec = function() {
			var isError = $element.checkError();
			if (!isError) {
				currentNumber = checkNumber;
				setNumber(currentNumber);
				$element.parent().removeClass(settings.errorClass);
			} else {
				$element.parent().addClass(settings.errorClass);
			}
		};

		/**
		 * 数字の書式設定（区切り）
		 * @param {number} number 数字
		 * @param {string} delimiter 区切り文字
		 * @return {string} 書式設定された文字列を返す
		 */
		var numberFormat = function(number, delimiter) {
			delimiter = delimiter || ',';

			if (isNaN(number)) return number;
			if (typeof delimiter !== 'string' || delimiter === '') return number;

			var reg = new RegExp(delimiter.replace(/\./, '\\.'), 'g');

			number = String(number).replace(reg, '');
			while (number !== (number = number.replace(/^(-?[0-9]+)([0-9]{3})/, '$1' + delimiter + '$2')));

			return number;
		};

		/**
		 * ゼロ埋め
		 * @param {number} number 埋める数値
		 * @param {number} digit 数字の桁数
		 * @return {string}
		 */
		var zeroPadding = function(number, digit) {
			var result = number;

			if (isNaN(number)) return number;

			var numberString = String(Math.abs(Number(number))),
				numberLength = numberString.split('.')[0].length,
				isMinus      = false;

			if (number < 0) isMinus = true;
			if (!digit) digit = 0;

			if (digit <= numberLength) return number;

			result = (new Array((digit - numberLength) + 1).join(0)) + numberString;

			return isMinus ? '-' + result : result;
		};

		/**
		 * 小数点以下の桁数を取得
		 * @param {number} number 数値
		 */
		var getDecimalPointLength = function(number) {
			var numbers = String(number).split('.'),
				result  = 0;

			if (numbers[1]) {
				result = numbers[1].length;
			}

			return result;
		};

		/**
		 * 加算（小数点以下の計算に誤差が発生する対策）
		 * @param {string} value1 現在の数字
		 * @param {string} value2 増加する数字
		 */
		var mathAddition = function(value1, value2) {
			var result = NaN;

			if ((value1 || value1 === 0) && (value2 || value2 === 0)) {
				var value1DpLen        = getDecimalPointLength(value1),
					value2DpLen        = getDecimalPointLength(value2),
					maxDpLen           = Math.max(value1DpLen, value2DpLen),
					decimalPointLength = Math.abs(value1DpLen - value2DpLen),
					value1Number       = Number(String(value1).replace('.', '')),
					value2Number       = Number(String(value2).replace('.', '')),
					isMinus            = false;

				if (value1DpLen > value2DpLen) {
					value2Number *= Math.pow(10, decimalPointLength);
				} else if (value1DpLen < value2DpLen) {
					value1Number *= Math.pow(10, decimalPointLength);
				}

				result = value1Number + value2Number;

				if (maxDpLen > 0) {
					if (maxDpLen >= String(result).length) {
						if (result < 0) {
							isMinus = true;
						}
						result = zeroPadding(Math.abs(result), maxDpLen + 1);
					}

					result = String(result).replace(new RegExp('([0-9]{' + maxDpLen + '})$'), '.$1');

					if (isMinus) result *= -1;
				}

				result = Number(result);
			}

			return result;
		};

		/**
		 * 減算（小数点以下の計算に誤差が発生する対策）
		 * @param {string} value1 現在の数字
		 * @param {string} value2 減少する数字
		 */
		var mathSubtraction = function(value1, value2) {
			var result = NaN;

			if ((value1 || value1 === 0) && (value2 || value2 === 0)) {
				var value1DpLen        = getDecimalPointLength(value1),
					value2DpLen        = getDecimalPointLength(value2),
					maxDpLen           = Math.max(value1DpLen, value2DpLen),
					decimalPointLength = Math.abs(value1DpLen - value2DpLen),
					value1Number       = Number(String(value1).replace('.', '')),
					value2Number       = Number(String(value2).replace('.', '')),
					isMinus            = false;

				if (value1DpLen > value2DpLen) {
					value2Number *= Math.pow(10, decimalPointLength);
				} else if (value1DpLen < value2DpLen) {
					value1Number *= Math.pow(10, decimalPointLength);
				}

				result = value1Number - value2Number;

				if (maxDpLen > 0) {
					if (maxDpLen >= String(result).length) {
						if (result < 0) isMinus = true;
						result = zeroPadding(Math.abs(result), maxDpLen + 1);
					}

					result = String(result).replace(new RegExp('([0-9]{' + maxDpLen + '})$'), '.$1');

					if (isMinus) result *= -1;
				}

				result = Number(result);
			}

			return result;
		};

		/**
		 * 増加（メソッド）
		 * @param {Function} [callback] コールバック関数
		 */
		$element.spinnerUp = function(callback) {
			if (settings.max === false || settings.max !== false && (currentNumber + settings.step) <= settings.max) {
				currentNumber = mathAddition(currentNumber, settings.step);

				setNumber(currentNumber);

				if (callback) callback.call(this, currentNumber);
			}

			changeClass();

			return this;
		};

		/**
		 * 減少（メソッド）
		 * @param {Function} [callback] コールバック関数
		 */
		$element.spinnerDown = function(callback) {
			if (settings.min === false || settings.min !== false && (currentNumber - settings.step) >= settings.min) {
				currentNumber = mathSubtraction(currentNumber, settings.step);

				setNumber(currentNumber);

				if (callback) callback.call(this, currentNumber);
			}

			changeClass();

			return this;
		};

		/**
		 * エラーチェック（メソッド）
		 */
		$element.checkError = function() {
			var number = String(checkNumber);

			if (!number) return true;
			if (!number.match(/^-?[0-9\.]+$/)) return true;

			if (settings.max !== false || settings.min !== false) {
				if (settings.max !== false && number > settings.max) {
					return true;
				}
				if (settings.min !== false && number < settings.min) {
					return true;
				}
			}

			return false;
		};

		init();

		return this;
	};
})(jQuery);
