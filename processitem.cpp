#include "processitem.h"

ProcessItem::ProcessItem() {
    m_t1 = 0;
    m_t2 = 0;
    m_t3 = 0;
    m_t4 = 0;
    m_setpoint = 0;
    m_coolMode = false; // false - only one sensor, true - all sensers
    m_state = 0; // 0 - empty, 1 - cooling, 2 - ready
    m_target = 0; // target production line
    m_productName = "Product";
    m_discharged = false;
    m_offline = false;
}

float ProcessItem::t1() const
{
    return m_t1;
}

void ProcessItem::setT1(float newT1)
{
    m_t1 = newT1;
}

float ProcessItem::t2() const
{
    return m_t2;
}

void ProcessItem::setT2(float newT2)
{
    m_t2 = newT2;
}

float ProcessItem::t3() const
{
    return m_t3;
}

void ProcessItem::setT3(float newT3)
{
    m_t3 = newT3;
}

float ProcessItem::t4() const
{
    return m_t4;
}

void ProcessItem::setT4(float newT4)
{
    m_t4 = newT4;
}

float ProcessItem::setpoint() const
{
    return m_setpoint;
}

void ProcessItem::setSetpoint(float newSetpoint)
{
    m_setpoint = newSetpoint;
}

bool ProcessItem::coolMode() const
{
    return m_coolMode;
}

void ProcessItem::setCoolMode(bool newCoolMode)
{
    m_coolMode = newCoolMode;
}

int ProcessItem::state() const
{
    return m_state;
}

void ProcessItem::setState(int newState)
{
    m_state = newState;
}

int ProcessItem::target() const
{
    return m_target;
}

void ProcessItem::setTarget(int newTarget)
{
    m_target = newTarget;
}

QString ProcessItem::productName() const
{
    return m_productName;
}

void ProcessItem::setProductName(const QString &newProductName)
{
    m_productName = newProductName;
}

bool ProcessItem::discharged() const
{
    return m_discharged;
}

void ProcessItem::setDischarged(bool newDischarged)
{
    m_discharged = newDischarged;
}

bool ProcessItem::offline() const
{
    return m_offline;
}

void ProcessItem::setOffline(bool newOffline)
{
    m_offline = newOffline;
}
