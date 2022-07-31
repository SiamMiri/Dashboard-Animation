#include "backend.h"

Backend::Backend(QObject *parent) : QObject(parent)
{

}
void Backend::setGas(QString str)
{
    str = "Gas";
    //qDebug() << str;


    if((0 <=  dGas) && (dGas <30)){
        dGas = 0.8 + dGas ;
        iGear =  1;
    }

    if((30 <=  dGas) && (dGas <60)){
        dGas = 0.8 + dGas ;
        iGear = 2;
    }

    if((60 <=  dGas) && (dGas <100)){
        dGas = 0.6 + dGas ;
        iGear = 3;
    }

    if((100 <=  dGas) && (dGas <120)){
        dGas = 0.6 + dGas ;
        iGear = 4;
    }

    if((115 <=  dGas) && (dGas <200)){
        dGas = 0.4 + dGas ;
        iGear = 5;
    }
}


QString Backend::getGas()
{
    double iCurrentGaas = gasZahl.toDouble() + dGas ;

    int i = round(iCurrentGaas);

    return QString::number(i);
}
QString Backend::getReversegear()
{
    double iCurrentReversegearGas = gasZahlReversegear.toDouble() + dGasReversegear ;

    int i = round(iCurrentReversegearGas);

    //qDebug() << i;
    return QString::number(i);
}

void Backend::setReversegear(QString str)
{
    str = "Reversegear";
    //qDebug () << str;

    if((0 <=  dGasReversegear) && (dGasReversegear <= 39)){
        dGasReversegear = dGasReversegear + 0.5  ;
        iGear =  1;
    }

    /*
    if(dGasReversegear > 40){
        dGasReversegear = 40 ;
        iGear =  1;
    }
    */
}

void Backend::setRevBremse(QString str)
{
    /*v1
    if((0 <=  dGasReversegear) && (dGasReversegear <= 39)){
        dGasReversegear = dGasReversegear - 0.5  ;
        iGear =  1;
    }
    */

    if((0 <=  dGasReversegear) && (dGasReversegear <1)){
        dGasReversegear = dGasReversegear - dGasReversegear ;
        iGear =  1;
    }

    if((1 <=  dGasReversegear) && (dGasReversegear <41)){
        dGasReversegear = dGasReversegear - 1 ;
        iGear =  1;
    }
    //qDebug() << dGasReversegear ;
}



QString Backend::getRevBremse()
{
    double iCurrentReversegearGas = gasZahlReversegear.toDouble() + dGasReversegear ;

    int i = round(iCurrentReversegearGas);

    //qDebug() << "dGasReversegear is" ;
    //qDebug() << i;
    return QString::number(i);

}
QString Backend::getStatus()
{
    return this->Status;
}

void Backend::setStatus(QString status)
{
    this->Status = status;
}

void Backend::setDistCov(double d)
{
    distCov = d;
}

double Backend::getDistCov()
{
    return distCov;
}

void Backend::setTime(QString str)
{

    str = "Timer startet";
    QTimer timer;
    timer.start(1000);
    iSecondOne ++;
}

QString Backend::getTime()
{

    return QString::number(iSecondOne);
}

void Backend::setPower(QString str)
{

    switch(iPowerCondition)
    {
    case 0:
        if(dGas < 30)
        {
            str = "Gas";
            //qDebug() << str;
            iPower = dGas/2;
        }else{
            iPower = 0;
        }

    case 1:
        if(dGas < 60)
        {
            str = "Gas";
            //qDebug() << str;
            iPower = dGas/2;
        }else{
            iPower = 0;
        }

    case 2:
        if(dGas < 90)
        {
            str = "Gas";
            //qDebug() << str;
            iPower = dGas/2;
        }else{
            iPower = 0;
        }

    case 3:
        if(dGas < 120)
        {
            str = "Gas";
            //qDebug() << str;
            iPower = dGas/2;
        }else{
            iPower = 0;
        }

    case 4:
        if(dGas < 200)
        {
            str = "Gas";
            //qDebug() << str;
            iPower = dGas/2;
        }else{
            iPower = 0;
        }
    }

}

QString Backend::getPower()
{
    double iCurrentPower = powerZahl.toDouble() + iPower ;

    //int i = iCurrentPower;

    return QString::number(iCurrentPower);

}

void Backend::setBremse(QString str)
{
    str = "Bremsen";
    //qDebug() << str;

    if((0 <=  dGas) && (dGas <1)){
        dGas = dGas - dGas ;
        iGear =  1;
    }else{
    }

    if((1 <=  dGas) && (dGas <30)){
        dGas = dGas - 1 ;
        iGear =  1;
    }else{
    }

    if((30 <=  dGas) && (dGas <60)){
        dGas = dGas - 1;
        iGear = 2;
    }else{

    }

    if((60 <=  dGas) && (dGas <90)){
        dGas = dGas - 1 ;
        iGear = 3;
    }else{
    }

    if((85 <=  dGas) && (dGas <120)){
        dGas = dGas - 1;
        iGear = 4;
    }else{
    }

    if((115 <=  dGas) && (dGas <201)){
        dGas = dGas - 1 ;
        iGear = 5;
    }else{
    }
}

