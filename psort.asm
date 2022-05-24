;sort ��������� ���������� ������
;����: invoke, addr param2, addr param1
;      param1 ������ ������� ����������� dw
;      param2 ���-�� ���� � ������� dw
;������ �������� esi edi ecx ebx eax
;�����:
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
            mov edx,edi                            		;� edx ������� �������� ����-1
            xor ebx,ebx                                 ;���� ebx=len-1 �� ��������� ������� ���� � �������
lbig:
            xor ecx,ecx                                 ;�������� ecx, ������� ����� ��������� ����������� �����
            mov ecx,param2                              ;� ecx ���-�� ���� �������
            mov esi,param1                              ;� esi ����� �������
intloop:
            dec ecx                          
            jcxz extloop                                ;������� �� ������� ���� ���� e��=0
            mov word ptr ax,[esi]            
            cmp al,ah                                   ;����� ���������� ������� �� ������� �� ���������
            jc normsort                                 ;���� ���������� �� ��������� (al<ah)�� ���� � ���������� ��-��
            xchg al,ah                                  ;����� ������ �� �������
            mov [esi],ax    
            inc esi                                     ;������� � ���������� ��
            jmp intloop                                 ;���������� ���������� ����
normsort:                  
            inc ebx                                     ;����������� ebx �
            cmp ebx,edi                                 ;���������� � ����������� ��-�� �������
            je exit                                     ;���� ebx=len-1 �� ��������� ������� ���� � �������
            inc esi                                     ;����� ��������� � ���������� ��-��
            jmp intloop
extloop:  ;������� ���� ���� e��=0
            xor ebx,ebx                                 ;���������� ������� ���������������� ������
            dec edx                                     ;��������� ������� �������� �����
            cmp edx,0                                   ;���� ����� �� �����
            jne lbig                                    ;����� ��������� ������
exit:       ret                                         ;������ � ����������� 8 ���� �� �����  
            sort endp
            END