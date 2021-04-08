// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(loop)
    @KBD
    D = M //D = 키보드 여부
    @WHITE
    D;JEQ //입력이 없다면 white로 점프
//    D = 1
    @color
    M = D
    D = -1
    @color
    M = D
    @START
    0;JMP // 입력이 있다면 바로 START
    (WHITE)
        D = 0
        @color
        M = D
        @START
        0;JMP

    (START)
    @256
    D = A
    @i
    M = D // 가로축을 256개로 설정
    @SCREEN
    D = A
    @POINT
    M = D //POINT주소에 SCREEN 주솟값을 넣어 나중에 A레지스터로 접근, 방법은 @POINT
        (sero)
        @i
        D = M
        @startEND 
        D;JEQ // 막줄인지 확인
        @i
        M = M-1 //다음 줄
        @32
        D = A
        @j
        M = D // 세로축을 32개로 설정
            (garo)
            @j
            D = M
            @garoEND
            D;JEQ
            @color
            D = M //D레지스터에 컬러값
            @POINT
            A = M //A레지스터에 point가 가르키는 주소
            M = D //point에 컬러값(D레지스터)
            @POINT
            M = M+1 //다음POINT
            @j
            M = M-1 //다음 행
            D = M
            @garo
            0;JEQ
            (garoEND)
        @sero
        0;JMP
        (seroEND)
    (startEND)
@loop
0;JMP
