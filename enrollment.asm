
default rel

extern printf
extern scanf
extern getchar

global main

section .data

header:
    db 10,"============================================================",10
    db "              STUDENT ENROLLMENT ASSESSMENT",10
    db "============================================================",10,0

p_status  db "Enrollment Status: ",0
p_id      db "Student Number: ",0
p_name    db "Full Name: ",0
p_phone   db "Phone Number: ",0
p_zip     db "ZIP Code: ",0
p_college db "College: ",0
p_program db "Program: ",0
p_year    db "Year Level: ",0
p_term    db "Term: ",0
p_sy      db "School Year: ",0
p_address db "Address: ",0

student_title:
    db 10,"================ STUDENT INFORMATION ================",10,0

field_fmt db "%-20s : %s",10,0

label_status  db "Enrollment Status",0
label_id      db "Student Number",0
label_name    db "Full Name",0
label_phone   db "Phone Number",0
label_zip     db "ZIP Code",0
label_college db "College",0
label_program db "Program",0
label_year    db "Year Level",0
label_term    db "Term",0
label_sy      db "School Year",0
label_address db "Address",0

course_header:
    db 10,"================ FIXED COURSE SCHEDULE ================",10
    db "CODE       TITLE                                  UNITS  DAY   TIME                    ROOM",10
    db "------------------------------------------------------------------------------------------------",10,0

course1  db "CCS0021    INFORMATION MANAGEMENT (LEC)            2     T     16:00-18:40             ONLINE",10,0
course2  db "CCS0021L   INFORMATION MANAGEMENT (LAB)            1     F     16:00-18:50             ONLINE",10,0
course3  db "CSD001     DISCRETE STRUCTURES 1                   3     S/W   15:00-16:50/15:00-16:50 F710/F710",10,0
course4  db "CSD003     COMPUTER SYSTEMS & ARCHITECTURE         2     F     10:00-12:40             ONLINE",10,0
course5  db "CSD003L    COMPUTER SYSTEMS & ARCHITECTURE (LAB)   1     TH    10:00-12:50             E619",10,0
course6  db "CSD070     OBJECT ORIENTED PROGRAMMING             2     F     07:00-09:40             ONLINE",10,0
course7  db "CSD070L    OBJECT ORIENTED PROGRAMMING-LAB         1     TH    07:00-09:50             E609",10,0
course8  db "GED0021    SPECIALIZED ENGLISH LANGUAGE 2          3     S/W   11:00-12:50/11:00-12:50 F607/F607",10,0
course9  db "GED0055    MATHEMATICAL ANALYSIS                   3     S/W   09:00-10:50/09:00-10:50 F712/F712",10,0
course10 db "GED0081    COLLEGE PHYSICS 1 LECTURE               2     T     10:00-12:40             ONLINE",10,0
course11 db "GED0081L   COLLEGE PHYSICS LABORATORY              1     M     10:00-12:50             F1003",10,0

unit_total:
    db "TOTAL UNITS: 21",10
    db "TOTAL COURSES: 11",10,0

p_misc  db 10,"Enter Miscellaneous Fee (PHP): ",0
p_idfee db "Enter ID Validation Fee (PHP): ",0
p_lab   db "Enter Laboratory Fees (PHP): ",0
p_other db "Enter Other Fees (PHP): ",0

scan_money db "%lf",0
invalid db "Invalid amount. Enter a non-negative number.",10,0

assessment_title:
    db 10,"================ TUITION ASSESSMENT ================",10,0

money_fmt db "%-29s : PHP %.2f",10,0

label_coursefee db "Course Fees (11 x PHP 1000)",0
label_misc      db "Miscellaneous Fee",0
label_idfee     db "ID Validation Fee",0
label_labfee    db "Laboratory Fees",0
label_otherfee  db "Other Fees",0
label_total     db "TOTAL ASSESSMENT",0

separator db "----------------------------------------------------",10,0

payment_title:
    db 10,"================ PAYMENT SCHEDULE ==================",10,0

label_down  db "Down Payment (40%)",0
label_mid   db "Midterm (30%)",0
label_final db "Final Payment (30%)",0

coursefee dq 11000.0
rate40 dq 0.40
rate30 dq 0.30
zero dq 0.0

section .bss

status     resb 100
studentid  resb 100
fullname   resb 100
phone      resb 100
zipcode    resb 100
college    resb 100
program    resb 100
yearlevel  resb 100
term       resb 100
schoolyear resb 100
address    resb 100

misc     resq 1
idfee    resq 1
labfee   resq 1
otherfee resq 1

total    resq 1
down     resq 1
mid      resq 1
finalfee resq 1

section .text

%macro GET_TEXT 2
    lea rcx, [%1]
    call printf

    lea rcx, [%2]
    call read_line
%endmacro

