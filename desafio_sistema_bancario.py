"""Desafio Sistema Bancário"""

menu = """

[d] Depositar
[s] Sacar
[e] Extrato
[q] Sair

=>"""

LIMITE_SAQUE = 500 
LIMITE_SAQUES_DIARIOS = 3 

saldo = 200.00

extrato = ""

numero_saques = 0

print(f'Bem vindo, seu saldo é de R$ {saldo:.2f}. Selecione uma operação:')

while True:
    
    opcao = input(menu)
    
    if opcao == 'd':
        print('Deposito')
        valor = float(input('Informe o valor do depósito: \n'))
        
        if valor <= 0:
            print('Valor invalido. Cancelando operação.')
        else:
            saldo += valor
            print(f'Foram depositados R$ {valor:.2f} na sua conta.')
            extrato += f'Depósito: R$ {valor:.2f}\n'

    elif opcao == 's':
        if numero_saques >= LIMITE_SAQUES_DIARIOS:
            print('Operação falhou. Você excedeu o limite de saques diários.')
        
        else:
            
            print('Saque')
            valor = float(input('Informe o valor do saque: \n'))
            
            if valor > LIMITE_SAQUE:
                print('Operação falhou. O valor excede o limite.')
            elif valor <= 0:
                print('Operação falhou. Valor informado inválido')
    
            else:
                if valor > saldo:
                    print('Operação falhou. Saldo insuficiente')
                elif valor >0:
                    saldo -= valor
                    extrato += f'Saque: R$ {valor:.2f}\n'
                    numero_saques += 1
                    print('Saque realizado com sucesso.')
                    
    elif opcao == 'e':
        print('Extrato')
        print('\n========== EXTRATO ==========')
        print('Não foram realizadas movimentações.' if not extrato else extrato)
        print(f'Saldo: R$ {saldo:.2f}')
         
    elif opcao == 'q':
        break
    
    else:
        print("Operação invalida, por favor selecione nomavente a operação desejada")