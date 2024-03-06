#include "product.h"

Product::Product() {
    m_name = "";
    m_setpoint = 0;
    m_coolMode = false;
}

QString Product::name() const
{
    return m_name;
}

void Product::setName(const QString &newName)
{
    m_name = newName;
}

float Product::setpoint() const
{
    return m_setpoint;
}

void Product::setSetpoint(float newSetpoint)
{
    m_setpoint = newSetpoint;
}

bool Product::coolMode() const
{
    return m_coolMode;
}

void Product::setCoolMode(bool newCoolMode)
{
    m_coolMode = newCoolMode;
}
