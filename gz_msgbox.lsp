;;; �e��̃��b�Z�[�W�{�b�N�X�֐�
;;; �֘A�t�@�C���Fgz_msgbox.dcl

; �o�[�W����
(defun gz_msgbox_ver () (princ "\nGZ_MsgBox --- ver1.5 (MIT License)"))

;;; ------------------------------------------------------------------
;;; �_�C�A���O�̎��      --- �Ή�����֐�
;;; ------------------------------------------------------------------
;;; [OK]-[Cancel]         --- gz:lspOkCancel
;;; [Yes]-[No]            --- gz:lspYesNo
;;; [OK]                  --- gz:lspOkOnly
;;; [Yes]-[No]-[Cancel]   --- gz:lspYesNoCancel
;;; [OK]-[Cancel]         --- gz:lspRetryCancel
;;; 
;;; �߂�l OK=T�A�L�����Z��=nil�ANo="F"
;;; 
;;; ------------------------------------------------------------------
;;; �_�C�A���O�̎��      --- �Ή�����֐�
;;; ------------------------------------------------------------------
;;; [�p�X���[�h����]      --- gz:lspGetPass
;;; [Inputbox]            --- gz:lspInputBox  (�{�^�������ɂ���^�C�v)
;;;                       --- gz:lspInputBox2 (�{�^�������ɂ���^�C�v)
;;; [Combobox]            --- gz:lspComboBox
;;; [Listbox]             --- gz:lspListBox
;;; [Listbox]             --- gz:lspListBoxMlti (�����I����)
;;;
;;; �߂�l OK=������A�L�����Z��=nil
;;;
;;; ------------------------------------------------------------------
;;; �_�C�A���O�̎��      --- �Ή�����֐�
;;; ------------------------------------------------------------------
;;; [�t�H���_�I��]        --- gz:lspbrowsefolder
;;;
;;; �߂�l �t�H���_���̕�����
;;; ------------------------------------------------------------------
;;; [popup] WSH �� popup ���\�b�h���g����MSG�{�b�N�X --- gz:popup
;;; 
;;; �߂�l OK=1,�L�����Z��=2, ���~=3, �Ď��s=4, ����=5, 
;;;        �͂�=6, ������=7, �Ď��s=10, ���s=11
;;; 
;;; ------------------------------------------------------------------
; ���C�Z���X�iMIT License�j
; Copyright (c) 2020 Hiroki Sugihara
; 
; �ȉ��ɒ�߂�����ɏ]���A�{�\�t�g�E�F�A����ъ֘A�����̃t�@�C��
; �i�ȉ��u�\�t�g�E�F�A�v�j�̕������擾���邷�ׂĂ̐l�ɑ΂��A�\�t�g�E�F�A��
; �������Ɉ������Ƃ𖳏��ŋ����܂��B����ɂ́A�\�t�g�E�F�A�̕������g�p�A���ʁA
; �ύX�A�����A�f�ځA�Еz�A�T�u���C�Z���X�A�����/�܂��͔̔����錠���A�����
; �\�t�g�E�F�A��񋟂��鑊��ɓ������Ƃ������錠�����������Ɋ܂܂�܂��B

; ��L�̒��쌠�\������і{�����\�����A�\�t�g�E�F�A�̂��ׂĂ̕����܂��͏d�v��
; �����ɋL�ڂ�����̂Ƃ��܂��B

; �\�t�g�E�F�A�́u����̂܂܁v�ŁA�����ł��邩�Öقł��邩���킸�A�����
; �ۏ؂��Ȃ��񋟂���܂��B�����ł����ۏ؂Ƃ́A���i���A����̖ړI�ւ̓K�����A
; ����ь�����N�Q�ɂ��Ă̕ۏ؂��܂݂܂����A����Ɍ��肳�����̂ł͂���܂���B 
; ��҂܂��͒��쌠�҂́A�_��s�ׁA�s�@�s�ׁA�܂��͂���ȊO�ł��낤�ƁA
; �\�t�g�E�F�A�ɋN���܂��͊֘A���A���邢�̓\�t�g�E�F�A�̎g�p�܂��͂��̑���
; �����ɂ���Đ������؂̐����A���Q�A���̑��̋`���ɂ��ĉ���̐ӔC������Ȃ�
; ���̂Ƃ��܂��B
;;; ------------------------------------------------------------------

(defun msgchk (m /)
; ���b�Z�[�W�̕�����`�F�b�N�B
; �P���ȕ����񂾂����烊�X�g������B
; �����񃊃X�g�́A4�܂ŋ󕶎��ǉ��B
  (if (and (/= 'STR  (type m)) (/= 'LIST (type m)))
    (setq m '("not strings")))
  (if (= 'STR (type m)) (setq m (list m)))
  (while (<= (length m) 4) (setq m (append m '(""))))
m)

(defun gz:LispEd (txt / dcl_id dcl state)
; �V���v����1�s�̕�����ҏW�_�C�A���O�R�}���h�iautocad �� lisped �֐��Ώ��p�j
; ���͂��ꂽ�������Ԃ�
; ���b�Z�[�W���x���t���������Ȃ� gz:lspInputBox ���g���܂��傤�B
; ex. (gz:LispEd "txt")
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog "LspEd" dcl_id)) (exit))
  (set_tile "contents" txt)
  (mode_tile "contents" 2)
  (action_tile "contents" "(setq txt $value)")
  (action_tile "accept" "(done_dialog 1)")
  (setq state (start_dialog))
  (unload_dialog dcl_id)
  (cond
    ((= state 1) txt)
    ((= state 2) -1)
    (t 0)
  )
)

(defun gz:lspOkCancel (title msg1 / result dcl_id)
; title = �_�C�A���O�̃^�C�g��������
; msg1 = ���b�Z�[�W������܂��͕�����̃��X�g ("���b�Z�[�W1" "���b�Z�[�W2" "���b�Z�[�W3")
;        3�ڈȍ~�͖��������
; �߂�l : T or nil
; ex. (gz:lspOkCancel "������1" "OK-Cancel ���b�Z�[�W�{�b�N�X")
  (setq msg1 (msgchk msg1))
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog "lspOkCancel" dcl_id))  (exit))
  (set_tile "message1" (car msg1))
  (set_tile "message2" (cadr msg1))
  (set_tile "message3" (caddr msg1))
  (set_tile "main" title)
  (action_tile "cancel" "(done_dialog) (setq result nil)")
  (action_tile "accept" "(done_dialog) (setq result T)")
  (start_dialog)
  (unload_dialog dcl_id)
result)

(defun gz:lspYesNo (main msg1 / result dcl_id)
; (gz:lspYesNo "������1" "Yes-No ���b�Z�[�W�{�b�N�X")
; �߂�l : T or "F"
  (setq msg1 (msgchk msg1))
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog "lspYesNo" dcl_id))  (exit))
  (set_tile "message1" (car msg1))
  (set_tile "message2" (cadr msg1))
  (set_tile "message3" (caddr msg1))
  (set_tile "main" main)
  (action_tile "no"  "(done_dialog) (setq result \"F\")")
  (action_tile "yes" "(done_dialog) (setq result T)" )
  (start_dialog)
  (unload_dialog dcl_id)
result)

(defun gz:lspOkOnly (main msg1 / dcl_id)
; (lspOkOnly "������1" "OK �̂݃��b�Z�[�W�{�b�N�X")
; �߂�l : T �̂�
  (setq msg1 (msgchk msg1))
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog "lspOkOnly" dcl_id)) (exit) )
  (set_tile "message1" (car msg1))
  (set_tile "message2" (cadr msg1))
  (set_tile "message3" (caddr msg1))
  (set_tile "main" main)
  (action_tile "yes" "(done_dialog)")
  (start_dialog)
  (unload_dialog dcl_id)
T)

(defun gz:lspYesNoCancel (main msg1 / result dcl_id)
;(gz:lspYesNoCancel "������1" "Yes-No-Cancel ���b�Z�[�W�{�b�N�X")
; �߂�l : T or nil or  "F"
  (setq msg1 (msgchk msg1))
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog "lspYesNoCancel" dcl_id))    (exit)  )
  (set_tile "message1" (car msg1))
  (set_tile "message2" (cadr msg1))
  (set_tile "message3" (caddr msg1))
  (set_tile "main" main)
  (action_tile "no"  "(done_dialog) (setq result \"F\")")
  (action_tile "yes" "(done_dialog) (setq result T)" )
  (action_tile "cancel" "(done_dialog) (setq result nil)")
  (start_dialog)
  (unload_dialog dcl_id)
result)

