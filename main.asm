.586
      .model flat, stdcall
      option casemap :none                                  
;#########################################################################
      include \masm32\include\windows.inc
      include \masm32\include\user32.inc
      include \masm32\include\kernel32.inc
      includelib \masm32\lib\user32.lib
      includelib \masm32\lib\kernel32.lib
;#########################################################################
      extern sort@8:near												;@8 принимает 8 байт в стек,
    .data																;near прямая адресация
      unsort  db "это проверка процедуры сортировки. Она сортирует байты",0 ;несортированный массив
      len= $-unsort-1													;длина массива-1 т.к. убираем ноль в конце
      title1 db "до сортировки",0
      title2 db "после сортировки",0                                                 
;#########################################################################
    .code
 start:
 	invoke MessageBox, NULL, offset unsort, offset title1 , MB_OK
    mov edx,len
    push offset unsort
    push edx
    call sort@8     												;@8 masm сама отчистит стек 
    invoke MessageBox, NULL, addr unsort, addr title2 , MB_OK
exit:
    invoke ExitProcess, 0              
 end start