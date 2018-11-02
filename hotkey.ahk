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

;右クリック + ホイール↑ = Ctrl + +
;右クリック + ホイール↓ = Ctrl + -

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

vk1Dsc07B & i:: Send, {Blind}-	;無変換 + i = ー

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

;無変換 + ; = 新規行を追加してそこに移動
vk1Dsc07B & `;::
Send, {End}
Send, {Enter}
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
;画面拡大 / 縮小
;--------------------------

; なぜか{Ctrl}だとうまくいかない
~RButton & WheelUp:: Send, ^{+}	;右クリック + ホイール↑ = 画面拡大
RButton & WheelDown:: Send, ^-	;右クリック + ホイール↓ = 画面縮小


;--------------------------
;テンキー
;--------------------------
vk1Dsc07B & a:: Send, {Blind}1 ;無変換 + a = 1
vk1Dsc07B & s:: Send, {Blind}2 ;無変換 + a = 2
vk1Dsc07B & d:: Send, {Blind}3 ;無変換 + a = 3
vk1Dsc07B & f:: Send, {Blind}4 ;無変換 + a = 4
vk1Dsc07B & g:: Send, {Blind}5 ;無変換 + a = 5
vk1Dsc07B & q:: Send, {Blind}6 ;無変換 + a = 6
vk1Dsc07B & w:: Send, {Blind}7 ;無変換 + a = 7
vk1Dsc07B & e:: Send, {Blind}8 ;無変換 + a = 8
vk1Dsc07B & r:: Send, {Blind}9 ;無変換 + a = 9
vk1Dsc07B & t:: Send, {Blind}0 ;無変換 + a = 0

;--------------------------
;その他
;--------------------------
;vkF0sc03A:: Send, {Blind}{Ctrl}

