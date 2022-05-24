;sort Процедура сортировки байтов
;Вход: invoke, addr param2, addr param1
;      param1 адресс массива размерность dw
;      param2 кол-во байт в массиве dw
;Меняет регистры esi edi ecx ebx eax
;Выход:
;#########################################################################
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
    .code
       sort proc public param2:DWORD, param1:DWORD		;
            mov edi,param2                        
            dec edi                            
            mov edx,edi                            		;в edx счетчик внешнего цикл-1
            xor ebx,ebx                                 ;если ebx=len-1 то прерываем внешний цикл и выходим
lbig:
            xor ecx,ecx                                 ;обнуляем ecx, который будет счетчиком внутреннего цикла
            mov ecx,param2                              ;в ecx кол-во байт массива
            mov esi,param1                              ;в esi АДРЕС массива
intloop:
            dec ecx                          
            jcxz extloop                                ;переход на внешний цикл если eсх=0
            mov word ptr ax,[esi]            
            cmp al,ah                                   ;иначе сравниваем текущий эл массива со следующим
            jc normsort                                 ;если сортировка не требуется (al<ah)то идем к следующему эл-ту
            xchg al,ah                                  ;иначе меняем эл местами
            mov [esi],ax    
            inc esi                                     ;переход к следующему эл
            jmp intloop                                 ;продолжаем внутренний цикл
normsort:                  
            inc ebx                                     ;увеличиваем ebx и
            cmp ebx,edi                                 ;сравниваем с количеством эл-ов массива
            je exit                                     ;если ebx=len-1 то прерываем внешний цикл и выходим
            inc esi                                     ;иначе переходим к следующему эл-ту
            jmp intloop
extloop:  ;внешний цикл если eсх=0
            xor ebx,ebx                                 ;сбрасываем счетчик преждевременного выхода
            dec edx                                     ;уменьшаем счетчик внешнего цикла
            cmp edx,0                                   ;если конец то выход
            jne lbig                                    ;иначе сортируем дальше
exit:       ret                                         ;эпилог и освобождаем 8 байт из стека  
            sort endp
            END