;**************************
;ホットキー割り当て一覧
;**************************

;**************************

;変換 = IME OFF
;無変換 = IME ON

;無変換 + 変換 = BS
;無変換 + カタカナ / ひらがな = Del

;無変換 + n = ー
;無変換 + m = =
;無変換 + b = 行削除
;無変換 + . = 行コピー

;無変換 + h = ←
;無変換 + j = ↓
;無変換 + k = ↑
;無変換 + l = →
;無変換 + u = HOME
;無変換 + o = END

;右クリック + ホイール↑ = コピー
;右クリック + ホイール↓ = ペースト
;右クリック + 左クリック = 選択された文章を検索

;**************************

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode,2
#InstallKeybdHook
#UseHook

#include ime_func.ahk

;---Auto-executeセクション ここから---
GroupAdd,Group1,ahk_class Progman	;グループ化 デスクトップ
GroupAdd,Group1,ahk_class WorkerW	;グループ化 デスクトップ他
GroupAdd,Group1,ahk_class CabinetWClass	;グループ化 エクスプローラー
Return
;---Auto-executeセクション ここまで---

;--------------------------
;IME ON / OFF
;--------------------------

vk1Csc079::IME_ON("A")	;変換 = IME ON
vk1Dsc07B::IME_OFF("A")	;無変換 = IME OFF

;--------------------------
;Backspace, Delete
;--------------------------

vk1Dsc07B & vk1Csc079:: Send, {Blind}{BS}	;無変換 + 変換 = BS
vk1Dsc07B & vkF2sc070:: Send, {Blind}{Del}	;無変換 + カタカナ / ひらがな = Del

;--------------------------
;入力しづらい文字の割り当て
;--------------------------

vk1Dsc07B & n:: Send, -	;無変換 + n = ー
vk1Dsc07B & m:: Send, =	;無変換 + m = =

;--------------------------
;行編集
;--------------------------

;無変換 + b = 行削除
vk1Dsc07B & b::
Send,{Blind}{Home}+{End}
Send, {Del}
Send, {Del}
return

;無変換 + . = 行選択
vk1Dsc07B & .::
Send,{Blind}{Home}+{End}
return

;--------------------------
;カーソル移動
;--------------------------

vk1Dsc07B & h:: Send, {Blind}{Left}	;無変換 + h = ←
vk1Dsc07B & j:: Send, {Blind}{Down}	;無変換 + j = ↓
vk1Dsc07B & k:: Send, {Blind}{Up}	;無変換 + k = ↑
vk1Dsc07B & l:: Send, {Blind}{Right}	;無変換 + l = →
vk1Dsc07B & u:: Send, {Blind}{Home}	;無変換 + u = HOME
vk1Dsc07B & o:: Send, {Blind}{End}	;無変換 + o = END

;--------------------------
;コピー / ペースト
;--------------------------

~RButton & WheelUp:: Send, ^c	;右クリック + ホイール↑ = コピー
RButton & WheelDown:: Send, ^v	;右クリック + ホイール↓ = ペースト

RButton & LButton::search()	;右クリック + 左クリック = 選択された文章を検索



;----------------------------------------------------------
;検索関数
;ウェブのアドレスならそれを開く
;ディレクトリアドレスならエクスプローラで開く
;文字列ならGoogle検索
;ちなみにFirefoxはshiftを押しながら起動するとセーフモードになってしまうらしい
;----------------------------------------------------------

search(){
	bk = %ClipboardAll%						;今のクリップボードをバックアップ
	Clipboard = 
		Send,^{c}						;選択文字列をクリップボードにコピー
	SplitPath, Clipboard, name, dir, ext, noext, drive		;様々な指定形式に分割
	if(doWeb(Clipboard, drive, dir)){				;Webの場所を開く
	}else if(doLocal(drive, dir)){					;ローカルな場所を開く
	}
	Clipboard=%bk%							;元のクリップボードを復元
}
doWeb(str, drive, dir){
	isWeb := ""
	if((isWeb := isURL(drive, dir)) != ""){				;URL
	}else if((isWeb := isURLlike(Clipboard, drive, dir)) != ""){	;URLぽいもん
	}else{
		isWeb := getWebSearch(Clipboard)			;web検索
	}
	if(isWeb != ""){
		Run, %isWeb%
		return true
	}
	return false
}
isURL(drive, dir){
	if(InStr(drive, "http://") = 1 || InStr(drive, "https://") = 1){
		return %dir%
	}
	return ""
}
isURLlike(str, drive, dir){
	if(InStr(drive, "ttp://") = 1 || InStr(drive, "ttps://") = 1){
		return "h" . dir
	}else if(drive = "" && InStr(str, "www.") = 1){
		return, "http://" . str
	}
	return ""
}
getWebSearch(str){
	if(str != ""){
		return "http://www.google.com/search?q=" . str		;Google検索		
	}
	return ""
}
doLocal(drive, dir){
	if(drive != ""){
		Run, %dir%
		return true
	}
	return false
}