(defun gz:lspRetryCancel (main msg1 / result dcl_id)
; (gz:lspRetryCancel "lspRetryCancel" "lspRetryCancel�{�b�N�X")
; �߂�l : T or nil
  (setq msg1 (msgchk msg1))
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog "lspRetryCancel" dcl_id))    (exit)  )
  (set_tile "message1" (car msg1))
  (set_tile "message2" (cadr msg1))
  (set_tile "message3" (caddr msg1))
  (set_tile "main" main)
  (action_tile "cancel" "(done_dialog) (setq result nil)")
  (action_tile "retry" "(done_dialog) (setq result T)")
  (start_dialog)
  (unload_dialog dcl_id)
result)

(defun gz:lspGetPass (main msg1 / result dcl_id)
; (gz:lspGetPass "���b�Z�[�W1" "lspGetPass �{�b�N�X")
; �߂�l : �p�X���[�h�̕����� or nil
  (setq msg1 (msgchk msg1))
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog "lspGetPass" dcl_id))    (exit)  )
  (set_tile "message1" (car msg1))
  (set_tile "message2" (cadr msg1))
  (set_tile "message3" (caddr msg1))
  (set_tile "main" main)
  (action_tile "password" "(setq result $value)") 
  (action_tile "cancel" "(done_dialog) (setq result nil)")
  (action_tile "accept" "(done_dialog)")
  (start_dialog)
  (unload_dialog dcl_id)
