#!/bin/bash

# clear
echo ""

if [ "$1" == "" ]; then
	echo "Modo de uso"
	echo "Teste não autenticado: $0 <Alvo>"
	echo "Teste autenticado: $0 <Alvo> <Access_Token> <Client_ID>"
elif [ "$2" == "" ] && [ "$3" == "" ]; then
setterm -foreground red && echo "[+]------------------------- Rate Limit Validation -------------------------[+]"
echo ""
echo "Developed by > Cyber Strike Force LABS "
echo ""
Request_Success="0"
Request_Failure="0"
Time=$(date | cut -d " " -f5)
for Loop in {1..1000}; do
Request=$(curl -sIkX GET $1 | grep "HTTP" | cut -d " " -f2);
        if [ "$Request" == "200" ]; then
                Request_Success=$(echo "$Request_Success"+1|bc)
                echo "		Request Number [$Loop] - [SUCESSO]" >> /dev/null
		echo "[+]-------------------------------------------------[+]" >> /dev/null
        elif [ "$Request" == "429" ]; then
                Time_Out=$(date | cut -d " " -f5)
                Request_Failure=$(echo "$Request_Failure"+1|bc)
		echo "[+] Validando o tempo de retorno"
                for Loop2 in {1..5000}; do
                Request2=$(curl -sIkX GET $1 | grep "HTTP" | cut -d " " -f2);
                        if [ "$Request2" == "200" ]; then
                                Time_Return=$(date | cut -d " " -f5)
				setterm -foreground blue && echo "	[+] Tipo de teste: Não-autenticado"
                                setterm -foreground red && echo "	[+] O limite de requisições para a API antes do controle de Rate Limit começar agir é de $Request_Success requisições."
                                setterm -foreground blue && echo "	[*] Hora do início: $Time"
                                setterm -foreground red && echo "	[*] Hora de parada: $Time_Out"
                                setterm -foreground green && echo "	[*] Hora de retorno: $Time_Return"
                                Hours_Return=$(echo "$Time_Return" | cut -d ":" -f1) 
                                Minutes_Return=$(echo "$Time_Return" | cut -d ":" -f2)
                                Seconds_Return=$(echo "$Time_Return" | cut -d ":" -f3)
                                Hours_Out=$(echo "$Time" | cut -d ":" -f1) 
                                Minutes_Out=$(echo "$Time" | cut -d ":" -f2)
                                Seconds_Out=$(echo "$Time" | cut -d ":" -f3)
                                Hours_Result=$(echo "$Hours_Return-$Hours_Out"|bc)
                                Minutes_Result=$(echo "$Minutes_Return-$Minutes_Out"|bc)
                                Seconds_Result=$(echo "$Seconds_Return-$Seconds_Out"|bc)
                                Date_Result=$(echo "O controle de Rate Limit segura as requisições por $Hours_Result hora(s), $Minutes_Result minuto(s) e $Seconds_Result segundo(s)." | tr --delete "-")
                                setterm -foreground red && echo "       [+] $Date_Result"
				echo ""
				echo "[+]-------------------------------------------------------------------------[+]"
				setterm -foreground default
                                exit
                        else
                                echo "          Request Failure - [FALHA]" >> /dev/null
		                echo "[+]-------------------------------------------------[+]" >> /dev/null

                        fi
                done
        else
                echo "Um erro ocorreu ..."
        fi
done


# Original completo
else
setterm -foreground red && echo "[+]------------------------- Rate Limit Validation -------------------------[+]"
echo ""
echo "Developed by > Cyber Strike Force LABS "
echo ""

Request_Success="0"
Request_Failure="0"
Time=$(date | cut -d " " -f5)
for Loop in {1..1000}; do
Request=$(curl -sIkX GET $1 -H $'access_token: '$2'' -H $'client_id: '$3'' | grep "HTTP" | cut -d " " -f2);
	if [ "$Request" == "200" ]; then
		Request_Success=$(echo "$Request_Success"+1|bc)
                echo "          Request Number [$Loop] - [SUCESSO]" >> /dev/null
                echo "[+]-------------------------------------------------[+]" >> /dev/null
	elif [ "$Request" == "429" ]; then
		Time_Out=$(date | cut -d " " -f5)
		Request_Failure=$(echo "$Request_Failure"+1|bc)
		echo "	[+] Validando o tempo de retorno"
		for Loop2 in {1..5000}; do
		Request2=$(curl -sIkX GET $1 -H $'access_token: '$2'' -H $'client_id: '$3'' | grep "HTTP" | cut -d " " -f2);
			if [ "$Request2" == "200" ]; then
				Time_Return=$(date | cut -d " " -f5)
                                setterm -foreground blue && echo "	[+] Tipo de teste: Autenticado"
                                setterm -foreground red && echo "	[+] O limite de requisições para a API antes do controle de Rate Limit começar agir é de $Request_Success requisições."
                                setterm -foreground blue && echo "	[*] Hora do início: $Time"
                                setterm -foreground red && echo "	[*] Hora de parada: $Time_Out"
                                setterm -foreground green && echo "	[*] Hora de retorno: $Time_Return"
				Hours_Return=$(echo "$Time_Return" | cut -d ":" -f1)
				Minutes_Return=$(echo "$Time_Return" | cut -d ":" -f2)
				Seconds_Return=$(echo "$Time_Return" | cut -d ":" -f3)
				Hours_Out=$(echo "$Time" | cut -d ":" -f1)
				Minutes_Out=$(echo "$Time" | cut -d ":" -f2)
				Seconds_Out=$(echo "$Time" | cut -d ":" -f3)
				Hours_Result=$(echo "$Hours_Return-$Hours_Out"|bc)
				Minutes_Result=$(echo "$Minutes_Return-$Minutes_Out"|bc)
				Seconds_Result=$(echo "$Seconds_Return-$Seconds_Out"|bc)
				Date_Result=$(echo "O controle de Rate Limit segura as requisições por $Hours_Result hora(s), $Minutes_Result minuto(s) e $Seconds_Result segundo(s)." | tr --delete "-")
				setterm -foreground red && echo "	[+] $Date_Result"
                                echo ""
                                echo "[+]-------------------------------------------------------------------------[+]"
				setterm -foreground default
				exit
			else
                                echo "          Request Failure - [FALHA]" >> /dev/null
                                echo "[+]-------------------------------------------------[+]" >> /dev/null
			fi
		done
	else
		echo "Um erro ocorreu ..."
	fi
done
fi
