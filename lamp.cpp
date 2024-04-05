#include "lamp.h"

Lamp::Lamp(QObject *parent)
    : QObject{parent}
{
    file.setFileName("/sys/class/gpio/export");
    if(file.open(QIODevice::WriteOnly)){
        file.write("24", 2);
    }
    file.close();
    file.setFileName("/sys/class/gpio/gpio24/direction");
    if(file.open(QIODevice::WriteOnly)){
        file.write("out", 3);
    }
    file.close();


    m_timer = new QTimer(this);
    m_timer->setInterval(500);
    connect(m_timer, &QTimer::timeout, this, &Lamp::timeout);
}

void Lamp::start()
{
    if(!m_timer->isActive()){
        m_timer->start();
        onLamp();
    }
}

void Lamp::stop()
{
    m_timer->stop();
    offLamp();
}

void Lamp::timeout()
{
    if(m_lampState){
        offLamp();
    } else{
        onLamp();
    }
}

void Lamp::onLamp()
{
    file.setFileName("/sys/class/gpio/gpio24/value");
    if(file.open(QIODevice::WriteOnly)){
        file.write("1", 1);
        m_lampState = true;
    }
    file.close();
}

void Lamp::offLamp()
{
    file.setFileName("/sys/class/gpio/gpio24/value");
    if(file.open(QIODevice::WriteOnly)){
        file.write("0", 1);
        m_lampState = false;
    }
    file.close();
}
