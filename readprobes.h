#ifndef READPROBES_H
#define READPROBES_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QRandomGenerator>
#include "probedata.h"
#include <QVariant>
#include <QModbusTcpClient>

#define N_PROBES 12

// #define SIMULATION

class ReadProbes : public QObject
{
    Q_OBJECT
public:
    // explicit ReadProbes(QObject *parent = nullptr);
    ReadProbes();
    ~ReadProbes();

signals:
    void dataReady(QVector<ProbeData> data);
    void updateConnectedState(bool connected);
public slots:
    void run(); // for starting thread

private slots:
    void readData(); // connect to timeout of timer
    void processStateChanged(QModbusClient::State state);
    void processOnlineStatus();
    void processTemperatures();

private:
    QVector<ProbeData> *m_probes;
    QTimer *m_timer;
    QModbusTcpClient *mc = nullptr;
    QVector<quint16> *vData;
    QModbusDataUnit *du;
    int m_currentDevice; // for polling devices in loop

    void incrementCurrentDevice(bool isOnline); // if not online, set this device as offline
    float quit16ToFloat(quint16);
};

#endif // READPROBES_H