result)

(defun gz:lspInputBox (main msg1 / result dcl_id)
; ex. (gz:lspInputBox "�Ȃ񂩓��͂���" "�C���v�b�g�{�b�N�X")
; �߂�l : �e�L�X�g�{�b�N�X�̕����� or nil
  (setq msg1  (msgchk msg1) 
        result "")
  (while (= "" result)
    (setq dcl_id (load_dialog "gz_msgbox.dcl"))
    (if (not (new_dialog "lspInputBox" dcl_id))    (exit)  )
    (set_tile "message1" (car msg1))
    (set_tile "message2" (cadr msg1))
    (set_tile "message3" (caddr msg1))
    (set_tile "message4" (nth 3 msg1))
    (set_tile "main" main)
    (action_tile "textbox" "(setq result $value)") 
    (action_tile "cancel" "(done_dialog) (setq result nil)")
    (action_tile "accept" "(done_dialog)")
    (start_dialog)
    (unload_dialog dcl_id)
  )
result)

(defun gz:lspInputBox2 (main msg1 def / result dcl_id)
; ex. (gz:lspInputBox2 "�Ȃ񂩓��͂���" "�C���v�b�g�{�b�N�X" "�����l")
; �߂�l : �e�L�X�g�{�b�N�X�̕����� or nil
  (setq msg1  (msgchk msg1) 
        result "")
  (while (= "" result)
    (setq dcl_id (load_dialog "gz_msgbox.dcl"))
    (if (not (new_dialog "lspInputBox2" dcl_id))    (exit)  )
    (set_tile "message1" (car msg1))
    (set_tile "message2" (cadr msg1))
    (set_tile "message3" (caddr msg1))
    (set_tile "message4" (nth 3 msg1))
    (set_tile "textbox"  def)
    (set_tile "main" main)
    (action_tile "textbox" "(setq result $value)") 
    (action_tile "cancel" "(done_dialog) (setq result nil)")
    (action_tile "accept" "(done_dialog)")
    (start_dialog)
    (unload_dialog dcl_id)
  )
result)

(defun gz:lspComboBox (main msg1 lst / result dcl_id)
; ex. (gz:lspComboBox "xxxx�Ȃ�őI���" "�R���{�{�b�N�X" '("aaa" "AA" "������" "������" "1234567890"))
; �߂�l : �|�b�v�A�b�v���X�g�̒l or nil
  (setq msg1  (msgchk msg1) 
        result "")
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog "lspCombobox" dcl_id))    (exit)  )
  (set_tile "main" main)
  (set_tile "message1" (car msg1))
  (set_tile "message2" (cadr msg1))
  (set_tile "message3" (caddr msg1))
  (start_list "poplist")                   ; �|�b�v�A�b�v���X�g�̒ǉ�
    (mapcar 'add_list lst)
  (end_list)
  (set_tile "poplist" "0")
  (action_tile "poplist" "(setq result $value)") 
  (action_tile "cancel" "(setq result nil) (done_dialog)")
  (action_tile "accept" "(setq result (get_tile \"poplist\")) (done_dialog) ")
  (start_dialog)
  (unload_dialog dcl_id)
result)

(defun gz:lspListBox (main msg1 lst / result dcl_id)
; ex. (gz:lspListBox "xxxx�Ȃ񂩑I���" "���X�g" '("aaa" "AA" "������" "������" "1234567890"))
; �߂�l : �I���������X�g�{�b�N�X�C���f�b�N�X�l�̕����� or nil    ex. "2"
; ���� msg1 �� "lspListbox0 �̏ꍇ "���b�Z�[�W�����^�C�v" �ŕ\��
  (setq dcltype (if msg1 "lspListbox" "lspListbox0"))
  (setq msg1  (msgchk msg1) 
        result "")
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog dcltype dcl_id))  (exit))
  (set_tile "main" main)
  (set_tile "message1" (car msg1))
  (set_tile "message2" (cadr msg1))
  (set_tile "message3" (caddr msg1))
  (start_list "listbox")                   ; ���X�g�̒ǉ�
    (mapcar 'add_list lst)
  (end_list)
  (set_tile "listbox" "0")
  (action_tile "listbox" "(setq result $value)")
  (action_tile "cancel" "(setq result nil) (done_dialog)")
  (action_tile "accept" "(setq result (get_tile \"listbox\")) (done_dialog) ")
  (start_dialog) 
  (unload_dialog dcl_id)
  
result)

(defun gz:lspListBoxMulti (main msg1 lst / dcltype msg2 result dcl_id)
; msg1 = nil �Ȃ� ���b�Z�[�W�����^�C�v�̃_�C�A���O��ǂݍ���
; ex. (gz:lspListBoxMulti "�����I��ł�" "���X�g" '("aaa" "AA" "������" "������" "1234567890"))
; ex. (gz:lspListBoxMulti "�����I��ł�" nil '("aaa" "AA" "������" "������" "1234567890"))
; �߂�l : �I���������X�g�{�b�N�X�C���f�b�N�X�l�̕�����(�X�y�[�X��؂�) or nil
; ex. "2 3 6"

  ;"lspListboxMulti0 = ���b�Z�[�W�����^�C�v"
  (setq dcltype (if msg1 "lspListboxMulti" "lspListboxMulti0"))
  (setq msg2  (msgchk msg1) 
        result "")
  (setq dcl_id (load_dialog "gz_msgbox.dcl"))
  (if (not (new_dialog dcltype dcl_id))  (exit))
  (set_tile "main" main)
  (if msg1 (progn
    (set_tile "message1" (car msg2))
    (set_tile "message2" (cadr msg2))
    (set_tile "message3" (caddr msg2))
  ))
  (start_list "listbox")                   ; ���X�g�̒ǉ�
	(mapcar 'add_list lst)
  (end_list)
  (action_tile "listbox" "(setq result $value)")
  (action_tile "cancel" "(setq result nil) (done_dialog)")
  (action_tile "accept" "(setq result (get_tile \"listbox\")) (done_dialog) ")
  (start_dialog) 
  (unload_dialog dcl_id)
  
  ; �X�y�[�X��؂�̕����񂪕Ԃ��Ă��邪�A�ȉ��̌`�Ń��X�g���ł���
  (setq ret_list (read (strcat "(" result ")" )))
  ; �I�����ꂽ���ڂ����̃��X�g��Ԃ�
  (mapcar '(lambda (x) (nth x lst))  ret_list)
)

;;; ------------------------------------------------------------------
(defun gz:lspbrowsefolder (title folder / shlobj fldobj)
; �t�H���_�I���_�C�A���O�̊֐�
; �߂�l�F�I�������t�H���_�̃p�X
; ex. (gz:lspbrowsefolder "�����̃t�H���_��I��" nil)
; 
  (vl-load-com)
  (setq shlobj (vla-getinterfaceobject
                 (vlax-get-acad-object)  "Shell.Application")
        folder (vlax-invoke-method 
                  shlobj 
                   'browseforfolder 
                   0 
                   title 
                   (+ 4 16 64 256 32768) ; �t�H���_�Q�Ƃ̓���I�v�V����
                   folder)
  )
  (vlax-release-object shlobj)
  (if folder
    (progn
      (setq fldobj (vlax-get-property folder 'self)
            folderName (vlax-get-property fldobj 'path) )
      (vlax-release-object folder)
      (vlax-release-object fldobj)
      folderName
)))

;;; ------------------------------------------------------------------
(defun GZ:popup ( title msg bit / wsh rtn )
; WSH �̃|�b�v�A�b�v���\�b�h�ɂ��郁�b�Z�[�W�{�b�N�X�̃��b�p�[�B
;; title �c �^�C�g���̕�����
;; msg   �c ���b�Z�[�W�{�b�N�X�̕�����
;; bit   �c [INT] �r�b�g���������ꂽ�A�C�R���E�{�^���̊O�ς���������
;; �߂�l�F[INT] �����ꂽ�{�^������������

; ex. (GZ:popup "�^�C�g��������" "���b�Z�[�W������B" (+ 2 48 4096))
;     -> 1
;;; 'bit' �̃��t�@�����X
;;; �{�^��
;;; �l 	���e
;;; 0 	OK �{�^���\��
;;; 1 	OK�ACancel �{�^���\��
;;; 2 	Abort�ARetry�AIgnore �{�^���\��
;;; 3 	Yes,�ANo�A Cancel �{�^���\��
;;; 4 	Yes�ANo �{�^���\��
;;; 5 	Retry�ACancel �{�^���\��
;;; 6 	Cancel�ATry Again�AContinue �{�^���\��
;;;
;;; �A�C�R��
;;; �l	���e
;;; 16 	Stop �A�C�R���\��
;;; 32 	Question �A�C�R���\��
;;; 48 	Exclamation �A�C�R���\��
;;; 64 	Information �A�C�R���\��
;;;
;;; ���̑�
;;; �l 	���e
;;; 256 	��2�{�^�����f�t�H���g�ɁB
;;; 512 	��3�{�^�����f�t�H���g�ɁB
;;; 4096 	���b�Z�[�W�{�b�N�X�́A�V�X�e�����[�_�����b�Z�[�W�{�b�N�X�ł���A��ԏ�̃E�B���h�E�ɕ\������܂��B
;;; 524288 	�e�L�X�g���E�񂹂ŕ\��
;;; 1048576 	�e�L�X�g���E����ŕ\��
;;; 
;;; �߂�l
;;; �֘A����{�^���������ă��b�Z�[�W�{�b�N�X�����Ƃ��ɐ����l���Ԃ����B
;;; �l 	���eDescription
;;; 1 	OK �{�^�����N���b�N���ꂽ�B
;;; 2 	Cancel�i�L�����Z���j �{�^�����N���b�N���ꂽ�B
;;; 3 	Abort�i���~�j �{�^�����N���b�N���ꂽ�B
;;; 4 	Retry�i�Ď��s�j �{�^�����N���b�N���ꂽ�B
;;; 5 	Ignore(����) �{�^�����N���b�N���ꂽ�B
;;; 6 	Yes �{�^�����N���b�N���ꂽ�B
;;; 7 	No �{�^�����N���b�N���ꂽ�B
;;; 10 	Try Again�i�Ď��s�j �{�^�����N���b�N���ꂽ�B
;;; 11 	Continue�i���s�j �{�^�����N���b�N���ꂽ�B
;;;
;;; ���� : IJCAD ���ƌĂяo��������ł͂Ȃ��̂��A�C�R���Ȃ� OK�{�^���݂̂̓���ɂȂ�B2013�`2020
  (if (setq wsh (vlax-create-object "wscript.shell"))
    (progn
      (setq rtn (vl-catch-all-apply 'vlax-invoke-method (list wsh 'popup msg 0 title bit)))
      (vlax-release-object wsh)
      (if (not (vl-catch-all-error-p rtn)) rtn)
)))

;;; ------------------------------------------------------------------
(defun gz_msgbox_test (/ result)
  ; gz_msgbox �֘A�֐��̃e�X�g ���s�����ʕ\������ʂ�s��
  (setq msg1 '("���b�Z�[�W1" "���b�Z�[�W2" "���b�Z�[�W3")
        lst1 '("aaa" "AA" "������" "������" "1234567890"))

  (setq result (gz:lspOkCancel "OK-Cancel ���b�Z�[�W�{�b�N�X" msg1))
  (alert (if (= T result) "OK" "�L�����Z��"))
  (setq result (gz:lspYesNo "Yes-No ���b�Z�[�W�{�b�N�X" msg1 ))
  (alert (if (= T result) "Yes" "No"))
  (setq result (gz:lspokonly "OK Only ���b�Z�[�W�{�b�N�X" msg1 ))
  (alert (if (= T result) "OK" "�G���["))
  (setq result (gz:lspRetryCancel "Retry-Cancel ���b�Z�[�W�{�b�N�X" msg1 ))
  (alert (if (= T result) "���g���C" "�L�����Z��"))
  (setq result (gz:lspGetPass  "GetPass ���b�Z�[�W�{�b�N�X" msg1 ))
  (alert (strcat "�p�X���[�h��" result))
  (setq result (gz:lisped "�V���v����������" ))
  (alert (if (= nil result) "�L�����Z��" result))
  (setq result (gz:lspInputBox "�C���v�b�g�{�b�N�X" msg1 ))
  (alert (if (= nil result) "�L�����Z��" result))
  (setq result (gz:lspInputBox2 "�C���v�b�g�{�b�N�X" msg1 "�����l"))
  (alert (if (= nil result) "�L�����Z��" result))
  (setq result (gz:lspComboBox "�R���{�{�b�N�X" msg1 lst1))
  (alert (if (= nil result) '("�L�����Z��") result))
  (setq result (gz:lspListBox "���X�g�{�b�N�X" msg1 lst1))
  (alert (if (= nil result) "�L�����Z��" result))
  (setq result (gz:lspListBoxMulti "�����I�����X�g�{�b�N�X" msg1 lst1))
  (if (= nil result) (prompt "\n�L�����Z��") (progn (apply 'strcat result)))
  (setq result (gz:lspListBoxMulti "�����I�����X�g�{�b�N�X" nil lst1))
  (if (= nil result) (prompt "\n�L�����Z��") (progn (apply 'strcat result)))
  (setq result (gz:lspbrowsefolder "�����̃t�H���_��I��" nil))
  (alert (if (= nil result) "�L�����Z��" result))
  (setq result (GZ:popup "�|�b�v�A�b�v���b�Z�[�W" "OK �{�^��" (+ 0 48 4096)))
  (alert (if (= nil result) "�L�����Z��" (itoa result)))
  (setq result (GZ:popup "�|�b�v�A�b�v���b�Z�[�W" "OK�A�L���Z�� �{�^��" (+ 1 48 4096)))
  (alert (if (= nil result) "�L�����Z��" (itoa result)))
  (setq result (GZ:popup "�|�b�v�A�b�v���b�Z�[�W" "���~�A�Ď��s�A���� �{�^��" (+ 2 48 4096)))
  (alert (if (= nil result) "�L�����Z��" (itoa result)))
  (setq result (GZ:popup "�|�b�v�A�b�v���b�Z�[�W" "�͂��A�������A�L�����Z�� �{�^��" (+ 3 48 4096)))
  (alert (if (= nil result) "�L�����Z��" (itoa result)))
  (setq result (GZ:popup "�|�b�v�A�b�v���b�Z�[�W" "�͂��A������ �{�^��" (+ 4 48 4096)))
  (alert (if (= nil result) "�L�����Z��" (itoa result)))
  (setq result (GZ:popup "�|�b�v�A�b�v���b�Z�[�W" "�Ď��s �L�����Z�� �{�^��" (+ 5 48 4096)))
  (alert (if (= nil result) "�L�����Z��" (itoa result)))
  (setq result (GZ:popup "�|�b�v�A�b�v���b�Z�[�W" "�L�����Z���A�Ď��s ���s �{�^��" (+ 6 48 4096)))
  (alert (if (= nil result) "�L�����Z��" (itoa result)))
  (princ)
)

(gz_msgbox_ver) (princ)