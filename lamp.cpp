#include "lamp.h"

Lamp::Lamp(QObject *parent)
    : QObject{parent}
{
    m_process.execute("echo 24 > /sys/class/gpio/export");
}
