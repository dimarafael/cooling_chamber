#ifndef PROCESSITEM_H
#define PROCESSITEM_H
#include <QString>

class ProcessItem
{
public:
    ProcessItem();

    float t1() const;
    void setT1(float newT1);

    float t2() const;
    void setT2(float newT2);

    float t3() const;
    void setT3(float newT3);

    float t4() const;
    void setT4(float newT4);

    float setpoint() const;
    void setSetpoint(float newSetpoint);

    bool coolMode() const;
    void setCoolMode(bool newCoolMode);

    int state() const;
    void setState(int newState);

    int target() const;
    void setTarget(int newTarget);

    QString productName() const;
    void setProductName(const QString &newProductName);

    bool discharged() const;
    void setDischarged(bool newDischarged);

    bool offline() const;
    void setOffline(bool newOffline);

    float setpoint2() const;
    void setSetpoint2(float newSetpoint2);

private:
    float m_t1;
    float m_t2;
    float m_t3;
    float m_t4;
    float m_setpoint;
    float m_setpoint2; // setpoint for lowest temperature
    bool m_coolMode; // false - only one sensor, true - all sensers
    int m_state; // 0 - empty, 1 - cooling, 2 - ready
    int m_target; // target production line | 1, 2, 3
    QString m_productName;
    bool m_discharged;
    bool m_offline;
};

#endif // PROCESSITEM_H
