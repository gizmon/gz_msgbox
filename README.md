# gz_msgbox - GizmoLabs による AutoCAD や AutoLISPが利用可能な 互換 CAD 用の各種のメッセージボックス関数
## ファイル：gz_msgbox.lsp gz_msgbox.dcl

## ダイアログの種類と対応する関数

------------------------------------------------------------------
ダイアログの種類      --- 対応する関数
------------------------------------------------------------------
- [OK]-[Cancel]         --- gz:lspOkCancel
- [Yes]-[No]            --- gz:lspYesNo
- [OK]                  --- gz:lspOkOnly
- [Yes]-[No]-[Cancel]   --- gz:lspYesNoCancel
- [OK]-[Cancel]         --- gz:lspRetryCancel

- 戻り値 OK=T、キャンセル=nil、No="F"

------------------------------------------------------------------
ダイアログの種類      --- 対応する関数
------------------------------------------------------------------
- [パスワード入力]      --- gz:lspGetPass
- [Inputbox]            --- gz:lspInputBox  (ボタンが横にあるタイプ)
-                       --- gz:lspInputBox2 (ボタンが下にあるタイプ)
- [Combobox]            --- gz:lspComboBox
- [Listbox]             --- gz:lspListBox
- [Listbox]             --- gz:lspListBoxMlti (複数選択可)

- 戻り値 OK=文字列、キャンセル=nil

------------------------------------------------------------------
ダイアログの種類      --- 対応する関数
------------------------------------------------------------------
- [フォルダ選択]        --- gz:lspbrowsefolder

- 戻り値 フォルダ名の文字列
------------------------------------------------------------------
- [popup] WSH の popup メソッドを使ったMSGボックス --- gz:popup

- 戻り値 OK=1,キャンセル=2, 中止=3, 再試行=4, 無視=5,  はい=6, いいえ=7, 再実行=10, 続行=11



[GizmoLabs Wiki] (https://wiki.gz-labs.net/index.php/Textlayer)
