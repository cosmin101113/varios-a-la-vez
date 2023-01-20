#!/bin/bash
mayortiempo=0
menortiempo=9999
if [ $# -ge 2 ]; then
	for i in $@; do
		existe=$(cat /etc/passwd | grep ^$i | cut -d":" -f1)
		if [ "$existe" == "$i" ];then
			echo "El corredor $i existe"
		else
			read -p "$i no existe. Quieres dar de alta al corredor [S/n]? " opcion
			if [ "$opcion" == "S" ]; then
				sudo adduser $i
			else
				echo "Usuario no creado"
			fi
		fi
		existe2=$(cat /etc/passwd | grep ^$i | cut -d":" -f1)
		if [ "$existe2" == "$i" ]; then
			read -p "Introduce el tiempo del usuario $i " tiempo
			if [ $tiempo -gt $mayortiempo ]; then
				mayortiempo=$tiempo
				mayortganador=$i
			fi
			if [ $tiempo -lt $menortiempo ]; then
				menortiempo=$tiempo
				menortganador=$i
			fi
		fi
	done
	diferencia=$(($mayortiempo-$menortiempo))
	echo "El ganador con el menor tiempo es $menortganador con un tiempo de $menortiempo y el más lento es el corredor $mayortganador con un tiempo de $mayortiempo"
	echo "La diferencia de tiempo entre el ganador y el último es de $diferencia segundos"
else
	echo "Sintaxis incorrecta : Mínimo 2 argumentos"
fi