QString Backend::getBremse()
{
    double iCurrentGaas = gasZahl.toDouble() + dGas ;

    int i = iCurrentGaas;

    return QString::number(iCurrentGaas);
}


void Backend::setGear(QString str)
{

}

QString Backend::getGear()
{
    //int iCurrentGear = gearZahl.toInt() + iGear ;

    return QString::number(iGear);
}

void Backend::setKm(QString s)
{
    /*v1
    s = "Set KMFunction started";
    qDebug()<<s;
    QString st = getStatus();
    double zeit = iSecondTwo;
    if(st=="D")
    {
        int speed = getGas().toInt();
        if (speed!=0)
        {   //double zeit= getTime().toDouble();

            double d;
            zeit = zeit/3600;
            d= speed * zeit;   //distance = speed * time
            iKM += d;
        }
    }
    else
    {
        int speed = getReversegear().toInt();
        if (speed!=0)
        {   //double zeit= getTime().toDouble();

            double d;
            zeit = zeit/3600;
            d= speed * zeit;   //distance = speed * time
            iKM += d;
        }

    }
    */
    s = "Set KMFunction started";
    //qDebug()<<s;
    QString st = getStatus();
    double zeit = iSecondTwo;
    if(st=="D")
    {
        int speed = getGas().toInt();
        if (speed!=0)
        { //double zeit= getTime().toDouble();
            double d;
            zeit = zeit/3600;
            d= speed * zeit; //distance = speed * time
            setDistCov(d);
            iKM += d;
        }
    }
    else
    {
        int speed = getReversegear().toInt();
        if (speed!=0)
        { //double zeit= getTime().toDouble();

            double d;
            zeit = zeit/3600;
            d= speed * zeit; //distance = speed * time
            setDistCov(d);
            iKM += d;
        }

    }
}
QString Backend::getKm()
{
    return QString::number(iKM);

}

void Backend::setVerbrauch(QString s)
{
    s ="setVerbrach fn";
    //qDebug()<<s;
    QString st = getStatus();

    int speed;
    if(st=="D")
    {
        speed = getGas().toInt();

    }
    else if (st == "R")
    {
        speed = getReversegear().toInt();
    }
    if (speed <= 50)
    {
        iMileage = 14.8;
    }
    else if (speed >= 50 && speed <= 280)
    {
        iMileage = 8.6;
    }
}

QString Backend::getVerbrauch()
{
    return QString::number(iMileage);
}

void Backend::setFuelRem(QString s)
{
    /*v1
    s= "Fuel Rem function";
    qDebug()<<s;

    double mileage =getVerbrauch().toDouble() ;

    double km = getKm().toDouble();

    double fuelUsed = (mileage * km)/100;


    iFuelRem -= fuelUsed;
    */

    s= "Fuel Rem function";
    //qDebug()<<s;

    double mileage =getVerbrauch().toDouble() ;

    //double km = getKm().toDouble();
    double km = getDistCov();
    //qDebug()<<"Distance Covered" +QString::number(km);
    double fuelUsed = (mileage * km)/100;


    iFuelRem -= fuelUsed;

}
QString Backend::getFuelRem()
{
    //qDebug()<<iFuelRem;
    return QString::number(iFuelRem);
}
void Backend::setRpm(QString s)
{
    /* v1
    s= "SetRpmfunction";

    iRpm = 800 ;
    */

    /*v2
    double gangUebersetzungen{};
    double achsAntrieb = 4.88;
    double radDurchmesser = 0.75/1000; //in km
    switch (iGear) {
    case 0: gangUebersetzungen = 0; break;
    case 1: gangUebersetzungen = 4.16; break;
    case 2: gangUebersetzungen = 2.27; break;
    case 3: gangUebersetzungen = 1.43; break;
    case 4: gangUebersetzungen = 1; break;
    case 5: gangUebersetzungen = 0.88; break;
    default: gangUebersetzungen = 3.83;
    }

    iRpm = (dGas*gangUebersetzungen*achsAntrieb)/(3.141592*radDurchmesser*60);
    */
    QString st = getStatus();

    double gangUebersetzungen{};
    double achsAntrieb = 4.88;
    double radDurchmesser = 0.75/1000; //in km
    if(st=="D"){
        switch (iGear) {
        case 0: gangUebersetzungen = 0; break;
        case 1: gangUebersetzungen = 4.16; break;
        case 2: gangUebersetzungen = 2.27; break;
        case 3: gangUebersetzungen = 1.43; break;
        case 4: gangUebersetzungen = 1; break;
        case 5: gangUebersetzungen = 0.88; break;
        default: gangUebersetzungen = 0;
        }

        iRpm = (dGas*gangUebersetzungen*achsAntrieb)/(3.141592*radDurchmesser*60);
    }
    else if(st=="R"){ //vorher war D
        gangUebersetzungen = 3.83;
        iRpm = (dGasReversegear*gangUebersetzungen*achsAntrieb)/(3.141592*radDurchmesser*60);
    }
    else if(st=="P" || st=="N"){
        gangUebersetzungen = 0;
        iRpm = (dGasReversegear*gangUebersetzungen*achsAntrieb)/(3.141592*radDurchmesser*60);
    }
}
QString Backend::getRpm()
{
    return QString::number(iRpm);
}
