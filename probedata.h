#ifndef PROBEDATA_H
#define PROBEDATA_H

class ProbeData
{
public:
    ProbeData();

    float t1() const;
    void setT1(float newT1);

    float t2() const;
    void setT2(float newT2);

    float t3() const;
    void setT3(float newT3);

    float t4() const;
    void setT4(float newT4);

    float battery() const;
    void setBattery(float newBattery);

    bool online() const;
    void setOnline(bool newOnline);

private:
    float m_t1;
    float m_t2;
    float m_t3;
    float m_t4;
    float m_battery;
    bool m_online;
};

#endif // PROBEDATA_H
