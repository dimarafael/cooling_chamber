#include "probedata.h"

ProbeData::ProbeData() {
    m_t1 = 0;
    m_t2 = 0;
    m_t3 = 0;
    m_t4 = 0;
    m_battery = 0;
    m_online = false;
}

float ProbeData::t1() const
{
    return m_t1;
}

void ProbeData::setT1(float newT1)
{
    m_t1 = newT1;
}

float ProbeData::t2() const
{
    return m_t2;
}

void ProbeData::setT2(float newT2)
{
    m_t2 = newT2;
}

float ProbeData::t3() const
{
    return m_t3;
}

void ProbeData::setT3(float newT3)
{
    m_t3 = newT3;
}

float ProbeData::t4() const
{
    return m_t4;
}

void ProbeData::setT4(float newT4)
{
    m_t4 = newT4;
}

float ProbeData::battery() const
{
    return m_battery;
}

void ProbeData::setBattery(float newBattery)
{
    m_battery = newBattery;
}

bool ProbeData::online() const
{
    return m_online;
}

void ProbeData::setOnline(bool newOnline)
{
    m_online = newOnline;
}


