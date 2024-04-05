#include "lamp.h"

Lamp::Lamp(QObject *parent)
    : QObject{parent}
{
    QFile file("/sys/class/gpio/export");
    if(file.open(QIODevice::WriteOnly)){
        file.write("24", 2);
    }
    file.close();
    file.setFileName("/sys/class/gpio/gpio24/direction");
    if(file.open(QIODevice::WriteOnly)){
        file.write("out", 3);
    }
    file.close();
}
