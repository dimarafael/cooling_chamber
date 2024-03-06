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

private:
    QString m_name;
    float m_setpoint;
    bool m_coolMode; // false - only one sensor, true - all sensers
};

#endif // PRODUCT_H
