"""Desafio Sistema Bancário com funções"""

#Definição das funções 

def sacar(*, saldo, valor, extrato, limite, numero_saques, limite_saques):
    
    if numero_saques >= limite_saques:
        print('Operação falhou. Você excedeu o limite de saques diários.')

    else:

        if valor > limite:
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

    return saldo, extrato, numero_saques

def depositar(saldo, valor, extrato, /):

    if valor <= 0:
            print('Valor invalido. Cancelando operação.')
    else:
        saldo += valor
        extrato += f'Depósito: R$ {valor:.2f}\n'
        print(f'Foram depositados R$ {valor:.2f} na sua conta.')

    return saldo, extrato

def ver_extrato(saldo, /, *, extrato):
    
    print('Extrato')
    print('\n========== EXTRATO ==========')
    print('Não foram realizadas movimentações.' if not extrato else extrato)
    print(f'Saldo: R$ {saldo:.2f}')
    
    return None

def filtrar_usuario(cpf, lista_usuarios):
    
    usuario_filtrado = [usuario for usuario in lista_usuarios if usuario['cpf']==cpf] 
    
    return usuario_filtrado[0] if usuario_filtrado else None

def cadastro_usuario(lista_usuarios):
    
    cpf = input('Informe o CPF (somente números): \n')
    usuario = filtrar_usuario(cpf, lista_usuarios)
    
    if usuario:
        print('Já existe usuário cadastrado com o CPF informado.')
        return None
    
    nome = input('Informe o nome completo: \n')
    nascimento = input('Informe a data de nascimento (dd-mm-aaaa): \n')
    endereco = input('Informe o endereço (logradouro, nro - bairro - cidade/sigla estado): \n')
    lista_usuarios.append({'nome':nome, 'nascimento':nascimento, 'cpf':cpf, 'endereco':endereco})
    print('Usuário criado com sucesso!')
    
    return None

def criar_conta(agencia, numero_conta, lista_usuarios, lista_contas):
    
    cpf = input('Informe o CPF (somente números): \n')
    usuario = filtrar_usuario(cpf, lista_usuarios)
    
    if usuario:
        print('Conta criada com sucesso.')
        lista_contas.append({'agencia':agencia, 'numero_conta':numero_conta, 'cpf':cpf, 'saldo':0.0,
                             'extrato':"", 'numero_saques':0})
        return None
   
    print('Erro, usuário não encontrado. Cadastre o usuário para criar uma conta.')
    return None

def filtrar_conta(numero_conta, lista_contas):
    conta_filtrada = [conta for conta in lista_contas if conta['numero_conta']==numero_conta] 
    
    return conta_filtrada[0] if conta_filtrada else None

def operar_conta():
    
    numero_conta = int(input('Informe o número da conta: \n'))
    conta = filtrar_conta(numero_conta, lista_contas)
    
    if conta:
        
        cpf = conta['cpf']
        usuario = filtrar_usuario(cpf, lista_usuarios)
        nome = usuario['nome']
        
        #Variáveis
        saldo = conta['saldo']
        extrato = conta['extrato']
        numero_saques = conta['numero_saques']
        
        print(f'Bem vindo {nome}, seu saldo é de R$ {saldo:.2f}. Selecione uma operação:')
    
    else:
        print('Conta não encontrada')
        return None
    
    menu_conta = """
    
    [d] Depositar
    [s] Sacar
    [e] Extrato
    [q] Sair

    =>"""
        
    while True:

        opcao = input(menu_conta)

        if opcao == 'd':
            print('Deposito')
            valor = float(input('Informe o valor do depósito: \n'))
            saldo, extrato = depositar(saldo, valor, extrato)

            conta['saldo'], conta['extrato'] = saldo, extrato
            
        elif opcao == 's':

            print('Saque')
            valor = float(input('Informe o valor do saque: \n'))

            saldo, extrato, numero_saques = sacar(saldo=saldo, valor=valor, extrato=extrato,
                                                   limite=LIMITE_SAQUE, numero_saques=numero_saques, 
                                                   limite_saques=LIMITE_SAQUES_DIARIOS)
            
            conta['saldo'] = saldo
            conta['extrato'] = extrato
            conta['numero_saques'] = numero_saques
        
        elif opcao == 'e':
            ver_extrato(conta['saldo'], extrato=conta['extrato'])

        elif opcao == 'q':
            break

        else:
            print("Operação invalida, por favor selecione nomavente a operação desejada")
    return None

#---------------------

menu = """

[a] Acessar conta
[c] Cadastrar usuário
[ac] Adicionar conta
[lu] Listar usuários
[lc] Listar contas
[q] Sair
=>"""

lista_usuarios = []
lista_contas = []

#Constantes
AGENCIA = '0001'
LIMITE_SAQUE = 500 
LIMITE_SAQUES_DIARIOS = 3 
#----------

# Criando um usurario com saldo para acessar conta
usuario_1 = {'nome':'José João', 'nascimento':'01-01-1991', 'cpf':'123456789', 
             'endereco':'Rua dos Bobos, 0 - bairro - cidade/NA'}
lista_usuarios.append(usuario_1)

conta_1 = {'agencia':AGENCIA, 'numero_conta':1, 'cpf':'123456789', 'saldo':100.0, 'extrato':"",
           'numero_saques':0}

lista_contas.append(conta_1)

while True:
    opcao = input(menu)
    
    if opcao == 'a':
        operar_conta()
    
    elif opcao == 'c':
        print('Cadastrar usuário')
        cadastro_usuario(lista_usuarios)
        
    elif opcao == 'ac':
        numero_conta = len(lista_contas)+1
        criar_conta(AGENCIA, numero_conta, lista_usuarios, lista_contas)
    
    elif opcao == 'lu':
        
        print('###CPF###', '\t', '###Nome###')
        for usuario in lista_usuarios:
            print(usuario['cpf'], '\t', usuario['nome'])
    
    elif opcao == 'lc':
        print('AGENCIA ', 'CONTA \t', '###CPF###')
        for conta in lista_contas:
            print(conta['agencia'], '\t', conta['numero_conta'], '\t', conta['cpf'])  
    
    elif opcao == 'q':
        break
    
    else:
        print("Operação invalida, por favor selecione nomavente a operação desejada")
