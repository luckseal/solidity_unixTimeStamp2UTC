pragma solidity ^0.4.21;
contract TimeHelper {
    uint constant utc_base_year =1970;
     uint[12] MonthDays= [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    
    
    function getIsLeapYear(uint year) view private  returns(bool){
        if(year%400==0){
            return true;
        }else if(year%100==0){
            return false;
        }else if(year%4==0){
            return true;
        }else{
            return false; 
        }
    }
    
    function getMonthDays(uint month,uint year) private returns(uint){
        require(month>0&&month<=12);
        if(month!=2){
            return MonthDays[month-1];
        }else if(getIsLeapYear(year)){
            return MonthDays[month-1]+1;
        }else{
            return MonthDays[month-1];
        }
    }
    function getUTC(uint unixTimeStamp,uint index) public returns(uint){
        uint year;
        uint month;
        uint day;
        uint hour;
        uint minute;
        uint second;
        uint thisDaySpendAllSeconds=unixTimeStamp%1 days;
        hour=thisDaySpendAllSeconds/1 hours;
        
        uint thisHourSpendsAllSeconds=thisDaySpendAllSeconds%1 hours;
        minute=thisHourSpendsAllSeconds/1 minutes;
        
        second=thisHourSpendsAllSeconds%1 minutes;
        
        uint allDays=unixTimeStamp/1 days;
        
        
        for(year=utc_base_year;allDays>0;year++){
            uint allDaysOneYear=1 years/1 days;
            if(getIsLeapYear(year)){
                allDaysOneYear+=1;
            }
            if(allDays>=allDaysOneYear){
                allDays-=allDaysOneYear;
            }
            else{
                break;
            }
        }
        
        for(month=1;month<12;month++){
            uint allDaysthisMonth=getMonthDays(month,year);
            if(allDays>allDaysthisMonth){
                allDays-=allDaysthisMonth;
            }else{
                break;
            }
        }
        
        day=allDays+1;
        
        if(index==0)return year;
        else if(index==1)return month;
        else if(index==2)return day;
        else if(index==3)return hour;
        else if(index==4)return minute;
        else return second;
        
    }

    function getZoneTime(uint timeOffset,uint index) public returns(uint){
        return getUTC(now+timeOffset,index);
    }
    //////////////// 
    ////index
    ////0 年  
    ////1 月  
    ////2 日  
    ////3 时  
    ////4 分  
    ////其他 秒
    ////////////////
    function getBeijingTime(uint index) public returns(uint){
        return getZoneTime(8 hours,index);
    }
}                                                                                                                                 