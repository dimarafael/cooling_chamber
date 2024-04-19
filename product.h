#ifndef PRODUCT_H
#define PRODUCT_H

#include <QString>

class Product
{
public:
    Product();

    QString name() const;
    void setName(const QString &newName);

    float setpoint() const;
    void setSetpoint(float newSetpoint);

    bool coolMode() const;
    void setCoolMode(bool newCoolMode);

    float setpoint2() const;
    void setSetpoint2(float newSetpoint2);

private:
    QString m_name;
    float m_setpoint;
    float m_setpoint2; // setpoint for lowest temperature
    bool m_coolMode; // false - only one sensor, true - all sensers
};

#endif // PRODUCT_H
