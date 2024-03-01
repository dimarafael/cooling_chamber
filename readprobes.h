#ifndef READPROBES_H
#define READPROBES_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QRandomGenerator>
#include "probedata.h"

#define N_PROBES 12

#define SIMULATION

class ReadProbes : public QObject
{
    Q_OBJECT
public:
    // explicit ReadProbes(QObject *parent = nullptr);
    ReadProbes();
    ~ReadProbes();

signals:
    void dataReady(QVector<ProbeData> data);
public slots:
    void run(); // for starting thread

private slots:
    void readData(); // connect to timeout of timer

private:
    QVector<ProbeData> *m_probes;
    QTimer *m_timer;
};

#endif // READPROBES_H
