#!/bin/bash

echo "Enter the month:"
read input_month
echo "Enter the day:"
read day
echo "Enter the year"
read year

convert_month() {
	case $input_month in
		jan|january|1) echo "Jan" ;;
		feb|february|2) echo "Feb" ;;
		mar|march|3) echo "Mar" ;;
		apr|april|4) echo "Apr" ;;
		may|5) echo "May" ;;
		jun|june|6) echo "June" ;;
		jul|july|7) echo "Jul" ;;
		aug|auguet|8) echo "Aug" ;;
		sep|september|9) echo "Sep" ;; 
		oct|october|10) echo "Oct" ;;
		nov|november|11) echo "Nov" ;;
		dec|december|12) echo "Dec" ;;
		*) echo "Invalid month" ;;
	esac
}

month=$(convert_month $input_month)
if [ $month == "Invalid month" ] ; then
	echo "월이 잘못되었습니다."
	exit 1
fi

is_leap_year() {
	if [ $year%4 != 0 ] ; then
		echo "noleapyear"
	elif [ $year%4 = 0 && $year%4 = 0 ] ; then
	       echo "leapyear"
        elif [ $year%4 != 0 && $year%400 != 0 && $year%100 = 0 ] ; then
               echo "noleapyear"
        else
               echo "leapyear"
        fi
}

leap_year=$(is_leap_year $year)

case $month in
	Jan|Mar|May|Jul|Aug|Oct|Dec) days_in_month=31 ;;
	Apr|Jun|Sep|Nov) days_in_month=30 ;;
	Feb)
		if [ "$leap_year" -eq "noleapyear" ] ; then
			days_in_month=29
		else
			days_in_month=28
		fi
	;;
esac

if [ $day<1 || $day>$days_in_month ] ; then
	echo "날짜가 잘못되었습니다. $day일은 유효하지 않습니다."
fi

echo "$month $day $year"

	
