#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QDebug>
#include <QtMath>
#include <QElapsedTimer>
#include <QTimer>
#include <QTime>
#include <cmath>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString GasGeben READ getGas WRITE setGas )
    Q_PROPERTY(QString Bremsen READ getBremse WRITE setBremse)
    Q_PROPERTY(QString PowerZahl READ getPower WRITE setPower)
    Q_PROPERTY(QString TimerStarted READ getTime WRITE setTime)
    Q_PROPERTY(QString GearZahl READ getGear WRITE setGear)
    Q_PROPERTY(QString KmZahl READ getKm WRITE setKm CONSTANT)
    Q_PROPERTY(QString Mileage READ getVerbrauch WRITE setVerbrauch)
    Q_PROPERTY(QString FuelRem READ getFuelRem WRITE setFuelRem)
    Q_PROPERTY(QString Drehzahl READ getRpm WRITE setRpm)
    Q_PROPERTY(QString Reversegear READ getReversegear WRITE setReversegear)
    Q_PROPERTY(QString AutoStatus READ getStatus WRITE setStatus)
    Q_PROPERTY(QString RevBremsen READ getRevBremse WRITE setRevBremse)

public:
    explicit Backend(QObject *parent = nullptr);

    void setGas(QString);
    QString getGas();

    void setTime(QString);
    QString getTime();

    void setPower(QString);
    QString getPower();

    void setBremse(QString);
    QString getBremse();

    void setGear(QString);
    QString getGear();

    void setKm(QString);
    QString getKm();

    void setVerbrauch(QString);
    QString getVerbrauch();

    void setFuelRem(QString);
    QString getFuelRem();

    void setRpm(QString);
    QString getRpm();

    QString getReversegear();
    void setReversegear(QString);

    QString getRevBremse();
    void setRevBremse(QString);

    QString getStatus();
    void setStatus(QString);

    void setDistCov(double);
    double getDistCov();

private:
    int iSecondOne {0} ;
    int iSecondTwo{1};
    int iPower = 0;
    QString powerZahl{"0"};
    int iPowerCondition = 0;
    double dGasReversegear = 0 ;
    QString gasZahlReversegear{"0"};

    QString Status = "P";

    double distCov = 0;

    double dGas = 0 ;
    QString gasZahl{"0"};

    int iGear = 1 ;
    QString gearZahl{"1"};

    int iBremese = 5;


    double iKM = 0 ;
    double iFuelRem{20};

    double iMileage =0;


    int iRpm=800 ;
    int cylinder = 4;
};

#endif // BACKEND_H
