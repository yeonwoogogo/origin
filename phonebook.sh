#!/bin/bash

PHONEBOOK="phonebook.txt"

if [ $# -ne 2 ]; then
	echo "Usage: $0 <이름> <전화번호>"
	exit 1
fi

NAME=$1
PHONE=$2

if [[ ! "$PHONE" =~ ^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$ ]]; then
	echo "전화번호는 '123-4567-8901' 형식이어야 합니다."
	exit 1
fi

AREA_CODE=${PHONE%%-*}

AREA=""
case "AREA_CODE" in
	"02") AREA="서울" ;;
	"031") AREA="경기" ;;
	"032") AREA="인천" ;;
	"051") AREA="부산" ;;
	"053") AREA="대구" ;;
	"062") AREA="광주" ;;
	"042") AREA="대전" ;;
	"052") AREA="울산" ;;
	"044") AREA="세종" ;;
	*) AREA="" ;;
esac

if [ -z "$AREA" ]; then
	echo "알 수 없는 지역번호입니다."
	exit 1
fi

if [ ! -f $PHONEBOOK ]; then
	echo "" > $PHONEBOOK
fi

FOUND=false
UPDATE=false
TEMP_FILE=$(mktemp)

while IFS= read -r line; do
	EXISTING_NAME=$(echo $line | cut -d' ' -f1)
	EXISTING_PHONE=$(echo $line | cut -d' ' -f2)
	EXISTING_AREA=$(echo $line | cut -d' ' -f3-)
	
	if [ "$EXISTING_NAME" == "$NAME" ]; then
		FOUND=true
		
		if [ "$EXISTING_PHONE" == "$PHONE" ]; then
		       echo "동일한 전화번호가 이미 존재합니다."
	               rm "$TEMP_FILE"
	               exit 0
	        else
	               echo "$NAME $PHONE $AREA" >> "$TEMP_FILE"
                       UPDATED=true
                fi
        else
                echo "$line" >> "$TEMP_FILE"
        fi
done < "$PHONEBOOK"

if [ "$FOUND" == false ]; then
	echo "$NAME $PHONE $AREA" >> "$TEMP_FILE"
fi

if [ "$UPDATED" == false ] && [ "$FOUND" == false ]; then
	echo "$NAME $PHONE $AREA" >> "$TEMP_FILE"
fi

sort "$TEMP_FILE" > "$PHONEBOOK"
rm "$TEMP_FILE"

ehco "처리가 완료되었습니다."
exit 0