%macro PRINT_FIELD 2
    lea rcx, [field_fmt]
    lea rdx, [%1]
    lea r8, [%2]
    call printf
%endmacro

%macro PRINT_MONEY 2
    lea rcx, [money_fmt]
    lea rdx, [%1]
    movsd xmm2, [%2]
    movq r8, xmm2
    call printf
%endmacro

%macro ADD_FEE 1
    addsd xmm0, [%1]
%endmacro

%macro SHOW_COURSE 1
    lea rcx, [%1]
    call printf
%endmacro

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    lea rcx, [header]
    call printf

    GET_TEXT p_status, status
    GET_TEXT p_id, studentid
    GET_TEXT p_name, fullname
    GET_TEXT p_phone, phone
    GET_TEXT p_zip, zipcode
    GET_TEXT p_college, college
    GET_TEXT p_program, program
    GET_TEXT p_year, yearlevel
    GET_TEXT p_term, term
    GET_TEXT p_sy, schoolyear
    GET_TEXT p_address, address

    lea rcx, [student_title]
    call printf

    PRINT_FIELD label_status, status
    PRINT_FIELD label_id, studentid
    PRINT_FIELD label_name, fullname
    PRINT_FIELD label_phone, phone
    PRINT_FIELD label_zip, zipcode
    PRINT_FIELD label_college, college
    PRINT_FIELD label_program, program
    PRINT_FIELD label_year, yearlevel
    PRINT_FIELD label_term, term
    PRINT_FIELD label_sy, schoolyear
    PRINT_FIELD label_address, address

    lea rcx, [course_header]
    call printf

    SHOW_COURSE course1
    SHOW_COURSE course2
    SHOW_COURSE course3
    SHOW_COURSE course4
    SHOW_COURSE course5
    SHOW_COURSE course6
    SHOW_COURSE course7
    SHOW_COURSE course8
    SHOW_COURSE course9
    SHOW_COURSE course10
    SHOW_COURSE course11

    lea rcx, [unit_total]
    call printf

    lea rcx, [p_misc]
    lea rdx, [misc]
    call read_amount

    lea rcx, [p_idfee]
    lea rdx, [idfee]
    call read_amount

    lea rcx, [p_lab]
    lea rdx, [labfee]
    call read_amount

    lea rcx, [p_other]
    lea rdx, [otherfee]
    call read_amount

    movsd xmm0, [coursefee]
    ADD_FEE misc
    ADD_FEE idfee
    ADD_FEE labfee
    ADD_FEE otherfee

    movsd [total], xmm0

    movsd xmm1, xmm0
    mulsd xmm1, [rate40]
    movsd [down], xmm1

    movsd xmm1, xmm0
    mulsd xmm1, [rate30]
    movsd [mid], xmm1

    subsd xmm0, [down]
    subsd xmm0, [mid]
    movsd [finalfee], xmm0

    lea rcx, [assessment_title]
    call printf

    PRINT_MONEY label_coursefee, coursefee
    PRINT_MONEY label_misc, misc
    PRINT_MONEY label_idfee, idfee
    PRINT_MONEY label_labfee, labfee
    PRINT_MONEY label_otherfee, otherfee

    lea rcx, [separator]
    call printf

    PRINT_MONEY label_total, total

    lea rcx, [payment_title]
    call printf

    PRINT_MONEY label_down, down
    PRINT_MONEY label_mid, mid
    PRINT_MONEY label_final, finalfee

    xor eax, eax
    leave
    ret

read_line:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp-8], rcx
    mov qword [rbp-16], 0

.read_char:
    call getchar

    cmp eax, -1
    je .finish

    cmp eax, 10
    je .finish

    cmp eax, 13
    je .read_char

    mov rdx, [rbp-16]
    cmp rdx, 99
    jae .read_char

    mov rcx, [rbp-8]
    mov [rcx+rdx], al

    inc rdx
    mov [rbp-16], rdx

    jmp .read_char

.finish:
    mov rcx, [rbp-8]
    mov rdx, [rbp-16]
    mov byte [rcx+rdx], 0

    leave
    ret

read_amount:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rbp-8], rcx
    mov [rbp-16], rdx

.retry:
    mov rcx, [rbp-8]
    call printf

    lea rcx, [scan_money]
    mov rdx, [rbp-16]
    call scanf

    mov [rbp-24], eax

.clear:
    call getchar
    cmp eax, 10
    je .validate
    cmp eax, -1
    je .validate
    jmp .clear

.validate:
    cmp dword [rbp-24], 1
    jne .bad

    mov rdx, [rbp-16]
    movsd xmm0, [rdx]

    ucomisd xmm0, [zero]
    jp .bad
    jb .bad

    leave
    ret

.bad:
    lea rcx, [invalid]
    call printf
    jmp .retry
