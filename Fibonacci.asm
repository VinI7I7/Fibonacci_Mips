.data
mensagem30:  .asciiz "O numero 30 de Fibonacci e: "
mensagemPHI: .asciiz "A razao aurea usando F41 e F40 e: "
pularLinha:  .asciiz "\n"

.text
.globl main

fibonacci:
    blez $a0, fib_retorno0
    li $t0, 1
    beq $a0, $t0, fib_retorno1

    li $t1, 0       # a = 0
    li $t2, 1       # b = 1

    sub $a0, $a0, 1
fib_laco:
    beqz $a0, fib_concluido
    add $t3, $t1, $t2
    move $t1, $t2
    move $t2, $t3
    sub $a0, $a0, 1
    j fib_laco

fib_concluido:
    move $v0, $t2
    jr $ra

fib_retorno0:
    li $v0, 0
    jr $ra

fib_retorno1:
    li $v0, 1
    jr $ra

main:
    #Calculando o 30 numero de Fibonacci
    li $a0, 30
    jal fibonacci
    move $s1, $v0    #Armazena o resultado em $s1

    #Imprime o resultado do 30 numero da sequencia de fibonacci
    li $v0, 4
    la $a0, mensagem30
    syscall
    
    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, pularLinha
    syscall

    # Calculando F41
    li $a0, 41
    jal fibonacci
    move $s2, $v0    # Armazena F41 em $s2

    # Calculando F40
    li $a0, 40
    jal fibonacci
    move $s3, $v0    # Armazena F40 em $s3

    # Calculando a razao aurea como um número em ponto flutuante
    mtc1 $s2, $f4    # Move F41 para $f4
    mtc1 $s3, $f6    # Move F40 para $f6
    cvt.s.w $f4, $f4 # Converte F41 para ponto flutuante
    cvt.s.w $f6, $f6 # Converte F40 para ponto flutuante
    div.s $f0, $f4, $f6 # Calcula a divisão F41 / F40 e armazena em $f0

    # Imprimindo a razao aurea
    li $v0, 4
    la $a0, mensagemPHI
    syscall
    
    li $v0, 2       # Chama syscall para imprimir float
    mov.s $f12, $f0 # Move o resultado para $f12
    syscall

    li $v0, 4
    la $a0, pularLinha
    syscall

    li $v0, 10
    syscall
